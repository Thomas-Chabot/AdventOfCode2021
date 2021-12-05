--[[
    Day 2 Part 1.

    Description / Preamble:
        The input will contain several movements.
        Every movement has a Type and an Amount.
        There are three types of movements:
            Forward
            Up
            Down
            
        For this problem, we have a 3D Position made up of:
            X = Horizontal position;
            Y = Depth;
            Z = Aim.

        Up and Down will impact our Aim, whereas Forward will:
            Increase our Horizontal Position by the amount provided,
            Increase our depth by the amount provided multiplied by the Aim.
        
        Up will decrease the aim, whereas Down will increase the aim.
        
    Task:
        Starting from (0, 0, 0), apply a series of Forward, Up, and Down movements, and determine where we end up after all movements have been applied.
        The final result is a single number, equivalent to Horizontal Position * Depth.
    
    Solution:
        Start with a Vector3 position, where:
            X is our horizontal position;
            Y is our depth;
            Z is our aim.
        This position starts at (0, 0, 0).

        For every line of movement, determine the type and amount, and apply the movement logic according to what is described above in the preamble.
        After we run through every line of input, the Vector3 will give us our new depth and horizontal position, which we can use to calculate our result.

    Runtime:
        We need to run through n lines of input, and every input will take constant time (simple data manipulation).
        This runs in O(n) time.
]]

local movementAppliers = {
    up = function(currentPosition : Vector3, amount : number) : Vector3
        return currentPosition - Vector3.new(0, 0, amount)
    end,
    down = function(currentPosition : Vector3, amount : number) : Vector3
        return currentPosition + Vector3.new(0, 0, amount)
    end,
    forward = function(currentPosition : Vector3, amount : number) : Vector3
        -- Increase horizontal position by amount,
        -- Increase depth by amount * aim.
        return currentPosition + Vector3.new(amount, amount * currentPosition.Z, 0)
    end
}

-- Applies a movement.
-- Parameters:
--      @currentPosition : Vector3 : The current position so far.
--      @movementType : string : The type of move we want to make (forward, up, down)
--      @amount : number : The amount that we're moving by.
-- Returns a new Vector3 object, which is our position after the movement.
function applyMovement(currentPosition : Vector3, movementType : string, amount : number) : Vector3
    movementType = movementType:lower()

    -- Check that the movement exists; if not, we need to throw an error here
    assert(movementAppliers[movementType], "Unknown Movement Type: " .. movementType)

    -- Use the movementAppliers table to apply the movement and calculate our new Vector3 value
    return movementAppliers[movementType](currentPosition, amount)
end

return function (input : string, helpers) : number
    local parsers = helpers.Parsers
    
    local inputLines = parsers.SplitNewLines(input)
    local currentPosition = Vector3.new(0, 0)

    for _,line in pairs(inputLines) do
        local movementData = parsers.Split(line, " ")
        local movementType = movementData[1]
        local movementAmount = tonumber(movementData[2])

        currentPosition = applyMovement(currentPosition, movementType, movementAmount)
    end

    return currentPosition.X * currentPosition.Y
end