--[[
    Given an array of strings, convert every value into a number.
]]

return function (values : {string}) : {number}
    local result = { }
    for index,value in pairs(values) do
        result[index] = tonumber(value)
    end
    return result
end