function countIncrements(data : {string})
    local lastValue = math.huge
    local numberIncrements = 0
    for _,valueString in pairs(data) do
        local value = tonumber(valueString)
        if (value > lastValue) then
            numberIncrements += 1
        end
        lastValue = value
    end
    return numberIncrements
end

return function (input : string, helpers)
    local parsers = helpers.Parsers
    local inputLines = require(parsers.SplitNewLines)(input)
    return countIncrements(inputLines)
end