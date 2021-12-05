local Http = game:GetService("HttpService")

local Cache = require(script.Parent.Cache)

local HOST = "https://www.adventofcode.com"

local RESULTS = {
	LOGGED_OUT = "Puzzle inputs differ by user.  Please log in to get your puzzle input.",
	TOO_EARLY = "Please don't repeatedly request this endpoint before it unlocks!",
	CORRECT_ANSWER = "That's the right answer",
	INCORRECT_ANSWER = "That's not the right answer",
	TOO_RECENT = "You gave an answer too recently; you have to wait after submitting an answer before trying again.",
	INCORRECT_LEVEL = "You don't seem to be solving the right level."
}

local Web = {}

function Web:SetConfig(Config)
	self.Config = Config
end

function Web:GetInput()
	
	if self.Config.Cache then
		local res = Cache:Get(self.Config.Date, "Input")
		if res then
			return {
				Success = true,
				Input = res,
				Method = "Cache"
			}
		end
	end
	
	local URL = ("%s/%d/day/%d/input"):format(HOST, self.Config.Year, self.Config.Day)
	
	local res = Http:RequestAsync({
		Url = URL,
		Method = "GET",
		Headers = {
			["Cookie"] = "session=" .. self.Config.Token
		}
	})
	
	local body = res.Body
	
	if body:find(RESULTS.LOGGED_OUT) then
		return {
			Success = false,
			Reason = "Your session token was invalid. " .. body
		}
	elseif body:find(RESULTS.TOO_EARLY) then
		return {
			Success = false,
			Reason = body
		}
	end
	
	if self.Config.Cache then
		Cache:Set(self.Config.Date, "Input", body)
	end
	
	return {
		Success = true,
		Input = body,
		Method = "Request"
	}
	
end

function Web:Submit(Part, Solution)
	
	if self.Config.Cache then
		local Cached = Cache:Get(self.Config.Date, Part)
		if Cached then
			return {
				Success = true,
				Reason = "You already solved this part."
			}
		end
	end
	
	local URL = ("%s/%d/day/%d/answer"):format(HOST, self.Config.Year, self.Config.Day)
	
	local res = Http:RequestAsync({
		Url = URL,
		Method = "POST",
		Headers = {
			["Cookie"] = "session=" .. self.Config.Token,
			["Content-Type"] = "application/x-www-form-urlencoded"
		},
		Body = ("level=%d&answer=%s"):format(Part, tostring(Solution))
	})
	
	local body = res.Body
	
	if body:find(RESULTS.CORRECT_ANSWER) then
		
		if self.Config.Cache then
			Cache:Set(self.Config.Date, Part, true)
		end
		
		return {
			Success = true
		}
		
	elseif body:find(RESULTS.INCORRECT_ANSWER) then
		
		return {
			Success = false,
			Reason = RESULTS.INCORRECT_ANSWER
		}
		
	elseif body:find(RESULTS.TOO_RECENT) then
		
		local timeLeftToWait = body:split(RESULTS.TOO_RECENT)[2]:split(".")[1]:gsub('(%s)%s*', '%1')
		return {
			Success = false,
			Reason = ("You gave an answer too recently.%s."):format(timeLeftToWait)
		}
		
	elseif body:find(RESULTS.INCORRECT_LEVEL) then
		
		return {
			Success = false,
			Reason = RESULTS.INCORRECT_LEVEL
		}
		
	end
	
end

return Web