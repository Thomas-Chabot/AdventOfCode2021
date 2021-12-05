--[[
    Trims a string, removing all whitespace characters from the start and end of the string.
]]
return function(str : string)
    return str:gsub("^%s*(.-)%s*$", "%1")
end