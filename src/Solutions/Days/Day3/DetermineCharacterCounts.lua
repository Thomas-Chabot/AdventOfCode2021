--[[
    Determines all characters that appear in the given line of a string, and the number of times that character appears.
    Returns the result as a dictionary of:
        Character: Occurences
]]
return function(inputLines : {string}, characterIndex : number) : {string: number}
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