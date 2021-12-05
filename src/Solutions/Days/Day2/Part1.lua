--[[
    Day 2 Part 1.

    Description / Preamble:
        The input will contain several movements.
        Every movement has a Type and an Amount.
        There are three types of movements:
            Forward
            Up
            Down

        We will also track a position. The position has a Depth and a Horizontal Position.
        Forward affects the horizontal position, whereas Up/Down affect the depth.

    Task:
        Starting from (0, 0), determine the final depth and horizontal position after a series of movements.
        Multiply the Depth by the Horizontal Position to get the final result (a single number).
    
    Solution:
        Start with a Vector2 position, where X defines the horizontal position, and Y determines the depth. This starts at (0, 0).
        For every line of input, determine the type (Forward/Up/Down) and the amount, and add this to the Vector2 position.
        Once we've run through every line, we'll have a final position that we can use to calculate our result.

    Runtime:
        We need to run through n lines of input, and every input will take constant time (simple data manipulation).
        This runs in O(n) time.
]]

local moveMultipliers = {
    forward = Vector2.new(1, 0),
    up = Vector2.new(0, -1),
    down = Vector2.new(0, 1)
}

-- Applies a movement.
-- Parameters:
--      @currentPosition : Vector2 : The current position so far.
--      @movementType : string : The type of move we want to make (forward, up, down)
--      @amount : number : The amount that we're moving by.
-- Returns a new Vector2 object, which is our position after the movement.
function applyMovement(currentPosition : Vector2, movementType : string, amount : number) : Vector2
    movementType = movementType:lower()

    -- Check that the movement exists; if not, we need to throw an error here
    assert(moveMultipliers[movementType], "Unknown Movement Type: " .. movementType)

    -- Can determine how much we want to move by using the moveMultipliers.
    -- Then we multiply the multiplier by the amount that we want to move by, and apply this to our current position.
    local movementOffset = moveMultipliers[movementType] * amount
    return currentPosition + movementOffset
end

return function (input : string, helpers) : number
    local parsers = helpers.Parsers
    
    local inputLines = parsers.SplitNewLines(input)
    local currentPosition = Vector2.new(0, 0)

    for _,line in pairs(inputLines) do
        local movementData = parsers.Split(line, " ")
        local movementType = movementData[1]
        local movementAmount = tonumber(movementData[2])

        currentPosition = applyMovement(currentPosition, movementType, movementAmount)
    end

    return currentPosition.X * currentPosition.Y
end