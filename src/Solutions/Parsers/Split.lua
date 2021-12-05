--[[
    Performs a string split.
    Will return a list of new strings, separated by the separation character.
]]

local trim = require(script.Parent.Trim)
return function (input : string, separator : string) : {string}
    input = trim(input)

    local result = { }
    for string in string.gmatch(input, "([^" .. separator .. "]+)") do
        table.insert(result, string)
    end
    return result
end

