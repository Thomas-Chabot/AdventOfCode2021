--[[
    Splits a list of strings based on the character at the given position.
    The return value will be a new list, where:
        - The key is the character at the given position;
        - The value is a list of strings which each have that character in that position.
]]
return function(inputLines : {string}, characterIndex : number) : {string: {string}}
    local returnValues = { }
    
    -- Determine the counts for each character
    for _,line in ipairs(inputLines) do
        local character = line:sub(characterIndex, characterIndex)
        if not returnValues[character] then
            returnValues[character] = { }
        end
        table.insert(returnValues[character], line)
    end

    return returnValues
end