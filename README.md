# Vector data compression experiments

## zstd compression of WKB

GeoPackage with Zstandard compressed WKB using https://github.com/phiresky/sqlite-zstd

## Creating datasets

Prepare data:

    cd data
    make

Create statistics:

    make stats


## Results

* ne_110m_admin_0_countries.gpkg: 177 Polygons, 178 attribute columns (mostly short strings)

```md
╭───┬─────────────────────────────────────┬───────────╮
│ # │                name                 │   size    │
├───┼─────────────────────────────────────┼───────────┤
│ 0 │ ne_110m_admin_0_countries.arrow     │ 474.7 KiB │
│ 1 │ ne_110m_admin_0_countries.fgb       │ 478.2 KiB │
│ 2 │ ne_110m_admin_0_countries.gpkg      │ 552.0 KiB │
│ 3 │ ne_110m_admin_0_countries_zstd.gpkg │ 632.0 KiB │
│ 4 │ ne_110m_admin_0_countries.shp       │ 697.5 KiB │
│ 5 │ ne_110m_admin_0_countries.json      │   1.1 MiB │
╰───┴─────────────────────────────────────┴───────────╯
```

* countries.gpkg: 177 Polygons, 2 attribute columns

```
╭───┬─────────────────────┬───────────╮
│ # │        name         │   size    │
├───┼─────────────────────┼───────────┤
│ 0 │ countries.arrow     │ 181.9 KiB │
│ 1 │ countries.fgb       │ 200.9 KiB │
│ 2 │ countries.shp       │ 206.8 KiB │
│ 3 │ countries_zstd.gpkg │ 296.0 KiB │
│ 4 │ countries.json      │ 297.5 KiB │
│ 5 │ countries.gpkg      │ 316.0 KiB │
╰───┴─────────────────────┴───────────╯
```

* UScounties.gpkg: 3221 Polygons, 6 attribute columns

```
╭───┬──────────────────────┬──────────╮
│ # │         name         │   size   │
├───┼──────────────────────┼──────────┤
│ 0 │ UScounties_zstd.gpkg │ 10.2 MiB │
│ 1 │ UScounties.arrow     │ 13.0 MiB │
│ 2 │ UScounties.fgb       │ 13.4 MiB │
│ 3 │ UScounties.shp       │ 14.4 MiB │
│ 4 │ UScounties.gpkg      │ 15.4 MiB │
│ 5 │ UScounties.json      │ 23.4 MiB │
╰───┴──────────────────────┴──────────╯
```
