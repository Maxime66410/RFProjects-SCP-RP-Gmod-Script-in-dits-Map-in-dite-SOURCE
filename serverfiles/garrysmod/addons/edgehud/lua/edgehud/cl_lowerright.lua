--Create a variable for the local player.
local ply = LocalPlayer()

--Create a copy of the colors and vars table.
local COLORS = table.Copy(EdgeHUD.Colors)
local VARS = table.Copy(EdgeHUD.Vars)

local screenWidth = ScrW()
local screenHeight = ScrH()

--Create some vars.
local widgetsDrawing = {
	proplimit = false,
	primAmmo = false,
	secAmmo = false,
	gunlicense = false,
	mgangs = false,
	vehicleHUD = false,
}

--Vehicle vars.
local speedType = EdgeHUD.Configuration.GetConfigValue( "Speedometer" )
local speed = 0
local HP = -1
local fuel = -1

--Ammo vars.
local primary = 0
local secondary = 0
local sparePrimary = 0
local spareSecondary = 0

--Proplimit var.
local props = 0

net.Receive("EdgeHUD:UpdateProplimit",function(  )
	props = net.ReadUInt(11)
end)

--Create a timer to update the data for the widgets.
timer.Create("EdgeHUD:UpdateExtraWidgets",0.05,0,function(  )

	--Reset all widgetVisibility.
	for k,v in pairs(widgetsDrawing) do
		widgetsDrawing[k] = false
	end

	--Make sure ply is valid.
	if !IsValid(ply) then return end

	widgetsDrawing.mgangs = true
	widgetsDrawing.gunlicense = true

	--Check if the player is inside of a vehicle.
	if ply:InVehicle() then

		widgetsDrawing.mgangs = false
		widgetsDrawing.gunlicense = false

		--Get the vehicle.
		local veh = ply:GetVehicle()

		--Make sure the vehicle is valid.
		if !IsValid(veh) then return end

		--Check so the player is the driver.
		if !EdgeHUD.Player_IsDriver then return end

		--Make sure the vehicle isn't a chair.
		if string.find(string.lower(veh:GetClass()),"chair") then return end

		widgetsDrawing.vehicleHUD = true

		if speedType == "MPH" then
			speed = math.floor(veh:GetVelocity():Length() / (12 * 5280 / 3600)) .. " " .. EdgeHUD.GetPhrase("SPEEDOMETER_MPH")
		else
			speed = math.floor(veh:GetVelocity():Length() / (12 * 3280.84 / 3600)) .. " " .. EdgeHUD.GetPhrase("SPEEDOMETER_KPH")
		end

		--Check if VCMod is installed.
		if VC and veh.VC_getHealth then

			HP = math.floor(veh:VC_getHealth(true))
			fuel = math.floor(veh:VC_fuelGet(true))

			--For some reason Vehicle:IsDriver doesn't work when writing this so I will do this instead.
			if fuel < 0 then widgetsDrawing.vehicleHUD = false end

		end

	else

		--Get the currently active weapon.
		local curWep = ply:GetActiveWeapon()

		--Check if the weapon is valid.
		if IsValid(curWep) then

			--Get the weapon class.
			local class = curWep:GetClass()

			--Check if the proplimit should be drawn.
			if table.HasValue({"gmod_tool", "weapon_physgun", "weapon_physcannon", },class) then
				widgetsDrawing.proplimit = true
			end

			--Get the ammo types.
			local primAmmo = curWep:GetPrimaryAmmoType()
			local secAmmo = curWep:GetSecondaryAmmoType()

			--Check if the primary ammo should be drawn.
			if (curWep:Clip1() != -1 or primAmmo != -1) and class != "weapon_physcannon" then
				widgetsDrawing.primAmmo = true
				widgetsDrawing.mgangs = false
				primary = curWep:Clip1()
				sparePrimary = primAmmo == -1 and -1 or ply:GetAmmoCount(primAmmo)
			end

			--Check if the secondary ammo should be drawn.
			if (curWep:Clip2() != -1 or secAmmo != -1) and class != "weapon_physcannon" then
				widgetsDrawing.secAmmo = true
				widgetsDrawing.mgangs = false
				secondary = curWep:Clip2()
				spareSecondary = secAmmo == -1 and -1 or ply:GetAmmoCount(secAmmo)
			end

		end

	end

end)

local MAT_Fuel = Material("edgehud/icon_fuel.png", "smooth")
local MAT_ELECTRIC = Material("edgehud/icon_electric.png", "smooth")

--Create a table where we store information about the widgets in the lower right.
local extraWidgets = {
	{
		icon = function ( )

			--Check if the player is inside of a vehicle.
			if ply:InVehicle() and VC and ply:GetVehicle():VC_fuelGetType() == 2 then
				return MAT_ELECTRIC
			end

			return MAT_Fuel

		end,
		getData = function() return fuel .. "%" end,
		shouldDraw = function()
			if !VC then return false end
			if !widgetsDrawing.vehicleHUD then return false end

			local veh = ply:GetVehicle()

			if !IsValid(veh) then return false end

			return EdgeHUD.Configuration.GetConfigValue( "VehicleStatusWidgets" ) and fuel != -1 and VC.ServerSettings.Fuel and veh:VC_isFuelConsumptionEnabled()
		end
	},
	{
		icon = Material("edgehud/icon_engine.png","smooth"),
		getData = function() return HP .. "%" end,
		shouldDraw = function()
			if !VC then return false end
			if !widgetsDrawing.vehicleHUD then return false end

			return EdgeHUD.Configuration.GetConfigValue( "VehicleStatusWidgets" ) and HP != -1 and VC.ServerSettings.Damage end
	},
	{
		icon = Material("edgehud/icon_speedometer.png","smooth"),
		getData = function() return speed end,
		shouldDraw = function() return EdgeHUD.Configuration.GetConfigValue( "VehicleStatusWidgets" ) and widgetsDrawing.vehicleHUD end
	},

	{
		icon = Material("edgehud/icon_gunlicense.png","smooth"),
		getData = function() return EdgeHUD.GetPhrase("GUNLICENSE") end,
		shouldDraw = function() return ply:getDarkRPVar("HasGunlicense") and widgetsDrawing.gunlicense end
	},
	{
		icon = Material("edgehud/icon_gang.png","smooth"),
		getData = function() return (mg2 and ply.GetGang) and ply:GetGang() and ply:GetGang():GetName() or "" end,
		shouldDraw = function() return (mg2 and ply.GetGang) and ply:GetGang() != nil and widgetsDrawing.mgangs and EdgeHUD.Configuration.GetConfigValue( "MGang2Widget" ) end
	},
	{
		icon = Material("edgehud/icon_proplimit.png","smooth"),
		getData = function() return string.Replace(EdgeHUD.GetPhrase("PROPLIMIT"), "%P", props) end,
		shouldDraw = function() return widgetsDrawing.proplimit end
	},
	{
		icon = Material("edgehud/icon_secondaryammo.png","smooth"),
		getData = function() return spareSecondary == -1 and secondary or secondary == -1 and spareSecondary or secondary .. "/" .. spareSecondary end,
		shouldDraw = function() return widgetsDrawing.secAmmo end
	},
	{
		icon = Material("edgehud/icon_primaryammo.png","smooth"),
		getData = function() return sparePrimary == -1 and primary or primary == -1 and sparePrimary or primary .. "/" .. sparePrimary end,
		shouldDraw = function() return widgetsDrawing.primAmmo end
	},
}

hook.Add("EdgeHUD:AddonReload","EdgeHUD:Unload_ExtraWidgets",function(  )
	timer.Remove("EdgeHUD:UpdateExtraWidgets")
	net.Receive("EdgeHUD:UpdateProplimit",function(  ) end)
end)

--[[-------------------------------------------------------------------------
Create the extra widgets
---------------------------------------------------------------------------]]

--Create a table for all widgets.
local Widgets = {}

--Loop through extraWidgets.
for i = 1,#extraWidgets do

	--Cache the current widget.
	local curWidget = extraWidgets[i]

	--Create the widget.
	local Widget = vgui.Create("EdgeHUD:WidgetBox")
	Widget:SetWide(VARS.extraWidgetsWidth)
	Widget:SetVisible(true)

	--Register the derma element.
	EdgeHUD.RegisterDerma("ExtraWidget_" .. i, Widget)

	--Insert the Widget into Widgets.
	table.insert(Widgets,Widget)

	--Create a var for the icon.
	local Icon

	--Check if the widget have an icon.
	if curWidget.icon then

		--Create the Icon.
		Icon = vgui.Create("DImage",Widget)
		Icon:SetSize(curWidget.iconSizeOverride or VARS.iconSize,curWidget.iconSizeOverride or VARS.iconSize)

		--Check if the icon is a function.
		if isfunction(curWidget.icon) then

			Icon.Think = function(  )

				Icon:SetMaterial(curWidget.icon())

			end

		else
			Icon:SetMaterial(curWidget.icon)
		end

	end

	--Create the label.
	local widgetLabel = vgui.Create("DLabel",Widget)
	widgetLabel:SetFont(curWidget.fontOverride or "EdgeHUD:Small")
	widgetLabel:SetTextColor(COLORS["White"])
	widgetLabel:SetText(DarkRP.deLocalise(curWidget.getData()))
	widgetLabel:SizeToContents()
	widgetLabel:SetWide(math.min( Widget:GetWide() * 0.9 - VARS.labelMargin - VARS.iconSize, widgetLabel:GetWide()))


	--Create a function to positon the icon and label easily.
	Widget.SetElementPositions = function(  )

		--Check if we have a icon.
		if Icon then

			--Set the position.
			local iconPos = Widget:GetWide() / 2 - (Icon:GetWide() + VARS.labelMargin + widgetLabel:GetWide()) / 2

			Icon:SetPos(iconPos,VARS.iconMargin)
			widgetLabel:SetPos(iconPos + Icon:GetWide() + VARS.labelMargin, Widget:GetTall() / 2 - widgetLabel:GetTall() / 2)

		else

			widgetLabel:SetPos(Widget:GetWide() / 2 - widgetLabel:GetWide() / 2, Widget:GetTall() / 2 - widgetLabel:GetTall() / 2)

		end

	end

	--Set element positions.
	Widget.SetElementPositions()

end

--Create a timer that will update all the widgets.
timer.Create("EdgeHUD:ExtraWidgets",0.05,0,function(  )

	local xPos
	local nextPos

	if ply:InVehicle() and Photon and ply:GetVehicle():IsEMV() then
		xPos = screenWidth - 170 - VARS.ScreenMargin * 2 - VARS.extraWidgetsWidth
		nextPos = screenHeight - VARS.ScreenMargin - VARS.WidgetHeight
	else
		xPos = screenWidth - VARS.ScreenMargin - VARS.extraWidgetsWidth - EdgeHUD.RightOffset
		nextPos = screenHeight - VARS.ScreenMargin - VARS.WidgetHeight - EdgeHUD.BottomOffset
	end

	--Loop through the widgets.
	for i = 1,#Widgets do

		--Cache the current widget.
		local curWidget = Widgets[i]

		--Get the label.
		local label = curWidget:GetChildren()[2]

		--Get the data.
		local data = extraWidgets[i].getData()

		--Check if the widget's data has been updated.
		if label:GetValue() != data then

			--Update the label.
			label:SetText(DarkRP.deLocalise(data))
			label:SizeToContents()
			label:SetWide(math.min( curWidget:GetWide() * 0.9 - VARS.labelMargin - VARS.iconSize, label:GetWide()))

			--Update element positions.
			curWidget.SetElementPositions()

		end

		--Check if the widget should be visible.
		local shouldDraw = extraWidgets[i].shouldDraw() and EdgeHUD.Configuration.GetConfigValue( "LowerRight" )

		--Check if the visibility needs to be updated.
		if curWidget:IsVisible() != shouldDraw then
			curWidget:SetVisible(shouldDraw)
		end

		--Check if we need to update the pos.
		if shouldDraw == true then

			--Update the position.
			curWidget:SetPos(xPos, nextPos)

			--Update nextPos.
			nextPos = nextPos - VARS.ElementsMargin - VARS.WidgetHeight

		end

	end

end)

hook.Add("EdgeHUD:AddonReload","EdgeHUD:Unload_ExtraWidgets2",function(  )
	timer.Remove("EdgeHUD:ExtraWidgets")
end)