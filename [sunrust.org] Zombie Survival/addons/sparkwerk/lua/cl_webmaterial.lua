
webmaterial = {}
--[[
    for downloading images from the web and saving them as materials
    they will be cached in the data/webmaterial directory for re-use
]]

webmaterial.CacheDirectory = "webmaterial"

-- serverside-checked images that we know haven't been recently updated
local unmodified_cached_images = {}

-- recursively deletes folder and all contents
-- can only be done on subfolders of data/
local function nuke_directory(top_directory_name)
    assert(top_directory_name and #top_directory_name > 0)

    local file_names, directory_names = file.Find(top_directory_name .. "/*", "DATA")

    for _, file_name in pairs(file_names) do
        local file_path = top_directory_name .. "/" .. file_name
        unmodified_cached_images[file_path] = false
        file.Delete(file_path)
    end

    for _, directory_name in pairs(directory_names) do
        nuke_directory(top_directory_name .. "/" .. directory_name)
    end

    file.Delete(top_directory_name)
end

function webmaterial.ClearCache(local_directory)
    local local_directory_suffix = local_directory and ("/" .. local_directory) or ""
    nuke_directory(webmaterial.CacheDirectory .. local_directory_suffix)
end

concommand.Add("webmaterial_clear_cache", function(ply, cmd, args)
    webmaterial.ClearCache(args[1])
end)

local function get_material(data_file_path)
    return Material("data/" .. data_file_path)
end

--[[
    url string:
        url to an image (png or jpg) to be downloaded and made into a material
    local_directory string:
        path within cache to save the image
    completion function(material):
        callback to be called when the material is loaded
]]
function webmaterial.Get(url, local_directory, completion)
    local_directory = webmaterial.CacheDirectory .. "/" .. local_directory
    local file_name = string.match(url, ".*/(.*)$")
    local file_path = local_directory .. "/" .. file_name

    if unmodified_cached_images[file_path] then
        completion(get_material(file_path))
        return
    end

    local last_fetched = file.Time(file_path, "DATA")

    http.Fetch(
        url,
        function(image, size, headers, code)
            if code == 200 then
                file.CreateDir(local_directory)
                file.Write(file_path, image)
            elseif code == 304 then
                -- image is unchanged
            else
                print(string.format("[webmaterial] failed to fetch %s (%s)", file_name, code))
                completion(nil)
                return
            end

            unmodified_cached_images[file_path] = true

            if last_fetched == 0 then
                completion(get_material(file_path))
            end
        end,
        nil,
        -- this allows us to skip file transfer if we have an up-to-date image
        -- but if we need an update (or don't have it), the server will send
        -- the image contents
        {["If-Modified-Since"] = os.date("!%a, %d %b %Y %H:%M:%S GMT", last_fetched)}
    )

    if last_fetched ~= 0 then
        -- we are potentially getting a new image if our current
        -- version is outdated, but since that should be rare, just give
        -- the one we currently have. this means we can't show the updated
        -- image until gmod is restarted, but this provides faster results
        unmodified_cached_images[file_path] = true
        completion(get_material(file_path))
    end
end
