--[[
    Day 3 Part 1.

    Description / Preamble:
        Day 3 builds up two rates, a Gamma Rate and an Epsilon Rate, by calculating their values off a list of binary numbers.
        The values for each are defined as:
            Gamma Rate = More common bit in each position,
            Epsilon Rate = Less common bit in each position.
        
        For example, given three values:
            101,
            010,
            111,
        
        Then the gamma rate is 111 (because 1 is more common in each position), and the epsilon is 000 (because 0 is less common in each position).
    
    Task:
        Given the list of binary numbers, determine the epsilon and gamma rates, then multiply these together into a single value.
        
    Solution:
        We can store an array containing the counts at each position as we go through the list.
        At the end, we'll have the number of times that each occured, which will allow us to build out the Epsilon and Gamma Rate values.
    
    Running Time:
        This will require one pass through the entire list of values (n steps, n = number of lines),
        At every step we'll walk through every character within the string, which will take m steps (where m is the number of characters in the string),
        Once we have our positions calculated, we need one final pass through each bit to determine the values for Gamma and Epsilon (m steps)
    
        So the running time of this solution is O(n*m + m)
]]

type SortedCharacterCounts = {
    Character: string,
    Count: number
}

local function determineCharacterCounts(inputLines : {string}, characterIndex : number) : {string: number}
    local counts = { }
    
    -- Determine the counts for each character
    for _,line in ipairs(inputLines) do
        local character = line:sub(characterIndex, characterIndex)
        if not counts[character] then
            counts[character] = 0
        end
        counts[character] += 1
    end

    return counts
end

local function getSortedCounts(counts: {string : number}) : {SortedCharacterCounts}
    local resultsArray = { }
    
    -- Store the {character: count} values in an array
    for character,count in pairs(counts) do
        table.insert(resultsArray, {
            Character = character,
            Count = count
        })
    end

    -- Sort the array by number of times the character appears
    table.sort(resultsArray, function(a, b)
        return a.Count < b.Count
    end)

    -- Return the sorted results
    return resultsArray
end

return function (input : string, helpers) : number
    local parsers = helpers.Parsers
    local inputLines = parsers.SplitNewLines(input)

    local minString = { }
    local maxString = { }

    -- The number of characters in every string is the same.
    -- Can pull from the first entry.
    local numberCharacters = #inputLines[1]
    for i = 1,numberCharacters do
        local characterCounts = determineCharacterCounts(inputLines, i)
        local sortedCounts = getSortedCounts(characterCounts)

        -- Min is the first element in the sorted array, max is the last element.
        table.insert(minString, sortedCounts[1].Character)
        table.insert(maxString, sortedCounts[#sortedCounts].Character)
    end

    -- Min and Max represent the Gamma and Epsilon values, respectively, as binary numbers.
    -- Convert these back into decimal
    local gammaRate = tonumber(table.concat(maxString, ""), 2);
    local epsilonRate = tonumber(table.concat(minString, ""), 2);

    -- Multiply these together to get our result
    return gammaRate * epsilonRate
end