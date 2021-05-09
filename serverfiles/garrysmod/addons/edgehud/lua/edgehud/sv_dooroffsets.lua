--[[-------------------------------------------------------------------------
Data Management
---------------------------------------------------------------------------]]

-- Create a table for the offsets.
EdgeHUD.DoorOffsets = {}

-- Check if the dooroffset folder exists.
if !file.Exists("edgehud/dooroffsets","DATA") then

	-- Create the folder.
	file.CreateDir("edgehud/dooroffsets")

end

-- Get the mapfile path.
local path = "edgehud/offsetdefaults/sh_" .. game.GetMap() .. ".lua"

-- Cache the datapath.
local dataPath = "edgehud/dooroffsets/" .. game.GetMap() .. ".txt"

--Create a function to load the dooroffsets.
function EdgeHUD.LoadDoorOffsets( )

	EdgeHUD.DoorOffsets = {}

	-- Check if we have default offsets for the current map.
	if file.Exists(path,"LUA") then

		-- Load defaults.
		include(path)

	end

	-- Check if we have any overriden values.
	if file.Exists(dataPath,"DATA") then

		-- Read the overriden values.
		local data = file.Read(dataPath,"DATA")

		-- Convert the data from JSON.
		data = util.JSONToTable(data)

		-- Make sure that the conversion was successful.
		if !data or !istable(data) then

			--Print a error message.
			print("[EdgeHUD] : [" .. EdgeHUD.Version .. "] : Failed to load overriden door-offsets for map. (" .. game.GetMap() .. ")")

			-- Stop the code.
			return

		end

		-- Merge the data with the defaults.
		table.Merge(EdgeHUD.DoorOffsets,data)

	end

end

-- Load the door offsets.
EdgeHUD.LoadDoorOffsets( )

--[[-------------------------------------------------------------------------
Data Transfering
---------------------------------------------------------------------------]]

-- Create a hook to create some cooldown information for the player on first spawn.
hook.Add("PlayerInitialSpawn","EdgeHUD:CreateDoorOffsetCooldown",function( ply )

	-- Create some vars.
	ply.EdgeHUD_DO_Cooldown = 0

end)

-- POol network messages.
util.AddNetworkString("EdgeHUD:RequestDoorOffsets")
util.AddNetworkString("EdgeHUD:SendDoorOffsets")

-- Add a receiver for EdgeHUD:RequestDoorOffsets.
net.Receive("EdgeHUD:RequestDoorOffsets", function( _, ply )

	-- Make sure the player doesn't have a cooldown.
	if ply.EdgeHUD_DO_Cooldown > CurTime() then return end

	-- Set the network cooldown to 0.5 seconds.
	ply.EdgeHUD_DO_Cooldown = CurTime() + 0.5

	-- Read the table.
	local requiredEntities = net.ReadTable() or {}

	-- Make sure that the table isn't larger than 5 keys. (Kick the player for code manipulation)
	if table.Count(requiredEntities) > 5 then ply:Kick("EdgeHUD: Suspected code manipulation.") return end

	-- Create a table for the data to send.
	local toSend = {}

	-- Loop through all the entities to gather the data we need.
	for k,v in pairs(requiredEntities) do

		-- Make sure the value is a entity and that it's valid.
		if !IsValid(v) or !isentity(v) then continue end

		-- Check if we have any saved dooroffsets for the door.
		if !EdgeHUD.DoorOffsets[v:MapCreationID()] then continue end

		-- Add the offsets to the data that we should send.
		toSend[v] = EdgeHUD.DoorOffsets[v:MapCreationID()]

	end

	-- Check if we have anything to send.
	if table.Count(toSend) == 0 then return end

	--Send the dooroffsets.
	net.Start("EdgeHUD:SendDoorOffsets")
		net.WriteTable(toSend)
	net.Send(ply)

end)

--[[-------------------------------------------------------------------------
Data Admin-Manipulation
---------------------------------------------------------------------------]]

-- Get the configuration for who has access to the config.
local configTxt = EdgeHUD.Configuration.GetConfigValue( "ConfigAccess" )

-- Get the usergroups.
if string.Right(configTxt, 1) == ";" then
	configTxt = string.Left(configTxt, #configTxt - 1)
end

local groupsAccess = string.Explode(";", configTxt)

--Create a function to see if the player has access.
local function hasAccess( target )

	-- Check if we have access.
	if EdgeHUD.Owner != target:SteamID64() and !table.HasValue(groupsAccess, target:GetUserGroup()) then
		return false
	end

	-- Return true if nothing stopped us.
	return true

end

--Pool network messages.
util.AddNetworkString("EdgeHUD:SetDoorOffset")
util.AddNetworkString("EdgeHUD:ResetDoorOffset")
util.AddNetworkString("EdgeHUD:DoorUpdated")

-- Add a receiver for EdgeHUD:SetDoorOffset.
net.Receive("EdgeHUD:SetDoorOffset",function( _, ply )

	-- Make sure that the player has access.
	if !hasAccess( ply ) then return end

	-- Make sure the player has no cooldown.
	if EdgeHUD.HasNetCooldown( ply ) then return end

	-- Read the entity.
	local door = net.ReadEntity()
	local receivedData = net.ReadTable() or {}

	-- MAke sure that the door is valid and a door.
	if !IsValid(door) or !IsEntity(door) or !door:isDoor() then return end

	local allowedKeys = {"pi", "ya", "ro", "x", "y", "z"}

	-- Make sure the receivedData only has the allowed keys and values.
	for k,v in pairs(receivedData) do

		-- Make sure the key is allowed.
		if !table.HasValue(allowedKeys,k) then return end

		-- Make sure that the value is a number.
		if !isnumber(v) then return end

	end

	-- create a var for the stored data.
	local data = {}

	-- Check if we have any overriden values.
	if file.Exists(dataPath,"DATA") then

		-- Read the overriden values.
		data = file.Read(dataPath,"DATA")

		-- Convert the data from JSON.
		data = util.JSONToTable(data)

		-- Make sure that the conversion was successful.
		if !data or !istable(data) then return end

	end

	-- Insert the read value.
	data[door:MapCreationID()] = receivedData

	-- Write the new dataFile.
	file.Write(dataPath, util.TableToJSON(data))

	-- Reload all dooroffsets.
	EdgeHUD.LoadDoorOffsets( )

	-- Tell all players that a door was updated.
	net.Start("EdgeHUD:DoorUpdated")
		net.WriteEntity(door)
	net.Broadcast()

end)

--Add a receiver for EdgeHUD:ResetDoorOffset
net.Receive("EdgeHUD:ResetDoorOffset",function( _, ply )

	-- Make sure that the player has access.
	if !hasAccess( ply ) then return end

	-- Make sure the player has no cooldown.
	if EdgeHUD.HasNetCooldown( ply ) then return end

	-- Read the entity.
	local door = net.ReadEntity()

	-- MAke sure that the door is valid and a door.
	if !IsValid(door) or !IsEntity(door) or !door:isDoor() then return end

	-- Check if we have any overriden values.
	if !file.Exists(dataPath,"DATA") then return end

	-- Read the overriden values.
	local data = file.Read(dataPath,"DATA")

	-- Convert the data from JSON.
	data = util.JSONToTable(data)

	-- Make sure that the conversion was successful.
	if !data or !istable(data) then return end

	-- Remove the entity from the data.
	data[door:MapCreationID()] = nil

	-- Write the new dataFile.
	file.Write(dataPath, util.TableToJSON(data))

	-- Reload all dooroffsets.
	EdgeHUD.LoadDoorOffsets( )

	-- Tell all players that a door was updated.
	net.Start("EdgeHUD:DoorUpdated")
		net.WriteEntity(door)
	net.Broadcast()

end)