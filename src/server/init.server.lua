local DayNumber : number = 2
local DoSubmit : boolean = false

local ExampleInput = nil

local Solution = require(game.ServerScriptService.Solutions).new(DayNumber, ExampleInput)

print("Part 1 Result: ", Solution:GetPart1Solution())
print("Part 2 result: ", Solution:GetPart2Solution())

if (DoSubmit) then
    local isCorrect = Solution:SubmitPart1()
    if isCorrect then
        print("Submission completed. Answer is correct.")
    else
        print("Submission failed.")
    end
end