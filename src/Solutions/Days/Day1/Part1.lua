function countIncrements(data : {number})
    local lastValue = -math.huge
    local numberIncrements = 0
    for _,value in pairs(data) do
        if (value > lastValue) then
            numberIncrements += 1
            lastValue = value
        end
    end
    return numberIncrements
end

