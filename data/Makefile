all: ne_110m_admin_0_countries.shp ne_110m_admin_0_countries.gpkg ne_110m_admin_0_countries.fgb \
     ne_110m_admin_0_countries.json ne_110m_admin_0_countries.arrow ne_110m_admin_0_countries_zstd.gpkg \
     ne_110m_admin_0_countries.gpkg.gz ne_110m_admin_0_countries.fgb.gz ne_110m_admin_0_countries.json.gz \
     ne_110m_admin_0_countries.arrow.gz ne_110m_admin_0_countries_zstd.gpkg.gz \
     countries.fgb countries.gpkg countries.shp countries.json countries.arrow countries_zstd.gpkg \
     countries.fgb.gz countries.gpkg.gz countries.json.gz countries.arrow.gz countries_zstd.gpkg.gz \
     UScounties.fgb UScounties.gpkg UScounties.shp UScounties.json UScounties.arrow UScounties_zstd.gpkg \
     UScounties.fgb.gz UScounties.gpkg.gz UScounties.json.gz UScounties.arrow.gz UScounties_zstd.gpkg.gz

libsqlite_zstd.so:
	wget https://github.com/phiresky/sqlite-zstd/releases/download/v0.3.2/sqlite_zstd-v0.3.2-x86_64-unknown-linux-gnu.tar.gz -O - | tar --strip-components=1 -xz



%.json: %.gpkg
	ogr2ogr -f "GeoJSON" $@ $<

%.arrow: %.gpkg
	docker run --rm --user $$(id -u):$$(id -g) -v $$PWD:/data osgeo/gdal:alpine-normal-latest ogr2ogr /data/$@ /data/$< -lco COMPRESSION=NONE -lco GEOMETRY_ENCODING=WKB

%.gz: %
	gzip --keep -f $<


ne_110m_admin_0_countries.zip:
	wget -O $@ https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/ne_110m_admin_0_countries.zip

ne_110m_admin_0_countries.shp: ne_110m_admin_0_countries.zip
	unzip $<
	chmod -x *.shp *.shx *prj *dbf
	touch $@

ne_110m_admin_0_countries.gpkg: ne_110m_admin_0_countries.shp
	ogr2ogr -f GPKG -nlt PROMOTE_TO_MULTI $@ $<
	#echo "PRAGMA journal_mode = MEMORY" | sqlite3 $@
	sqlite3 $@ "DELETE FROM gpkg_spatial_ref_sys WHERE srs_id <> 4326; VACUUM;"

ne_110m_admin_0_countries.fgb: ne_110m_admin_0_countries.gpkg
	docker run --rm --user $$(id -u):$$(id -g) -v $$PWD:/data osgeo/gdal:alpine-normal-latest ogr2ogr -f FlatGeoBuf /data/$@ /data/$<

ne_110m_admin_0_countries_zstd.gpkg: ne_110m_admin_0_countries.gpkg
	ogr2ogr -f GPKG $@ $<
	sqlite3 $@ "DELETE FROM gpkg_spatial_ref_sys WHERE srs_id <> 4326; VACUUM;"
	#sqlite3 $@ '.dump ne_110m_admin_0_countries' >/tmp/ne_110m_admin_0_countries.sql
	echo 'SELECT zstd_enable_transparent('\''{"table": "ne_110m_admin_0_countries", "column": "geom", "compression_level": 19, "min_dict_size_bytes_for_training": 1, "dict_chooser": "'\'\''wkb'\'\''"}'\'');' | sqlite3 -cmd '.load ./libsqlite_zstd' $@
	# Warning: It is recommended to set `pragma journal_mode=WAL;`
	# Warning: It is recommended to set `pragma auto_vacuum=full;`
	# Warning: It is recommended to set `pragma busy_timeout=2000;` or higher
	#sqlite3 $@ 'DELETE FROM ne_110m_admin_0_countries'
	#cat /tmp/ne_110m_admin_0_countries.sql | spatialite -silent -cmd '.load ./libsqlite_zstd' $@
	SQLITE_ZSTD_LOG=debug spatialite -silent -cmd '.load ./libsqlite_zstd' $@ "pragma auto_vacuum=full; pragma busy_timeout=2000; SELECT zstd_incremental_maintenance(null, 1); VACUUM;"


countries.fgb:
	wget -O $@ https://github.com/flatgeobuf/flatgeobuf/raw/master/test/data/countries.fgb
	touch $@

countries.gpkg: countries.fgb
	docker run --rm --user $$(id -u):$$(id -g) -v $$PWD:/data osgeo/gdal:alpine-normal-latest ogr2ogr -f GPKG /data/$@ /data/$<
	sqlite3 $@ "DELETE FROM gpkg_spatial_ref_sys WHERE srs_id <> 4326; VACUUM;"

countries.shp: countries.gpkg
	ogr2ogr -f "ESRI Shapefile" -lco SPATIAL_INDEX=YES -lco ENCODING=UTF-8 $@ $<

countries_zstd.gpkg: countries.gpkg
	ogr2ogr -f GPKG $@ $<
	sqlite3 $@ "DELETE FROM gpkg_spatial_ref_sys WHERE srs_id <> 4326; VACUUM;"
	echo 'SELECT zstd_enable_transparent('\''{"table": "countries", "column": "geom", "compression_level": 19, "min_dict_size_bytes_for_training": 1, "dict_chooser": "'\'\''wkb'\'\''"}'\'');' | sqlite3 -cmd '.load ./libsqlite_zstd' $@
	SQLITE_ZSTD_LOG=debug spatialite -silent -cmd '.load ./libsqlite_zstd' $@ "pragma auto_vacuum=full; pragma busy_timeout=2000; SELECT zstd_incremental_maintenance(null, 1); VACUUM;"



UScounties.fgb:
	wget -O $@ https://github.com/flatgeobuf/flatgeobuf/raw/master/test/data/UScounties.fgb
	touch $@

UScounties.gpkg: UScounties.fgb
	docker run --rm --user $$(id -u):$$(id -g) -v $$PWD:/data osgeo/gdal:alpine-normal-latest ogr2ogr -f GPKG /data/$@ /data/$<
	sqlite3 $@ "DELETE FROM gpkg_spatial_ref_sys WHERE srs_id <> 4269; VACUUM;"

UScounties.shp: UScounties.gpkg
	ogr2ogr -f "ESRI Shapefile" -lco SPATIAL_INDEX=YES -lco ENCODING=UTF-8 $@ $<

UScounties_zstd.gpkg: UScounties.gpkg
	ogr2ogr -f GPKG $@ $<
	sqlite3 $@ "DELETE FROM gpkg_spatial_ref_sys WHERE srs_id <> 4269; VACUUM;"
	echo 'SELECT zstd_enable_transparent('\''{"table": "UScounties", "column": "geom", "compression_level": 19, "min_dict_size_bytes_for_training": 1, "dict_chooser": "'\'\''wkb'\'\''"}'\'');' | sqlite3 -cmd '.load ./libsqlite_zstd' $@
	SQLITE_ZSTD_LOG=debug spatialite -silent -cmd '.load ./libsqlite_zstd' $@ "pragma auto_vacuum=full; pragma busy_timeout=2000; SELECT zstd_incremental_maintenance(null, 1); VACUUM;"



stats:
	nu stats.nu >sizes.txt
