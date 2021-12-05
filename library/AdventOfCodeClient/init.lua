-- Credit to Call23re2 for the AOC Client script.

local Web = require(script.Web)

local Client = {}
Client.__index = Client

function Client.new(Options)
	local self = setmetatable({}, Client)
	
	if not Options then error("Must include Options.") end
	if type(Options) ~= "table" then error("Options must be a dictionary, got " .. type(Options)) end
	
	if Options.Cache == nil then Options.Cache = true end
	if Options.Log == nil then Options.Log = true end
	
	if type(Options.Year) ~= "number" then error("Year must be a number, got " .. type(Options.Year)) end
	if type(Options.Day) ~= "number" then error("Day must be a number, got " .. type(Options.Day)) end
	if type(Options.Token) ~= "string" then error("Session Token must be a string, got " .. type(Options.Token)) end
	if type(Options.Cache) ~= "boolean" then error("Cache must be a boolean, got " .. type(Options.Cache)) end
	if type(Options.Log) ~= "boolean" then error("Log must be a boolean, got " .. type(Options.Log)) end
	
	if Options.Year < 2015 then error("Year must be >= 2015, got " .. Options.Year) end
	if Options.Day < 1 or Options.Day > 25 then error("Day must be between 1 and 25, got " .. Options.Day) end
	
	Options.Date = {
		Year = Options.Year,
		Day = Options.Day
	}
	
	self.Config = Options
	
	Web:SetConfig(Options)
	
	return self
end

function Client:_Log(Message)
	if self.Config.Log then
		print(Message)
	end
end

function Client:GetInput()
	self:_Log("Getting input")
	
	local input = Web:GetInput()
	
	if not input.Success then
		error(input.Reason)
	end
	
	self:_Log("Got Input via " .. input.Method)
	
	-- Trim Input
	-- http://lua-users.org/wiki/StringTrim
	input.Input = input.Input:gsub("^%s*(.-)%s*$", "%1")
	
	-- Apply Transformers
	
	return input.Input
end

function Client:Submit(Part, Solution)
	if Part ~= 1 and Part ~= 2 then error("Part must be either 1 or 2.") end
	if not Solution then error("Must include solution.") end
	
	-- Check cache to see if part has already been completed or not.
	
	self:_Log("Submitting Part " .. Part)
	
	local res = Web:Submit(Part, Solution)
	self:_Log(res)
	
	return res
end

return Client