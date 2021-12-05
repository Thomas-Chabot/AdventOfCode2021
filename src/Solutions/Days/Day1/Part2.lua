--[[
    Part 2:
        Create three-measurement windows, calculating the sum of every three measurements as a whole.
        Calculate the number of these three-measurements where the measurement increases.
    
    Solution:
        We can use the Solution for Part 1 as an assistant here.
        From the array, we can take a first pass to calculate three measurement windows:
            Measurement 1 is Array[0] + Array[1] + Array[2]
            Measurement 2 is Array[1] + Array[2] + Array[3]
            Continue through the entire array.
        Then, we can call to our original comparison function, to calculate how many of these are incremental.
        This gives us:
            O(n) for the initial pass to calculate measurements,
            O(n) for the second pass to check if each is incremented from the last,
            Which gives us a total of O(n) running time.
]]
local countIncrements = require(script.Parent.CountIncrements)

return function(input : string, helpers)
    -- First, convert the input into an array of numbers
    local parsers = helpers.Parsers
    local inputLines = parsers.SplitNewLines(input)
    local inputValues = parsers.ToNumbers(inputLines)

    -- Next, build up the array of three-measurements windows;
    local threeMeasurements = { }
    for i = 3,#inputValues do
        local measurement = inputValues[i] + inputValues[i - 1] + inputValues[i - 2]
        table.insert(threeMeasurements, measurement)
    end

    -- Finally, we can use the same countIncrements function to return how many times the measurement increments
    return countIncrements(threeMeasurements)
end