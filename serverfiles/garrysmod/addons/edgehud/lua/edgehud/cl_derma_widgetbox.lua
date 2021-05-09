--Create a table for all WidgetBox elements.
local widgetBoxes = {}

--[[-------------------------------------------------------------------------
Obtain colors and vars.
---------------------------------------------------------------------------]]
local Black_Transparent = EdgeHUD.Colors["Black_Transparent"]
local White_Outline = EdgeHUD.Colors["White_Outline"]
local White_Corners = EdgeHUD.Colors["White_Corners"]

local defaultHeight = EdgeHUD.Vars.WidgetHeight


--[[-------------------------------------------------------------------------
UpdateInfo manager.
---------------------------------------------------------------------------]]

--Create a timer that will call teh updateInfo functions.
timer.Create("EdgeHUD:UpdateInfo",1,0,function( )

	--Loop through all widgetBoxes.
	for k,v in pairs(widgetBoxes) do

		--Call the UpdateINfo function.
		k.UpdateInfo()

	end

end)

--[[-------------------------------------------------------------------------
Should draw manager.
---------------------------------------------------------------------------]]

--Create a var for ply.
local ply = LocalPlayer()

local nextTimerCheck = 0

--Create a local variable for if the HUD should be drawn or not.
EdgeHUD.shouldDraw = true

-- Create a var for spawnmenu.
local spawnMenuOpen = false

if EdgeHUD.Configuration.GetConfigValue("HideWhenSpawnmenu") == true then

	hook.Add("OnSpawnMenuOpen","EdgeHUD:SpawnMenuOpen",function(  )
		spawnMenuOpen = true
		EdgeHUD.RunVisibilityCheck()
	end)

	hook.Add("OnSpawnMenuClose","EdgeHUD:SpawnMenuClose",function(  )
		spawnMenuOpen = false
		EdgeHUD.RunVisibilityCheck()
	end)

end

if EdgeScoreboard then

	hook.Add("ScoreboardShow","EdgeHUD:EdgeScoreboardShow",function(  )
		timer.Simple(0,function (  )
			EdgeHUD.RunVisibilityCheck()
		end)
	end)
	hook.Add("ScoreboardHide","EdgeHUD:EdgeScoreboardHide",function(  )
		timer.Simple(0,function (  )
			EdgeHUD.RunVisibilityCheck()
		end)
	end)

end

function EdgeHUD.RunVisibilityCheck()

	nextTimerCheck = os.time() + 0.25

	-- Check if EdgeScoreboard wants us to hide.
	local hideFromScoreboard = EdgeScoreboard and EdgeScoreboard.GetConfigValue and EdgeScoreboard.GetConfigValue("HideHUD") and IsValid(EdgeScoreboard.boardPanel) and EdgeScoreboard.boardPanel:IsVisible()

	--Check if cl_drawhud is set to 1/0.
	if GetConVar("cl_drawhud"):GetInt() == 0 or gui.IsGameUIVisible() or EdgeHUD.Disconnected == true or spawnMenuOpen or hideFromScoreboard then
		EdgeHUD.shouldDraw = false
	else

		--Get the player's active weapon.
		local wep = ply:GetActiveWeapon()

		--Make sure that the player's weapon is valid.
		if IsValid(wep) then

			--CHeck if the player is holding a camera.
			if wep:GetClass() == "gmod_camera" then
				EdgeHUD.shouldDraw = false
			else
				EdgeHUD.shouldDraw = true
			end

		else
			EdgeHUD.shouldDraw = true
		end

	end

	--Update the visibility of all boxes.
	for k,v in pairs(widgetBoxes) do

		if k.renderBehindOther == true then
			k:MoveToBack()
		end

		--Get the alpha of the panel.
		local Alpha = k:GetAlpha()

		--Check if their alpha should be changed.
		if EdgeHUD.shouldDraw == true and Alpha == 0 then
			k:AlphaTo(255,0.2)
		elseif EdgeHUD.shouldDraw == false and Alpha == 255 then
			k:AlphaTo(0,0.2)
		end

	end

end

hook.Add("EdgeHUD:RunVisibilityCheck","EdgeHUD:UpdateVisibility",EdgeHUD.RunVisibilityCheck)

--Create a think-timer that is called 2 times a second and that determines if the HUD should be drawn.
hook.Add("Think","EdgeHUD:ShouldDrawHUD",function(  )

	--Check when we should call next.
	if nextTimerCheck > os.time() then return end

	-- Run the visibilitycheck.
	EdgeHUD.RunVisibilityCheck()

end)

--[[-------------------------------------------------------------------------
Create the element.
---------------------------------------------------------------------------]]

--Create the table used for the element.
local PANEL = {}

--Create a init function for the element.
function PANEL:Init()

	--Set the default size.
	self:SetSize( 150, defaultHeight )

	--Add the element to widgetBoxes.
	widgetBoxes[self] = true

	self.renderBehindOther = true

end

--PAint the element.
function PANEL:Paint( w, h )

	--Draw the background.
	surface.SetDrawColor(Black_Transparent)
	surface.DrawRect(0,0,w,h)

	--Draw the white outline.
	surface.SetDrawColor(White_Outline)
	surface.DrawOutlinedRect(0,0,w,h)

	--Draw the corners.
	surface.SetDrawColor(White_Corners)
	EdgeHUD.DrawEdges(0,0,w,h, 8)

end

--Create a OnRemove function for the panel that can be used when coding.
function PANEL:OnRemove2(  ) end

--Create a OnRemove function for the panel.
function PANEL:OnRemove(  )

	--Call OnRemove2.
	self:OnRemove2()

	--Remove the panel from the widgetBoxes table.
	widgetBoxes[self] = nil

end

--Create a function that will be called every second and that is used update information shown on the widget.
function PANEL:UpdateInfo()

end

--Register the derma element.
vgui.Register( "EdgeHUD:WidgetBox", PANEL, "Panel" )

hook.Add("EdgeHUD:AddonReload","EdgeHUD:Unload_WidgetBox",function(  )
	hook.Remove("Think","EdgeHUD:ShouldDrawHUD")
	hook.Remove("OnSpawnMenuOpen","EdgeHUD:SpawnMenuOpen")
	hook.Remove("OnSpawnMenuClose","EdgeHUD:SpawnMenuClose")
	hook.Remove("EdgeHUD:RunVisibilityCheck","EdgeHUD:UpdateVisibility")
	hook.Remove("ScoreboardShow","EdgeHUD:ScoreboardShow")
	hook.Remove("ScoreboardHide","EdgeHUD:ScoreboardHide")
	timer.Remove("EdgeHUD:UpdateInfo")
end)