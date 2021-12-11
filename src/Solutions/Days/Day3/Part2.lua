--[[
    Day 3 Part 2.

    Description / Preamble:
        Day 3 Part 2 asks to verify the Life Support Rating, which is determined by multiplying the Oxygen Generator Rating by the CO2 Scrubber Rating.

        Both of these are based on the same set of binary numbers as Part 1. To determine the two values, we filter through the list, considering one bit at a time.
        We start with the first bit, then proceed through the entire list until we're left with one number for each. These give us our two values.

        The filtering system works through a process of: 
            From the entire list, determine which bit appears more often (0 or 1).
                The Oxygen Generator Rating uses the more common bit; the CO2 Scrubber Rating uses the less common bit.
            Taking the bit in question (either a 0 or a 1, depending on what we're looking for), filter down the list.
                The filter here is that we only take values that have the matching bit (so if we're looking for 1s, we remove all numbers where the bit = 0).
            We then move to the next bit, and repeat through the entire list, until we're left with one number for each value.
    
    Task:
        Figure out the Oxygen Generator Rating and CO2 Scrubber Rating, then multiply these together to form the Life Support Rating.
    
    Solution:
        This solution builds on the solution for Part 1. We already have a method to count the bits, so we can use this to determine our counts for this problem.
        From there, we filter down our list, and push forward repeatedly through each bit until we're left with number for each.

        

    
]]

local getCharacterList = require(script.Parent.GetListByCharacterAtIndex)

-- Generic function for building up a new character list.
-- Runs for each step, determines the list to move forward with.
-- ShouldKeepCurrentList takes in: The value of the character being checked; the list that we're moving forward with currently; the new list that we're checking.
--  Should return true if we want to use the new list, otherwise return false.
local function calculateNextCharacterList(characterLists: {string: {string}}, shouldKeepCurrentList: (string, {string}, {string})->boolean) : {string}
    local currentList = nil
    for key,values in pairs(characterLists) do
        if not currentList or not shouldKeepCurrentList(key, currentList, values) then
            currentList = values
        end
    end
    return currentList
end

-- Determines a rating, given the list of all binary values, and a comparison function to determine if we should move to a new list at each step.
local function determineRating(listOfValues: {string}, shouldKeepCurrentList: (string, {string}, {string})->{string}) : number
    local index = 1
    while #listOfValues > 1 do
        local newCharacterLists = getCharacterList(listOfValues, index)
        listOfValues = calculateNextCharacterList(newCharacterLists, shouldKeepCurrentList)
        index += 1
    end
    return tonumber(listOfValues[1], 2)
end

-- The CO2 Scrubber Rating takes the less common value at each bit.
local function determineCO2ScrubberRating(listOfValues : {string}) : number
    return determineRating(listOfValues, function(key : string, keptSoFar: {string}, listCheckingAgainst: {string}) : boolean
        return (#listCheckingAgainst == #keptSoFar and key == '0') or #listCheckingAgainst < #keptSoFar;
    end)
end

-- The Oxygen Generator Rate takes the more common value at each bit.
-- As we parse through the list, we'll filter down, until we're left with one value.
local function determineOxygenGeneratorRate(listOfValues : {string}) : string
    return determineRating(listOfValues, function(key: string, keptSoFar: {string}, listCheckingAgainst: {string}) : boolean
        return (#keptSoFar == #listCheckingAgainst and key == "1") or #listCheckingAgainst > #keptSoFar;
    end)
end

return function(input : string, helpers)
    local parsers = helpers.Parsers
    local inputLines = parsers.SplitNewLines(input)
    
    local oxygenGeneratorRate = determineOxygenGeneratorRate(inputLines)
    local co2ScrubberRating = determineCO2ScrubberRating(inputLines)

    print("Oxygen Generator Rate: ", oxygenGeneratorRate)
    print("CO2 Scrubber Rating: ", co2ScrubberRating)

    return oxygenGeneratorRate * co2ScrubberRating
end