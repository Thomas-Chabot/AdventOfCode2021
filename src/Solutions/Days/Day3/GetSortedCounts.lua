--[[
    Takes in a dictionary of { character: Count } values.
    Stores the Characters and Counts inside an array, and sorts them by order of occurence (least first).

    Result is an array, where each value is: 
        Character: string,
        Count: number
]]
type SortedCharacterCounts = {
    Character: string,
    Count: number
}

return function(counts: {string : number}) : {SortedCharacterCounts}
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
