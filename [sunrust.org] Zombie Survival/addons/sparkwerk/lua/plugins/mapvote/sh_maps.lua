SparkWerk.RecommendedGreenMaps = 24

local map_list_file_base = "server_maplist"

function SparkWerk.VoteMapListFile()
    return map_list_file_base .. "_" .. engine.ActiveGamemode() .. ".txt"
end

function SparkWerk.MapImagesDirectory()
    return "/map_images/"
end

function SparkWerk.MapImagesDataDirectory()
    return "/map_images/"
end