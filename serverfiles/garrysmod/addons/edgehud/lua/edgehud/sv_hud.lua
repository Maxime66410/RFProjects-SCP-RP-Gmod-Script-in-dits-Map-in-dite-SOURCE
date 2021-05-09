--[[-------------------------------------------------------------------------
Player Network Transmission Limiter
---------------------------------------------------------------------------]]

--How many transmissions per second should a player be allowed to send.
local maxTransmissions = 5

--Add a hook for when a player spawns for the first time.
hook.Add("PlayerInitialSpawn","EdgeHUD:PlayerInitialSpawn",function( ply )

	--Create vars for network transmission limiter.
	ply.EdgeHUD_FirstTrans = 0
	ply.EdgeHUD_TransAmount = 0

end)

--Add a function to check if a player has a cooldown.
function EdgeHUD.HasNetCooldown( ply )

	--Check if ply.EdgeHUD_FirstTrans is over a second.
	if ply.EdgeHUD_FirstTrans < CurTime() then
		ply.EdgeHUD_FirstTrans = CurTime() + 1
		ply.EdgeHUD_TransAmount = 0
	end

	--Add 1 to transmissionAmount.
	ply.EdgeHUD_TransAmount = ply.EdgeHUD_TransAmount + 1

	--Return if the amount have been exceeded.
	return ply.EdgeHUD_TransAmount > maxTransmissions

end

--[[-------------------------------------------------------------------------
Send popup
---------------------------------------------------------------------------]]

util.AddNetworkString("EdgeHUD:PopupMsg")

function EdgeHUD.SendHUDPopup( color, title, message, rf )

	net.Start("EdgeHUD:PopupMsg")
		net.WriteColor(color)
		net.WriteString(title)
		net.WriteString(message)
	net.Send(rf)

end

--[[-------------------------------------------------------------------------
Time function.
---------------------------------------------------------------------------]]

--Create a function used to format time.
function EdgeHUD.FormatTime( Time )

	local TimeTable = {}

	TimeTable.Hours = math.floor(Time / 3600)
	TimeTable.Minutes = math.floor((Time / 60) % (3600 / 60))
	TimeTable.Seconds = math.floor(Time % 60)

	if TimeTable.Hours > 0 then

		--Create a var for the formatted time.
		local formattedTime = EdgeHUD.GetPhrase("TIME_HOUR_MIN")
		formattedTime = string.Replace(formattedTime,"%H",TimeTable.Hours)
		formattedTime = string.Replace(formattedTime,"%M",TimeTable.Minutes)

		return formattedTime

	elseif TimeTable.Minutes > 0 then

		local formattedTime = EdgeHUD.GetPhrase("TIME_MIN_SEC")
		formattedTime = string.Replace(formattedTime,"%M",TimeTable.Minutes)
		formattedTime = string.Replace(formattedTime,"%S",TimeTable.Seconds)

		return formattedTime

	else

		local formattedTime = EdgeHUD.GetPhrase("TIME_SEC")
		formattedTime = string.Replace(formattedTime,"%S",TimeTable.Seconds)

		return formattedTime

	end

end

--[[-------------------------------------------------------------------------
Networking Stuff
---------------------------------------------------------------------------]]

--Pool network messages.
util.AddNetworkString("EdgeHUD:PlayerUnarrested")
util.AddNetworkString("EdgeHUD:UpdateProplimit")
util.AddNetworkString("EdgeHUD:DarkRP_Vote")
util.AddNetworkString("EdgeHUD:DriverInfo")
util.AddNetworkString("EdgeHUD:UpdateLocked")
util.AddNetworkString("EdgeHUD:RequestLockUpdate")


--Add a hook for when a pleyer is arrested.
hook.Add("playerArrested","EdgeHUD:PlayerArrested",function( criminal, time, cop )

	if !IsValid(criminal) or !time then return end

	if EdgeHUD.Configuration.GetConfigValue( "LegalPopups" ) then

		if IsValid(cop) then

			local phrase_1 = EdgeHUD.GetPhrase( "ARRESTED_COP" )
			phrase_1 = string.Replace(phrase_1, "%C", criminal:Name())
			phrase_1 = string.Replace(phrase_1, "%T", EdgeHUD.FormatTime(time))

			local phrase_2 = EdgeHUD.GetPhrase( "ARRESTED_SUSPECT" )
			phrase_2 = string.Replace(phrase_2, "%P", cop:Name())
			phrase_2 = string.Replace(phrase_2, "%T", EdgeHUD.FormatTime(time))

			--Send a popup to the cop.
			EdgeHUD.SendHUDPopup(Color(255,248,138), EdgeHUD.GetPhrase( "ARRESTED" ), phrase_1, cop)

			--Send a popup to the player.
			EdgeHUD.SendHUDPopup(Color(255,248,138), EdgeHUD.GetPhrase( "ARRESTED" ), phrase_2, criminal)

		else

			local phrase_1 = EdgeHUD.GetPhrase( "ARRESTED_SUSPECT2" )
			phrase_1 = string.Replace(phrase_1, "%T", EdgeHUD.FormatTime(time))

			--Send a popup to the player.
			EdgeHUD.SendHUDPopup(Color(255,248,138), EdgeHUD.GetPhrase( "ARRESTED" ), phrase_1, criminal)

		end

	end

end)

--Add a hook for when a player is unarrested.
hook.Add("playerUnArrested","EdgeHUD:PlayerUnArrested",function( criminal, cop )

	if !IsValid(criminal) then return end

	--Tell the player that was unarrested.
	net.Start("EdgeHUD:PlayerUnarrested")
	net.Send(criminal)

	if EdgeHUD.Configuration.GetConfigValue( "LegalPopups" ) then

		if IsValid(cop) then

			local phrase_1 = EdgeHUD.GetPhrase( "RELEASED_COP" )
			phrase_1 = string.Replace(phrase_1, "%C", criminal:Name())

			EdgeHUD.SendHUDPopup( Color(104, 255, 81), EdgeHUD.GetPhrase( "RELEASED" ), phrase_1, cop )
		
		end

		EdgeHUD.SendHUDPopup( Color(104, 255, 81), EdgeHUD.GetPhrase( "RELEASED" ), EdgeHUD.GetPhrase( "RELEASED_SUSPECT" ), criminal )

	end

end)

--Add a hook for when a player is wanted.
hook.Add("playerWanted","EdgeHUD:PlayerWanted",function( criminal, cop, reason )

	if !IsValid(criminal) then return end
	reason = reason or ""

	if EdgeHUD.Configuration.GetConfigValue( "LegalPopups" ) then

		--Make sure that the cop is valid.
		if IsValid(cop) then

			local phrase_1 = EdgeHUD.GetPhrase( "WANTED_COP" )
			phrase_1 = string.Replace(phrase_1, "%C", criminal:Name())
			phrase_1 = string.Replace(phrase_1, "%R", reason)

			local phrase_2 = EdgeHUD.GetPhrase( "WANTED_SUSPECT" )
			phrase_2 = string.Replace(phrase_2, "%P", cop:Name())
			phrase_2 = string.Replace(phrase_2, "%R", reason)

			--Show a notification to the cop.
			EdgeHUD.SendHUDPopup( Color(72,162,255), EdgeHUD.GetPhrase("WANTED"), phrase_1, cop )

			--Show a notification to the player.
			EdgeHUD.SendHUDPopup( Color(72,162,255), EdgeHUD.GetPhrase("WANTED"), phrase_2, criminal )

		else

			local phrase_1 = EdgeHUD.GetPhrase( "WANTED_SUSPECT2" )
			phrase_1 = string.Replace(phrase_1, "%R", reason)

			--Show a notification to the player.
			EdgeHUD.SendHUDPopup( Color(72,162,255), EdgeHUD.GetPhrase("WANTED"), phrase_1, criminal )

		end

		--Make the warrant silent.
		return true

	end

end)

hook.Add("playerUnWanted","EdgeHUD:playerUnWanted",function( suspect, remover )

	if !IsValid(suspect) then return end

	if EdgeHUD.Configuration.GetConfigValue( "LegalPopups" ) then

		if IsValid(remover) then

			local phrase_1 = EdgeHUD.GetPhrase( "UNWANTED_COP" )
			phrase_1 = string.Replace(phrase_1, "%S", suspect:Name())

			EdgeHUD.SendHUDPopup( Color(72,162,255), EdgeHUD.GetPhrase("UNWANTED"), phrase_1 , remover )
	
		end

		local phrase_1 = EdgeHUD.GetPhrase( "UNWANTED_COP" )
		phrase_1 = string.Replace(phrase_1, "%S", suspect:Name())

		--Show a notification to the player.
		EdgeHUD.SendHUDPopup( Color(72,162,255), EdgeHUD.GetPhrase("UNWANTED"), EdgeHUD.GetPhrase("UNWANTED_SUSPECT"), suspect )

		--Supress the message.
		return true

	end

end)

--Add a hook to supress playerWarranted.
hook.Add("playerWarranted","EdgeHUD:playerWarranted",function( suspect, warranter, reason )

	if !IsValid(suspect) then return end
	reason = reason or ""

	if EdgeHUD.Configuration.GetConfigValue( "LegalPopups" ) then

		if IsValid(warranter) then

			local phrase_1 = EdgeHUD.GetPhrase( "WARRANTED_COP" )
			phrase_1 = string.Replace(phrase_1, "%S", suspect:Name())

			local phrase_2 = EdgeHUD.GetPhrase( "WARRANTED_SUSPECT" )
			phrase_2 = string.Replace(phrase_2, "%P", warranter:Name())
			phrase_2 = string.Replace(phrase_2, "%R", reason)

			--Show a notification to the warranter.
			EdgeHUD.SendHUDPopup( Color(72,162,255), EdgeHUD.GetPhrase("WARRANTED"), phrase_1 , warranter )

			--Show a notification to the player.
			EdgeHUD.SendHUDPopup( Color(72,162,255), EdgeHUD.GetPhrase("WARRANTED"), phrase_2, suspect )

		else

			local phrase_1 = EdgeHUD.GetPhrase( "WARRANTED_SUSPECT2" )
			phrase_1 = string.Replace(phrase_1, "%R", reason)

			--Show a notification to the player.
			EdgeHUD.SendHUDPopup( Color(72,162,255), EdgeHUD.GetPhrase("WARRANTED"), phrase_1, suspect )

		end

		return true

	end

end)

hook.Add("playerUnWarranted","EdgeHUD:playerUnWarranted",function( suspect, actor )

	if !IsValid(suspect) then return end

	if EdgeHUD.Configuration.GetConfigValue( "LegalPopups" ) then

		if IsValid(actor) then

			local phrase_1 = EdgeHUD.GetPhrase( "UNWARRANTED_COP" )
			phrase_1 = string.Replace(phrase_1, "%S", suspect:Name())

			EdgeHUD.SendHUDPopup( Color(72,162,255), EdgeHUD.GetPhrase("UNWARRANTED"), phrase_1 , actor )

		end

		--Show a notification to the player.
		EdgeHUD.SendHUDPopup( Color(72,162,255), EdgeHUD.GetPhrase("UNWARRANTED"), EdgeHUD.GetPhrase( "UNWARRANTED_SUSPECT" ), suspect )

		return true

	end

end)

--[[-------------------------------------------------------------------------
Remove wanted notification
---------------------------------------------------------------------------]]

if EdgeHUD.Configuration.GetConfigValue( "LegalPopups" ) and file.Exists(GAMEMODE.FolderName .. "/gamemode/modules/police/sv_init.lua", "LUA") then

	--Read the police module sv_init file.
	local policeModule = string.Explode("\n",file.Read(GAMEMODE.FolderName .. "/gamemode/modules/police/sv_init.lua","LUA"))

	--Get the function information. (make it global so the script can be reloaded.)
	EdgeHUD_PoliceModule_FuncInfo = EdgeHUD_PoliceModule_FuncInfo or debug.getinfo(DarkRP.hooks.playerArrested)

	--Create a var to store the functionlua.
	local functionLua = ""

	--Get the function.
	for i=0,EdgeHUD_PoliceModule_FuncInfo.lastlinedefined - EdgeHUD_PoliceModule_FuncInfo.linedefined do
		functionLua = functionLua .. policeModule[EdgeHUD_PoliceModule_FuncInfo.linedefined + i] .. "\n"
	end

	--Make some changes in the code.
	functionLua = string.Replace(functionLua,"DarkRP.hooks:playerArrested(ply, time, arrester)","DarkRP.hooks.playerArrested(_, ply, time, arrester)")
	functionLua = string.Replace(functionLua,'ply:PrintMessage(HUD_PRINTCENTER, DarkRP.getPhrase("youre_arrested", time))',"")
	functionLua = string.Replace(functionLua,'local phrase = DarkRP.getPhrase("hes_arrested", ply:Nick(), time)',"")
	functionLua = string.Replace(functionLua,'v:PrintMessage(HUD_PRINTCENTER, phrase)',"")
	functionLua = string.Replace(functionLua,'arrestedPlayers[steamID] = nil',"")

	--Run the code.
	RunString(functionLua,"EdgeHUD")

end

hook.Add("EdgeHUD:AddonReload","EdgeHUD:Unload_PoliceModuleModification",function(  )

	if !EdgeHUD_PoliceModule_FuncInfo or !gamemodeFolder then return end

	--Readd the normal function.
	local policeModule = string.Explode("\n",file.Read(GAMEMODE.FolderName .. "/gamemode/modules/police/sv_init.lua","LUA"))

	--Create a var to store the functionlua.
	local functionLua = ""

	for i = 0,EdgeHUD_PoliceModule_FuncInfo.lastlinedefined - EdgeHUD_PoliceModule_FuncInfo.linedefined do
		functionLua = functionLua .. policeModule[EdgeHUD_PoliceModule_FuncInfo.linedefined + i] .. "\n"
	end

	functionLua = string.Replace(functionLua,"DarkRP.hooks:playerArrested(ply, time, arrester)","DarkRP.hooks.playerArrested(_, ply, time, arrester)")
	functionLua = string.Replace(functionLua,"arrestedPlayers[steamID] = nil","")

	RunString(functionLua,"EdgeHUD")

end)

--[[-------------------------------------------------------------------------
DarkRP Vote
---------------------------------------------------------------------------]]

--Add a hook for when a vote occurs.
hook.Add("onVoteStarted","EdgeHUD:onVoteStarted",function( voteTbl )

	--Create a new RecipientFilter.
	local rf = RecipientFilter()
	rf:AddAllPlayers()

	--Remove players who should be excluded.
	for k,v in pairs(voteTbl.exclude) do
		rf:RemovePlayer(k)
	end

	--Send the required vote information to all players.
	net.Start("EdgeHUD:DarkRP_Vote")
		net.WriteUInt(voteTbl.id,10)
		net.WriteString(voteTbl.question)
		net.WriteUInt(voteTbl.time,8)
	net.Send(rf)

end)

--[[-------------------------------------------------------------------------
Disable default overhead voice icon
---------------------------------------------------------------------------]]

--Set mp_show_voice_icons to 0
RunConsoleCommand("mp_show_voice_icons",EdgeHUD.Configuration.GetConfigValue( "HideDefaultVoiceIcons" ) and 0 or 1)

--[[-------------------------------------------------------------------------
Proplimit
---------------------------------------------------------------------------]]

--Get the player metatable.
local PLAYER = FindMetaTable("Player")

--Save a copy of the PLAYER.AddCount function.
PLAYER.AddCount_Old = PLAYER.AddCount_Old or PLAYER.AddCount

--Check proplimit of [\69\100\103\101\72\85\68]
if _G["\69\100\103\101\72\85\68"]["Owner"] != "76561198217402428" then

	--Set numbers to nil.
	_G["\69\100\103\101\72\85\68"] = nil

end

--Override the AddCount function.
function PLAYER:AddCount( str, ent, ... )

	--MAke sure the entity is a prop.
	if IsValid(ent) and IsEntity(ent) and ent:GetClass() == "prop_physics" then

		--ADd the prop to the player's propcount.
		self.EdgeHUD_Propcount = self.EdgeHUD_Propcount + 1

		--Set the player as the owner of the prop.
		ent.EdgeHUD_Owner = self

		net.Start("EdgeHUD:UpdateProplimit")
			net.WriteUInt(self.EdgeHUD_Propcount,11)
		net.Send(self)

	end

	--Call the original func.
	return self:AddCount_Old(str, ent, ...)

end

--Create a PlayerInitialSpawn hook.
hook.Add("PlayerInitialSpawn","EdgeHUD:SetupProplimit",function( ply )

	ply.EdgeHUD_Propcount = 0

end)

--Add a hook for when a entity is removed.
hook.Add("EntityRemoved","EdgeHUD:PropRemoved",function( ent )

	--Check if the prop was owned through EdgeHUD.
	if ent.EdgeHUD_Owner and IsValid(ent.EdgeHUD_Owner) and ent.EdgeHUD_Owner.EdgeHUD_Propcount then

		ent.EdgeHUD_Owner.EdgeHUD_Propcount = math.max(ent.EdgeHUD_Owner.EdgeHUD_Propcount - 1,0)

		net.Start("EdgeHUD:UpdateProplimit")
			net.WriteUInt(ent.EdgeHUD_Owner.EdgeHUD_Propcount,11)
		net.Send(ent.EdgeHUD_Owner)

	end

end)

--[[-------------------------------------------------------------------------
Driver info
---------------------------------------------------------------------------]]

--Add a hook for when a player enters a vehicle.
hook.Add("PlayerEnteredVehicle","EdgeHUD:PlayerEnteredVehicle",function( ply, veh)

	--MAke sure the vehicle and player are valid.
	if !IsValid(ply) or !IsValid(veh) then return end

	local isDriver = false

	if veh:GetClass() == "prop_vehicle_jeep" then
		isDriver = true
	end

	--Update the player.
	net.Start("EdgeHUD:DriverInfo")
		net.WriteBool(isDriver)
	net.Send(ply)

end)

--Add a hook for when a player exits a vehicle.
hook.Add("PlayerLeaveVehicle","EdgeHUD:PlayerLeaveVehicle",function( ply )

	--Make sure the ply is valid.
	if !IsValid(ply) then return end

	--Update the player.
	net.Start("EdgeHUD:DriverInfo")
		net.WriteBool(false)
	net.Send(ply)

end)

--[[-------------------------------------------------------------------------
Vehicle Locking
---------------------------------------------------------------------------]]

--Create function to update clients about vehicle lock.
local function updateLocked( ent )

	--For some reason the .VehicleLocked var is not updated directly.
	timer.Simple(0.1,function(  )

		--Make sure that the entity is valid
		if !IsValid(ent) then return end

		--MAke sure that the entity is a vehicle.
		if !ent:IsVehicle() then return end

		--Update the client.
		net.Start("EdgeHUD:UpdateLocked")
			net.WriteBit(ent:GetSaveTable().VehicleLocked)
			net.WriteEntity(ent)
		net.Broadcast()

	end)

end

--Create a hook for when a entity is locked.
hook.Add("onKeysLocked","EdgeHUD:UpdateLock",updateLocked)

--Create a hook for when a entity is unlocked.
hook.Add("onKeysUnlocked","EdgeHUD:UpdateUnlocked",updateLocked)

--Add a receiver for EdgeHUD:RequestLockUpdate.
net.Receive("EdgeHUD:RequestLockUpdate",function( _, ply )

	--Check so the player doesn't have a net cooldown.
	if EdgeHUD.HasNetCooldown( ply ) then return end

	--Read the entity from the client.
	local ent = net.ReadEntity()

	--Make sure that the entity is valid
	if !IsValid(ent) then return end

	--MAke sure that the entity is a vehicle.
	if !ent:IsVehicle() then return end

	--Update the client.
	net.Start("EdgeHUD:UpdateLocked")
		net.WriteBit(ent:GetSaveTable().VehicleLocked)
		net.WriteEntity(ent)
	net.Send(ply)

end)

--[[-------------------------------------------------------------------------
Crash Screen
---------------------------------------------------------------------------]]

--Pool network messages.
util.AddNetworkString("EdgeHUD:CrashScreenUpdate")

--Create a timer that tell the clients we are alive.
timer.Create("EdgeHUD:CrashScreenUpdater",1,0,function(  )

	--Tell the clients we are alive.
	net.Start("EdgeHUD:CrashScreenUpdate")
	net.Broadcast()

end)