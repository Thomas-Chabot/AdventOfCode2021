local Client = require(game.ServerScriptService.AOCClient)

local User = Client.new({
    Year = 2021,
    Day = 1,
    Token = "",
    Log = true,
    Cache = true
})

local Input = User:GetInput()
print(Input)