local ServerStorage = game:GetService("ServerStorage")

local NameFormat = "%d%d%s"

local Cache = {}

function Cache:_Init()
	self.Folder = Instance.new("Folder")
	self.Folder.Parent = game.ServerStorage
	self.Folder.Name = "Cache"
end

function Cache:Set(Date, Key, Data)
	local name = NameFormat:format(Date.Year, Date.Day, Key)
	local value = self:Get(Date, Key)
	
	if value == nil then
		self.Folder:SetAttribute(name, Data)
	end
end

function Cache:Get(Date, Key)
	local Folder = ServerStorage:FindFirstChild("Cache")
	
	if not Folder then
		self:_Init()
	else
		self.Folder = Folder
	end
	
	local name = NameFormat:format(Date.Year, Date.Day, Key)
	return self.Folder:GetAttribute(name)
end

return Cache