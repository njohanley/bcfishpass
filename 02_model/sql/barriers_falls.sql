DROP TABLE IF EXISTS bcfishpass.barriers_falls;

CREATE TABLE bcfishpass.barriers_falls
(
    barriers_falls_id integer primary key,
    barrier_type text,
    barrier_name text,
    linear_feature_id integer,
    blue_line_key integer,
    downstream_route_measure double precision,
    wscode_ltree ltree,
    localcode_ltree ltree,
    watershed_group_code text,
    geom geometry(Point, 3005),
    -- add a unique constraint so that we don't have equivalent barriers messing up subsequent joins
    UNIQUE (blue_line_key, downstream_route_measure)
);


INSERT INTO bcfishpass.barriers_falls
(
    barriers_falls_id,
    barrier_type,
    barrier_name,
    linear_feature_id,
    blue_line_key,
    downstream_route_measure,
    wscode_ltree,
    localcode_ltree,
    watershed_group_code,
    geom
)
SELECT
    falls_event_id,
   'FALLS' as barrier_type,
    NULL as barrier_name,
    a.linear_feature_id,
    a.blue_line_key,
    a.downstream_route_measure,
    a.wscode_ltree,
    a.localcode_ltree,
    a.watershed_group_code,
    a.geom
FROM bcfishpass.falls_events_sp a
INNER JOIN bcfishpass.watershed_groups g
ON a.watershed_group_code = g.watershed_group_code AND g.include IS TRUE
WHERE a.barrier_ind IS TRUE
ON CONFLICT DO NOTHING;


CREATE INDEX ON bcfishpass.barriers_falls (linear_feature_id);
CREATE INDEX ON bcfishpass.barriers_falls (blue_line_key);
CREATE INDEX ON bcfishpass.barriers_falls (watershed_group_code);
CREATE INDEX ON bcfishpass.barriers_falls USING GIST (wscode_ltree);
CREATE INDEX ON bcfishpass.barriers_falls USING BTREE (wscode_ltree);
CREATE INDEX ON bcfishpass.barriers_falls USING GIST (localcode_ltree);
CREATE INDEX ON bcfishpass.barriers_falls USING BTREE (localcode_ltree);
CREATE INDEX ON bcfishpass.barriers_falls USING GIST (geom);