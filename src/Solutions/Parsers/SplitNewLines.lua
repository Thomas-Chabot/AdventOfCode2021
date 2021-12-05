--[[
    Splits a string by all new lines.
]]

local Split = require(script.Parent.Split)

return function (input : string)
    return Split(input, "\n")
end