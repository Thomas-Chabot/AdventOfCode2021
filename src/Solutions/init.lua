--[[
    Main Solution architecture object.
    This can be used to generate solutions, retrieve the calculated results, and submit solutions to Advent of Code.

    Note: If working with the AoC API, this will need the token to be stored under the Solution in a file named ".token".
    The token can be fetched by going to the "Get your puzzle input" page, and retrieving the value for the Session cookie.

    Constructor:
        Solution.new(day : number, input : string?)
            Creates a new Solution object. Takes in the day, and optional input.
            If input is not provided, this will fetch automatically from the Advent of Code puzzle input.
        GetPart1Solution()
            Returns the calculated solution for Part 1 of the puzzle.
        GetPart2Solution()
            Returns the calculated solution for Part 2 of the puzzle.
        SubmitPart1() : boolean
            Submits Part 1, using the calculated solution. Returns true if the submission was correct.
        SubmitPart2() : boolean
            Submits Part 2, using the calculated solution. Returns true if the submission was correct.
]]

local Client = require(game.ServerScriptService.AOCClient)
local Token = require(script[".token"])
local Days = script.Days

local Solution = { }
Solution.__index = Solution

local Data = {
    Types = script.Types,
    Parsers = script.Parsers
}

-- Creates a new Advent of Code user object, which can then be used for grabbing input data and submitting solutions.
local function initializeAdventOfCode(day : number, year : number?)
    if not year then
        year = 2021
    end

    return Client.new({
        Year = year,
        Day = day,
        Token = Token,
        Log = false,
        Cache = true
    })
end

-- Creates a new Solution object, given the day and year that we want to check.
-- This should primarily be used when we're actually looking to submit data.
-- Parameters:
--   @day : Number : The day that we want to create a solution for
--   @input : String : Optional. The input data to test against. If not provided, will fetch the data from the Advent of Code server.
function Solution.new(day : number, input : string?)
    -- TODO: Can update this if we want to go back and work against other years.
    local year = 2021

    -- Generate the Advent of Code user object
    local userData = initializeAdventOfCode(day, year)

    -- Retrieve input data, if it hasn't been provided
    if (input == nil) then
        input = userData:GetInput()
    end

    -- Create the Solution object
    local self = setmetatable({
        _year = year,
        _day = day,

        _userData = userData,
        _input = input,
        _solutions = { }
    }, Solution)

    -- Build up solutions
    self:_generateSolutions()
    return self
end

-- Retrieves the Solution for Part 1.
function Solution:GetPart1Solution()
    return self._solutions[1]
end
-- Retrieves the Solution for Part 2.
function Solution:GetPart2Solution()
    return self._solutions[2]
end

-- Submits the solution for Part 1.
-- Returns status, true if submission was successful / correct.
function Solution:SubmitPart1() : boolean
    return self:_submitSolutionForPart(1)
end
-- Submits the solution for Part 2.
-- Returns status, true if submission was successful / correct.
function Solution:SubmitPart2() : boolean
    return self:_submitSolutionForPart(2)
end

-- Submits the solution for the given part (either 1 or 2).
-- Returns success code: This will be true if the submission was completed and correct.
function Solution:_submitSolutionForPart(partNumber : number) : boolean
    -- Check that we have the Advent of Code object created; if not, we can't submit
    assert(self._userData, "Cannot submit solutions when created without providing day/year values.")
    
    -- Check that we have a solution to submit
    local data = self._solutions[partNumber]
    assert(data ~= nil, "Cannot submit a solution for part " .. partNumber .. " because the data does not exist.")

    -- Can submit
    local result = self._userData:Submit(partNumber, self._solutions[partNumber])

    -- If the submission fails, or we don't have a result code, return false
    if result == nil or result["Success"] == nil then
        return false
    end

    -- Otherwise, return whatever was given for Success: will be true if it was correct
    return result["Success"]
end

function Solution:_generateSolutions()
    -- Find the solutions folder; this will throw an exception if we don't have solutions created yet
    local solutionsFolder = Days:FindFirstChild("Day" .. self._day)
    assert(solutionsFolder ~= nil, "Could not find a solutions folder for the day: " .. tostring(self._day))

    -- Generate solutions for the two parts
    self:_generateSolution(1, solutionsFolder:FindFirstChild("Part1"))
    self:_generateSolution(2, solutionsFolder:FindFirstChild("Part2"))    
end

-- Generates a solution for either Part 1 or Part 2 of a challenge.
function Solution:_generateSolution(part : number, solution : Instance)
    if (solution == nil) then
        return
    end

    self._solutions[part] = require(solution)(self._input, Data)
end

return Solution