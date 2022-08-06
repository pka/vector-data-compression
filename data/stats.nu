# ne_110m_admin_0_countries

let files = (ls ne_*arrow ne_*fgb ne_*gpkg ne_*json)

let shpsize = (ls ne_110m_admin_0_countries.shp ne_110m_admin_0_countries.dbf ne_110m_admin_0_countries.shx | get size | math sum)
let shp = (ls ne_*shp | update size $shpsize)

$files | append $shp | select name size | sort-by size

ls ne_*zip ne_*gz | select name size | sort-by size


# countries

let files = (ls countries*arrow countries*fgb countries*gpkg countries*json)

let shpsize = (ls countries.shp countries.dbf countries.shx | get size | math sum)
let shp = (ls countries*shp | update size $shpsize)

$files | append $shp | select name size | sort-by size

ls countries*gz | select name size | sort-by size


# UScounties

let files = (ls UScounties*arrow UScounties*fgb UScounties*gpkg UScounties*json)

let shpsize = (ls UScounties.shp UScounties.dbf UScounties.shx | get size | math sum)
let shp = (ls UScounties*shp | update size $shpsize)

$files | append $shp | select name size | sort-by size

ls UScounties*gz | select name size | sort-by size
