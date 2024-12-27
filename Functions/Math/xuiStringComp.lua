--[[

    This file is wholly unused throughout the entire program. It is loaded into the xui.toc because I'm lazy and don't want to update that later.
    This is a project for the medium-long term, after learning that several addons rely upon external libraries to maintain their functionality.
    I do not want to be bound to another company/user for my program to work, as I already rely on companies/users enough as it is.
    Of course, that's not to say that I will not take their ideas and attempt to implement their functionality into my own set of libraries. 

]]
local ns = XUI 

local tinsert = table.insert
local format = string.format 
local rep = string.rep 
local byte = string.byte 
local char = string.char 
local concat = table.concat 

--add the compression to namespace
ns.comp = {}

--character mapping
local charMap = {
    [" "] = "°",
    ["\n"] = "¶",
    ["||"] = "¦",
    ["|r"] = "®",
    ["|c"] = "©",
    ["http://"] = "¤",
    ["https://"] = "¥",
    ["|cff"] = "¢",
    ["|Hitem"] = "½",
    ["|Hspell"] = "§",
    ["|Hachievement"] = "æ",
    ["|Hplayer"] = "þ",
    ["|Htrade"] = "ð",
    ["|Htalent"] = "ø",
    ["|Henchant"] = "€"
}

--encode
local function encodeNumber(n)
    if n <= 90 then 
        return char(n + 33) --ascii table
    end
    return tostring(n)
end

--put it back
local function decodeNumber(s)
    if #s == 1 then 
        return byte(s) - 33
    end
    return tonumber(s)
end

function ns.comp.compress(str)

    if type(str) ~= "string" then return str end

    --replace common patterns from the character map
    for pattern, replacement in pairs(charMap) do 
        str = str:gsub(pattern, replacement)
    end

    --do the compression
    local result = {}
    local count = 1
    local last = str:sub(1, 1)

    for i = 2, #str do 
        local curr = str:sub(i, i)
        if curr == last then 
            count = count + 1
        else
            if count > 3 then 
                tinsert(result, "#" .. encodeNumber(count) .. last)
            else 
                tinsert(result, rep(last, count))
            end
            count = 1
            last = curr
        end
    end

    return concat(result)
end

--decompression
function ns.comp.decompress(str)

    if type(str) ~= "string" then return str end

    --undoing
    local result = {}
    local i = 1

    while i <= #str do 
        if str:sub(i, i) == "#" then 
            local j = i + 1
            while j <= #str and not str:sub(j, j):match("%a") do 
                j = j + 1
            end

            local count = decodeNumber(str:sub(i + 1, j - 1))
            local char = str:sub(j, j)
            tinsert(result, rep(char, count))
            i = j + 1
        else
            tinsert(result, str:sub(i, i))
            i = i + 1
        end
    end

    local decompressed = concat(result)

    --restore og patterns
    for pattern, replacement in pairs(charMap) do 
        decompressed = decompressed:gsub(replacement, pattern)
    end

    return decompressed
end

function ns.comp.decompressTable(tbl)

    if type(tbl) ~= "table" then return tbl end

    local compressed = {}

    for k, v in pairs(tbl) do 
        if type(v) == "string" then 
            decompressed[k] = ns.comp.decompress(v)
        elseif type(v) == "table" then 
            decompressed[k] = ns.comp.decompressTable(v)
        else 
            decompressed[k] = v
        end
    end

    return decompressed 
end