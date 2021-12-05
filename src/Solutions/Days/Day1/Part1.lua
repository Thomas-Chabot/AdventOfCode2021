--[[
    Day 1, Part 1

    Task:
        Given an array of numbers, calculate the number of times that the current number increments from the previous.
        Eg. given 1, 7, 3, 6 -> 7 is higher than 1, and 6 is higher than 3. So this gives a total of 2.
    
    Solution:
        This is a simple for loop. At every index (from 1 .. n), compare the current value (Array[i]) against the previous value (Array[i - 1]).
        If Array[i] > Array[i - 1], increment the counter.
        At the end of the for loop, return the value of the counter.

    Running Time:
        This is a simple pass through the array, so it has a running time O(n).
]]
local countIncrements = require(script.Parent.CountIncrements)
return function (input : string, helpers)
    local parsers = helpers.Parsers
    local inputLines = parsers.SplitNewLines(input)
    local inputValues = parsers.ToNumbers(inputLines)
    return countIncrements(inputValues)
end