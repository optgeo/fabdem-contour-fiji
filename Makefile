SRC_DIR = /Users/hfu/Downloads/S20E170-S10W180_FABDEM_V1-2
INTERVAL = 10
DST_PATH = fabdem-fiji.pmtiles

convert:
	gdal_merge -o a.tif $(SRC_DIR)/*.tif
	gdal_contour -a h -i $(INTERVAL) a.tif a.shp
	ogr2ogr -f GeoJSONSeq -lco COORDINATE_PRECISION=12 /vsistdout/ a.shp | \
	ruby filter.rb | tippecanoe -f -o $(DST_PATH) --maximum-zoom=14 --minimum-zoom=9

upload:
	aws s3 cp $(DST_PATH) s3://us-west-2.opendata.source.coop/smartmaps/foil4gr1/	
