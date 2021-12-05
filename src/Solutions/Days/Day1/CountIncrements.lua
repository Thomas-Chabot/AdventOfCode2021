--[[
    Returns a simple function to count the number of times that an array increments.
        That is, where every value Array[i] is higher than Array[i - 1].
]]

return function (values : {number}) : number
    local numberOfIncrements = 0
    for i = 2,#values do
        if values[i] > values[i - 1] then
            numberOfIncrements += 1
        end
    end
    return numberOfIncrements
end