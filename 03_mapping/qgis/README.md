# QGIS

### FishPassage_30k.qlr

This is a QGIS layer file defining and symbolizing all layers required for general fish passage mapping ([see samples](https://www.hillcrestgeo.ca/outgoing/fishpassage/projects/)).

Generally QGIS works well with large provincial datasets, but in your database connection settings, remember to check:

    [x] Don't resolve types of unrestricted columns (GEOMETRY)
    [x] Use estimated table metadata


### 48x36 30k pdfs

When generating pdfs, use the supplied layer file and remember to:
- edit title
- modify selection for records in dbm_mof_50k_grid to match area of interest
- double check that the model displayed is correct:
    + crossings (salmon/steelhead/wct)
    + definite barriers (salmon/steelhead/wct)
    + streams (width=gradient or width=habitat)
- if adding additional legend/text items, check that font matches (arial)
- check that map frame/project CRS matches UTM zone of study area
- modify atlas as required
- export atlas to tif (to reduce file size)
- convert tif to pdf with gdal


