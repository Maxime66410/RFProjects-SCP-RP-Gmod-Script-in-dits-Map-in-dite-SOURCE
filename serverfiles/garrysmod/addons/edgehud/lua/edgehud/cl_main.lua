--[[-------------------------------------------------------------------------
General
---------------------------------------------------------------------------]]

local ply = LocalPlayer()

--Create a global var if we are connected to the sevrer or not.
EdgeHUD.Disconnected = false

--Get the screen dimensions.
local screenWidth = ScrW()
local screenHeight = ScrH()

--Create a table to store all variables in.
EdgeHUD.Vars = {}

--Calculate these vars here as they will be used a lot throughout the script.

--Base
EdgeHUD.Vars.WidgetHeight = math.floor(screenHeight * 0.05)
EdgeHUD.Vars.ScreenMargin = math.floor(screenHeight * 0.012)
EdgeHUD.Vars.ElementsMargin = math.floor(screenHeight * 0.01)

--Check if hungermod is enabled.
EdgeHUD.Vars.hungerMod = !DarkRP.disabledDefaults["modules"]["hungermod"]

--cl_misc
EdgeHUD.Vars.iconSize = math.floor(EdgeHUD.Vars.WidgetHeight * 0.45)
EdgeHUD.Vars.iconMargin = math.floor(EdgeHUD.Vars.WidgetHeight / 2 - EdgeHUD.Vars.iconSize / 2)
EdgeHUD.Vars.iconSize_Small = math.floor(EdgeHUD.Vars.WidgetHeight * 0.38)
EdgeHUD.Vars.iconMargin_Small = math.floor(EdgeHUD.Vars.WidgetHeight * 0.13)
EdgeHUD.Vars.iconSize_Large = math.floor(EdgeHUD.Vars.WidgetHeight * 0.5)

--cl_lowerleft
EdgeHUD.Vars.statusWidgetWidth = math.floor(EdgeHUD.Vars.hungerMod and screenHeight * 0.088 or screenHeight * 0.138)
EdgeHUD.Vars.infoWidgetWidth = EdgeHUD.Vars.hungerMod and (EdgeHUD.Vars.statusWidgetWidth * 3 + EdgeHUD.Vars.ElementsMargin * 2) or (EdgeHUD.Vars.statusWidgetWidth * 2 + EdgeHUD.Vars.ElementsMargin)

--cl_topleft
EdgeHUD.Vars.salaryWidgetWidth = math.floor(screenHeight * 0.11)
EdgeHUD.Vars.moneyWidgetWidth = math.floor(screenHeight * 0.15)

--General

--Create a margin for between the icon and the label.
EdgeHUD.Vars.labelMargin = math.floor(EdgeHUD.Vars.iconMargin * 0.5)

--Create a variable that holds the width for the elements in the top right.
EdgeHUD.Vars.toprightWidth = math.floor(screenHeight * 0.43)

--Create a variable that holds the width for the elements in the lower right.
EdgeHUD.Vars.extraWidgetsWidth = screenHeight * 0.14

--Create a variable that holds the size for the votes window.
EdgeHUD.Vars.voteWindowWidth = EdgeHUD.Vars.salaryWidgetWidth + EdgeHUD.Vars.moneyWidgetWidth + EdgeHUD.Vars.ElementsMargin
EdgeHUD.Vars.voteWindowHeight = screenHeight * 0.175

-- Start by retrieving the values-
EdgeHUD.LeftOffset = EdgeHUD.Configuration.GetConfigValue("Offset_Left")
EdgeHUD.TopOffset = EdgeHUD.Configuration.GetConfigValue("Offset_Top")
EdgeHUD.RightOffset = EdgeHUD.Configuration.GetConfigValue("Offset_Right")
EdgeHUD.BottomOffset = EdgeHUD.Configuration.GetConfigValue("Offset_Bottom")
EdgeHUD.LevelbarOffset = EdgeHUD.Configuration.GetConfigValue("Offset_Levelbar")

-- Get the offset unit
local config_Measurementunit = EdgeHUD.Configuration.GetConfigValue("Offset_Type")

-- Check if it should be measured in pixels.
if config_Measurementunit == "Screen Height Percentage" then

	EdgeHUD.LeftOffset = EdgeHUD.LeftOffset / 100 * ScrH()
	EdgeHUD.TopOffset =  EdgeHUD.TopOffset / 100 * ScrH()
	EdgeHUD.RightOffset =  EdgeHUD.RightOffset / 100 * ScrH()
	EdgeHUD.BottomOffset =  EdgeHUD.BottomOffset / 100 * ScrH()
	EdgeHUD.LevelbarOffset =  EdgeHUD.LevelbarOffset / 100 * ScrH()

elseif config_Measurementunit == "Screen Width Percentage" then

	EdgeHUD.LeftOffset = EdgeHUD.LeftOffset / 100 * ScrW()
	EdgeHUD.TopOffset =  EdgeHUD.TopOffset / 100 * ScrW()
	EdgeHUD.RightOffset =  EdgeHUD.RightOffset / 100 * ScrW()
	EdgeHUD.BottomOffset =  EdgeHUD.BottomOffset / 100 * ScrW()
	EdgeHUD.LevelbarOffset =  EdgeHUD.LevelbarOffset / 100 * ScrW()

elseif config_Measurementunit == "Screen Height/Width Percentage Respectively" then

	EdgeHUD.LeftOffset = EdgeHUD.LeftOffset / 100 * ScrW()
	EdgeHUD.TopOffset =  EdgeHUD.TopOffset / 100 * ScrH()
	EdgeHUD.RightOffset =  EdgeHUD.RightOffset / 100 * ScrW()
	EdgeHUD.BottomOffset =  EdgeHUD.BottomOffset / 100 * ScrH()
	EdgeHUD.LevelbarOffset =  EdgeHUD.LevelbarOffset / 100 * ScrH()

end

--[[-------------------------------------------------------------------------
Colors
---------------------------------------------------------------------------]]

--Create a table to store all the colors in.
EdgeHUD.Colors = {}

EdgeHUD.Colors["Black_Crashscreen"] = Color(50,50,50,230)
EdgeHUD.Colors["Black_Transparent"] = Color(50,50,50,200)
EdgeHUD.Colors["Gray_Transparent"] = Color(80,80,80,200)
EdgeHUD.Colors["Gray"] = Color(200,200,200,255)
EdgeHUD.Colors["White"] = Color(255,255,255,255)
EdgeHUD.Colors["White_Outline"] = Color(255,255,255,50)
EdgeHUD.Colors["White_Corners"] = Color(255,255,255,120)
EdgeHUD.Colors["Red"] = Color(255,106,106,255)
EdgeHUD.Colors["3D2D_Green"] = Color(89,120,73,100)
EdgeHUD.Colors["Green"] = Color(55,160,6,255)

--[[-------------------------------------------------------------------------
Fonts
---------------------------------------------------------------------------]]

surface.CreateFont( "EdgeHUD:Large", {
	font = "Roboto",
	size = screenHeight * 0.05,
	weight = 300,
} )

surface.CreateFont( "EdgeHUD:Medium", {
	font = "Roboto",
	size = screenHeight * 0.0245,
	weight = 300,
} )

surface.CreateFont( "EdgeHUD:Small_2", {
	font = "Roboto",
	size = screenHeight * 0.01855,
	weight = 300,
} )

surface.CreateFont( "EdgeHUD:Small_Bold", {
	font = "Roboto",
	size = screenHeight * 0.017,
	weight = 1500,
} )

surface.CreateFont( "EdgeHUD:Small", {
	font = "Roboto",
	size = screenHeight * 0.017,
	weight = 500,
} )

surface.CreateFont( "EdgeHUD:DoorMenu", {
	font = "Roboto",
	size = screenHeight * 0.022,
	weight = 300,
} )

surface.CreateFont( "EdgeHUD:VehicleHUD:Large", {
	font = "Roboto",
	size = screenHeight * 0.025,
	weight = 600,
} )

surface.CreateFont( "EdgeHUD:VehicleHUD:Small", {
	font = "Roboto",
	size = screenHeight * 0.022,
	weight = 500,
} )

surface.CreateFont( "EdgeHUD:Notification", {
	font	= "Roboto",
	size	= 20,
	weight	= 1000
} )

surface.CreateFont( "EdgeHUD:ItemPickup", {
	font	= "Roboto",
	size	= screenHeight * 0.018,
	weight	= 300
} )

surface.CreateFont( "EdgeHUD:CrashScreen:Large", {
	font = "Roboto",
	size = screenHeight * 0.1,
	weight = 100,
	italic = true
} )

surface.CreateFont( "EdgeHUD:CrashScreen:Medium", {
	font = "Roboto",
	size = screenHeight * 0.04,
	weight = 100,
} )

surface.CreateFont( "EdgeHUD:CrashScreen:Small", {
	font = "Roboto",
	size = screenHeight * 0.029,
	weight = 200,
	italic = true
} )

surface.CreateFont( "EdgeHUD:CrashScreen:Small2", {
	font = "Roboto",
	size = screenHeight * 0.02,
	weight = 300,
} )

surface.CreateFont( "EdgeHUD:OutdatedWindow:Title", {
	font = "Roboto",
	weight = 10,
	size = ScrH() * 0.035,
} )

surface.CreateFont( "EdgeHUD:OutdatedWindow:Text", {
	font = "Roboto",
	weight = 300,
	size = screenHeight * 0.0169,
} )

surface.CreateFont( "EdgeHUD:DoorOffsetMenu:Title", {
	font = "Roboto",
	weight = 300,
	size = screenHeight * 0.025,
} )

surface.CreateFont( "EdgeHUD:DoorOffsetMenu:RstBtn", {
	font = "Roboto",
	weight = 300,
	size = screenHeight * 0.015,
} )


--[[-------------------------------------------------------------------------
3D2D fonts
---------------------------------------------------------------------------]]

surface.CreateFont( "EdgeHUD:3D2D:Large", {
	font = "Roboto",
	size = 50,
	weight = 500,
} )

surface.CreateFont( "EdgeHUD:3D2D:Small", {
	font = "Roboto",
	size = 35,
	weight = 500,
} )

surface.CreateFont( "EdgeHUD:3D2D_Door:Large", {
	font = "Roboto",
	weight = 1000,
	size = 50,
} )

surface.CreateFont( "EdgeHUD:3D2D_Door:Medium", {
	font = "Roboto",
	weight = 1000,
	size = 25,
} )

surface.CreateFont( "EdgeHUD:3D2D_Door:Small", {
	font = "Roboto",
	weight = 1000,
	size = 20,
} )

--[[-------------------------------------------------------------------------
Resolution Change - Detector
---------------------------------------------------------------------------]]

--Create a var that holds the last screen resolution.
local lastHeight, lastWidth = ScrH(), ScrW()

--Add a timer that detects a change in the screen resolution.
timer.Create("EdgeHUD:ResolutionChange",1,0,function(  )

	--Get the current screen.
	local curHeight = ScrH()
	local curWidth = ScrW()

	--Check if the height changed.
	if lastHeight != curHeight or lastWidth != curWidth then

		--Reload the the addon.
		include("autorun/sh_edgehud_loader.lua")

		--Update the vars.
		lastHeight = curHeight
		lastWidth = curWidth

	end

end)

hook.Add("EdgeHUD:AddonReload","EdgeHUD:Unload_ResolutionDetector",function(  )
	timer.Remove("EdgeHUD:ResolutionChange")
end)

--[[-------------------------------------------------------------------------
Remove VCmod.
---------------------------------------------------------------------------]]

if EdgeHUD.Configuration.GetConfigValue( "DisableVCMod" ) then

	local oldFunc

	--Create a timer to disable the VCMod HUD.
	timer.Create("EdgeHUD:RemoveVCModHUD",1,0,function(  )

		if !hook.GetTable()["HUDPaint"]["VC_HUDPaint"] then return end

		--Check if VCMod is installed.
		if VC and string.find(debug.getinfo(hook.GetTable()["HUDPaint"]["VC_HUDPaint"]).short_src, "edgehud") == nil then

			--Save the old func before removal.
			oldFunc = hook.GetTable()["HUDPaint"]["VC_HUDPaint"]

			--Inject into the VCMOD HUD.
			hook.Add("HUDPaint","VC_HUDPaint",function( ... )

				--Check if the player is in a vehicle.
				if ply:InVehicle() then return end

				--Draw the HUD.
				return oldFunc(...)

			end)

		end

	end)

	hook.Add("EdgeHUD:AddonReload","EdgeHUD:Unload_RemoveVCModHUD",function(  )

		timer.Remove("EdgeHUD:RemoveVCModHUD")

		if oldFunc then
			hook.Add("HUDPaint","VC_HUDPaint",oldFunc)
		end

	end)

end

--[[-------------------------------------------------------------------------
Disable killfeed
---------------------------------------------------------------------------]]

if !EdgeHUD.Configuration.GetConfigValue( "EnableKillfeed" ) then

	--Override the function which draws the killfeed.
	function GAMEMODE.DrawDeathNotice() end

end

--[[-------------------------------------------------------------------------
General Functions
---------------------------------------------------------------------------]]

local edgeWidth = 2

--Create a function used to draw the edges.
function EdgeHUD.DrawEdges( x, y, width, height, edgeSize )

	--Draw the upper left corner.
	surface.DrawRect(x,y,edgeSize,edgeWidth)
	surface.DrawRect(x,y + edgeWidth,edgeWidth,edgeSize - edgeWidth)

	local XRight = x + width

	--Draw the upper right corner.
	surface.DrawRect(XRight - edgeSize,y,edgeSize,edgeWidth)
	surface.DrawRect(XRight - edgeWidth,y + edgeWidth,edgeWidth,edgeSize - edgeWidth)

	local YBottom = y + height

	--Draw the lower right corner.
	surface.DrawRect(XRight - edgeSize,YBottom - edgeWidth,edgeSize,edgeWidth)
	surface.DrawRect(XRight - edgeWidth,YBottom - edgeSize,edgeWidth,edgeSize - edgeWidth)

	--Draw the lower left corner.
	surface.DrawRect(x,YBottom - edgeWidth,edgeSize,edgeWidth)
	surface.DrawRect(x,YBottom - edgeSize,edgeWidth,edgeSize - edgeWidth)

end

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
Derma MAnager.
---------------------------------------------------------------------------]]

--Create a table for all derma elements.
EdgeHUD.DermaElements = EdgeHUD.DermaElements or {}

--Create a function to register a new derma element.
function EdgeHUD.RegisterDerma( name, element )

	--Check if the element is registred already.
	if EdgeHUD.DermaElements[name] then

		--Remove the element.
		EdgeHUD.DermaElements[name]:Remove()

	end

	--Register the element.
	EdgeHUD.DermaElements[name] = element

end

hook.Add("EdgeHUD:AddonReload","EdgeHUD:Unload_DermaElements",function(  )
	for k,v in pairs(EdgeHUD.DermaElements) do
		if IsValid(v) then v:Remove() end
	end
end)

--[[-------------------------------------------------------------------------
Arrest Manager
---------------------------------------------------------------------------]]

--Create a var that holds if the player is currently arrested.
local isArrested = false

--Create a var that holds the player's current arrest information.
local arrestedUntil = 0

--Create a function used to get if the player is arrested.
function EdgeHUD.PlayerIsArrested( )
	return isArrested
end

--Create a function used to get when the player will be unarrested.
function EdgeHUD.ArrestTime()
	return math.max(arrestedUntil - os.time(),0)
end

usermessage.Hook("GotArrested",function( data )

	--Update isArrested.
	isArrested = true

	--Update arrestedUntil.
	arrestedUntil = os.time() + data:ReadFloat()

end)

--Add a net receiver for EdgeHUD:PlayerUnArrested.
net.Receive("EdgeHUD:PlayerUnArrested", function(  )

	--Update isArrested.
	isArrested = false

	--Update arrestedUntil.
	arrestedUntil = 0

end)

hook.Add("EdgeHUD:AddonReload","EdgeHUD:Unload_ArrestManager",function(  )

	net.Receive("EdgeHUD:PlayerUnArrested",function(  ) end)
	net.Receive("EdgeHUD:PlayerArrested",function(  ) end)

end)

--[[-------------------------------------------------------------------------
Driver Information.
---------------------------------------------------------------------------]]

--Create a EdgeHUD variable that holds if the player is the driver.
EdgeHUD.Player_IsDriver = false

--Add a receiver for EdgeHUD:DriverInfo.
net.Receive("EdgeHUD:DriverInfo",function(  )
	EdgeHUD.Player_IsDriver = net.ReadBool()
	hook.Run("EdgeHUD:SeatChanged", EdgeHUD.Player_IsDriver)
end)

hook.Add("EdgeHUD:AddonReload","EdgeHUD:Unload_DriverInfo",function(  )

	net.Receive("EdgeHUD:DriverInfo",function(  ) end)

end)