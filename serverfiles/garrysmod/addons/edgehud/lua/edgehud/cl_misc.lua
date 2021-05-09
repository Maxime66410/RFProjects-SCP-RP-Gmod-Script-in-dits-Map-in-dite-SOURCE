--Create a variable for the local player.
local ply = LocalPlayer()

--Create a copy of the colors and vars table.
local COLORS = table.Copy(EdgeHUD.Colors)
local VARS = table.Copy(EdgeHUD.Vars)

local screenWidth = ScrW()
local screenHeight = ScrH()

--[[-------------------------------------------------------------------------
Warning Popup
---------------------------------------------------------------------------]]

--Create a var for the warningpopupHeight and width.
local warningPopupWidth = screenHeight * 0.8
local warningPopupHeight = screenHeight * 0.1

--Create a var that holds the margin for the PopupText.
local popupMargin = warningPopupHeight * 0.12

--Create a table that will hold the queue of warning popups.
local popupQueue = {}

--Create a variable that will hold the active popup.
local activePopup

--Create a function to show a warning popup.
function EdgeHUD.ShowHUDPopup( Clr, Title, Message )

	--Check so we got any values.
	if Clr then

		--Add the popup to queue.
		table.insert(popupQueue,{Clr = Clr, Title = Title, Message = Message})

	end

	--WAit for the current active popup to complete if there is one.
	if !IsValid(activePopup) then

		--Save the current popup.
		local curPopup = table.Copy(popupQueue[1])

		--Remove popupQueue[1].
		popupQueue[1] = nil

		--Clear the table keys.
		popupQueue = table.ClearKeys(popupQueue)

		--Create the WidgetBox.
		local Popup = vgui.Create("EdgeHUD:WidgetBox")
		Popup:SetAlpha(0)
		Popup:AlphaTo(255,0.5)
		Popup:SetSize(warningPopupWidth,warningPopupHeight)
		Popup:SetPos(screenWidth / 2 - warningPopupWidth / 2, screenHeight * 0.2)

		--Set the activePopup.
		activePopup = Popup

		--Create the popupTitle.
		local popupTitle = vgui.Create("DLabel",Popup)
		popupTitle:SetFont("EdgeHUD:Large")
		popupTitle:SetTextColor(curPopup.Clr)
		popupTitle:SetText(DarkRP.deLocalise(curPopup.Title))
		popupTitle:SizeToContents()
		popupTitle:SetPos(Popup:GetWide() / 2 - popupTitle:GetWide() / 2, popupMargin)

		--Create the popupMessage.
		local popupMessage = vgui.Create("DLabel",Popup)
		popupMessage:SetFont("EdgeHUD:Medium")
		popupMessage:SetTextColor(COLORS["White"])
		popupMessage:SetText(DarkRP.deLocalise(curPopup.Message))
		popupMessage:SizeToContents()
		popupMessage:SetWide(math.min(popupMessage:GetWide(), Popup:GetWide() * 0.95))
		popupMessage:SetPos(Popup:GetWide() / 2 - popupMessage:GetWide() / 2, warningPopupHeight - popupMessage:GetTall() - popupMargin - (screenHeight * 0.002))

		--Create a timer that will remove the popup.
		timer.Simple(6,function(  )

			if !IsValid(Popup) then return end

			Popup:AlphaTo(0,1.5,0,function(  )

				if !IsValid(Popup) then return end

				--Remove the popup.
				Popup:Remove()

				--Check if there is more items in queue.
				if #popupQueue > 0 then
					EdgeHUD.ShowHUDPopup( )
				end

			end)

		end)

	end

end

net.Receive("EdgeHUD:PopupMsg",function(  )
	EdgeHUD.ShowHUDPopup(net.ReadColor(),net.ReadString(),net.ReadString())
end)

hook.Add("EdgeHUD:AddonReload","EdgeHUD:Unload_WarningPopup",function(  )
	if IsValid(activePopup) then activePopup:Remove() end
end)


--[[-------------------------------------------------------------------------
Vehicle Display
---------------------------------------------------------------------------]]

if EdgeHUD.Configuration.GetConfigValue( "VehicleDisplay" ) then

	--Create materials.
	local MAT_LOCKED =  Material("edgehud/icon_locked.png", "smooth")
	local MAT_UNLOCKED =  Material("edgehud/icon_unlocked.png", "smooth")

	--Add a receiver for EdgeHUD:UpdateLocked.
	net.Receive("EdgeHUD:UpdateLocked",function(  )

		local isLocked = net.ReadBool()
		local ent = net.ReadEntity()

		if !IsValid(ent) then return end

		ent.EdgeHUD_Locked = isLocked

	end)

	--Create some vars.
	local vehicleIconSize = screenHeight * 0.036
	local textMargin = math.floor(screenHeight * 0.001)

	--Get vehicles list.
	local vehicleList

	--Create all the required elements.
	local vehiclePanel = vgui.Create("EdgeHUD:WidgetBox")
	local vehicleLock = vgui.Create("DImage",vehiclePanel)
	local vehicleTitle = vgui.Create("DLabel",vehiclePanel)
	local vehicleRows = {
		vgui.Create("DPanel",vehiclePanel),
		vgui.Create("DPanel",vehiclePanel),
		vgui.Create("DPanel",vehiclePanel)
	}

	--Register the derma element and make the element invisible.
	EdgeHUD.RegisterDerma("VehicleDisplay", vehiclePanel)
	vehiclePanel:SetVisible(false)

	--Give all teh vehicleRows a text value.
	for i = 1,#vehicleRows do

		--Set the default text.
		vehicleRows[i].text = ""

		--Give them a drawfunction.
		vehicleRows[i].Paint = function( s, w, h )
			draw.SimpleText(s.text or "","EdgeHUD:VehicleHUD:Small",0,h / 2,COLORS["White"],TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
		end

	end

	--Set the vehicleLock default icon.
	vehicleLock:SetMaterial(MAT_UNLOCKED)
	vehicleLock:SetSize(vehicleIconSize,vehicleIconSize)

	--Set the titleSettings.
	vehicleTitle:SetFont("EdgeHUD:VehicleHUD:Large")
	vehicleTitle:SetTextColor(COLORS["White"])

	local lastData = ""

	--Create a function to position all the elements.
	vehiclePanel.PositionElements = function( locked, title, ownerTitle, coOwners, allowedCoOwners )

		local newData = util.TableToJSON({locked, title, ownerTitle, coOwners, allowedCoOwners})

		if lastData == newData then return end
		lastData = newData

		--Start by reseting.
		vehiclePanel.Reset()

		--Set all the values.
		vehicleLock:SetMaterial(locked and MAT_LOCKED or MAT_UNLOCKED)
		vehicleTitle:SetText(title)
		vehicleTitle:SizeToContents()
		vehicleRows[1].text = ownerTitle

		--Get the textSize.
		surface.SetFont("EdgeHUD:VehicleHUD:Small")
		local maxTextWidth, rowHeight = surface.GetTextSize(ownerTitle)

		--Create a var for the amount of rows.
		local rows = 1

		--Check if the title is longer.
		maxTextWidth = math.max(maxTextWidth,vehicleTitle:GetWide())

		--Check if we have any coOwners.
		if #coOwners != 0 then

			--Add +1 to rows.
			rows = rows + 1

			--Set the text.
			vehicleRows[rows].text = EdgeHUD.GetPhrase("VEHICLE_COOWNERS") .. " " .. table.concat(coOwners,", ")

			--Get the rowWidth.
			local rowWidth, _ = surface.GetTextSize(vehicleRows[rows].text)

			--Update maxTextWidth
			maxTextWidth = math.max(maxTextWidth,rowWidth)

		end

		--Check if we have any allowed coOwners.
		if #allowedCoOwners != 0 then

			--Add +1 to rows.
			rows = rows + 1

			vehicleRows[rows].text = EdgeHUD.GetPhrase("VEHICLE_ALLOWED_COOWNERS") .. " " .. table.concat(allowedCoOwners,", ")

			--Get the rowWidth.
			local rowWidth, _ = surface.GetTextSize(vehicleRows[rows].text)

			--Update maxTextWidth
			maxTextWidth = math.max(maxTextWidth,rowWidth)

		end

		--Make sure the maxTextWidth isn't too long.
		maxTextWidth = math.min(maxTextWidth,screenWidth * 0.6)

		--Calculate the height.
		local vehicleBoxHeight = math.floor(VARS.ElementsMargin * 2 + vehicleTitle:GetTall() + rowHeight * rows + textMargin * rows)
		local textXPos = VARS.ElementsMargin * 2 + vehicleIconSize

		--Calculate the positions and sizes.
		vehiclePanel:SetSize(VARS.ElementsMargin * 3 + vehicleIconSize + maxTextWidth,vehicleBoxHeight)
		vehiclePanel:SetPos(screenWidth / 2 - vehiclePanel:GetWide() / 2, screenHeight * 0.9 - vehiclePanel:GetTall() / 2 )

		vehicleLock:SetPos(VARS.ElementsMargin, vehiclePanel:GetTall() / 2 - vehicleLock:GetTall() / 2)
		vehicleTitle:SetPos(textXPos, VARS.ElementsMargin)
		vehicleTitle:SetWide(maxTextWidth)

		--Loop through all vehicleRows.
		for i = 1,#vehicleRows do

			--Set their size.
			vehicleRows[i]:SetSize(maxTextWidth, rowHeight)

			--Set their position.
			vehicleRows[i]:SetPos(textXPos,VARS.ElementsMargin + vehicleTitle:GetTall() + textMargin * i + rowHeight * (i - 1))

		end

		--Make the element visible.
		vehiclePanel:SetVisible(true)

	end

	vehiclePanel.Reset = function(  )

		--Reset the title.
		vehicleTitle:SetText("")

		--Reset the rows.
		for k,v in pairs(vehicleRows) do
			v.text = ""
		end

		--Reset the lastData.
		lastData = ""

		--Make the panel invisible.
		vehiclePanel:SetVisible(false)

	end

	--Add a timer that updates the vehicle display.
	timer.Create("EdgeHUD:VehicleDisplay_Updater", 0.1, 0, function(  )

		if !IsValid(vehiclePanel) then return end

		--Check if we should draw.
		if !EdgeHUD.shouldDraw then vehiclePanel.Reset() return end

		if ply:InVehicle() then vehiclePanel.Reset() return end

		--Make sure vehicleList has a value.
		vehicleList = vehicleList or list.Get("Vehicles")

		--Get the player eyetrace.
		local eyeTrace = ply:GetEyeTrace()

		--Get the entity.
		local vehicle = eyeTrace.Entity

		--MAke sure it's valid.
		if !IsValid(vehicle) then vehiclePanel.Reset() return end

		if !vehicle:IsVehicle() then vehiclePanel.Reset() return end

		--Get the class.
		local class = vehicle:GetClass()

		--Make sure it's not a chair.
		if class == "prop_vehicle_prisoner_pod" then vehiclePanel.Reset() return end

		--Check so we are close enough.
		if ply:GetPos():DistToSqr( vehicle:GetPos() ) > 200^2 then vehiclePanel.Reset() return end

		--Create a var for if the vehicle LockStatus.
		local lockStatus = false

		--Check if the vehicle has a locked var.
		if vehicle.EdgeHUD_Locked == nil and (vehicle.EdgeHUD_DataRequestSent == nil or vehicle.EdgeHUD_DataRequestSent != nil and vehicle.EdgeHUD_DataRequestSent + 5 < os.time()) then

			--Set a var that a request has been sent.
			vehicle.EdgeHUD_DataRequestSent = os.time()

			--Request a value from the server.
			net.Start("EdgeHUD:RequestLockUpdate")
				net.WriteEntity(vehicle)
			net.SendToServer()

		else
			lockStatus = vehicle.EdgeHUD_Locked
		end

		--Get the veheicleData.
		local vehicleData = vehicle:getDoorData()

		--Create a var for the vehicle name and title.
		local name = ""
		local owner = ""
		local allowedCoOwners = {}
		local coOwners = {}

		--Get the vehicle classname.
		local vehicleClass = vehicle:GetVehicleClass()

		--Set the name of the vehicle.
		if vehicleData.title then
			name = vehicleData.title
		elseif vehicleClass and vehicleList[vehicleClass] then
			name = vehicleList[vehicleClass].Name
		else
			name = EdgeHUD.GetPhrase("VEHICLE")
		end

		--Check who is the owner of the vehicle.
		if vehicleData.groupOwn then
			owner = string.Replace(EdgeHUD.GetPhrase("VEHICLE_ACCESS_GROUP"), "%G", vehicleData.groupOwn)
		elseif vehicleData.nonOwnable then
			owner = EdgeHUD.GetPhrase("VEHICLE_NOTOWNABLE")
		elseif vehicleData.teamOwn then
			owner = string.Replace(EdgeHUD.GetPhrase("VEHICLE_ACCESS_JOBS"), "%J", table.Count(vehicleData.teamOwn))
		elseif vehicleData.owner then

			--Get the owner.
			local vehicleOwner = Player(vehicleData.owner)

			--Check so the owner is valid.
			if IsValid(vehicleOwner) then
				owner = string.Replace(EdgeHUD.GetPhrase("VEHICLE_OWNER"), "%N", vehicleOwner:Name())
			else
				owner = EdgeHUD.GetPhrase("VEHICLE_OWNER_UNKNOWN")
			end

			if vehicleData.allowedToOwn then

				--Loop through the players.
				for k,v in pairs(vehicleData.allowedToOwn) do

					--Get the allowed CoOwner.
					local allowedCoOwner = Player(k)

					--Make sure the player is valid.
					if !IsValid(allowedCoOwner) then continue end

					--Add the player to the list.
					table.insert(allowedCoOwners, allowedCoOwner:Name())

				end

			end

			if vehicleData.extraOwners then

				for k,v in pairs(vehicleData.extraOwners) do

					--Get the allowed CoOwner.
					local CoOwner = Player(k)

					--Make sure the player is valid.
					if !IsValid(CoOwner) then continue end

					--Add the player to the list.
					table.insert(coOwners, CoOwner:Name())

				end

			end

		else
			owner = EdgeHUD.GetPhrase("VEHICLE_UNOWNED")
		end


		vehiclePanel.PositionElements(lockStatus,name,owner,coOwners,allowedCoOwners)

	end)

	hook.Add("EdgeHUD:AddonReload","EdgeHUD:Unload_VehicleDisplay",function(  )

		if IsValid(vehiclePanel) then
			vehiclePanel:Remove()
		end

		timer.Remove("VehicleDisplay_Updater")
		net.Receive("EdgeHUD:UpdateLocked",function(  )	end)

	end)

end


--[[-------------------------------------------------------------------------
Situation Trigger.
---------------------------------------------------------------------------]]

if EdgeHUD.Configuration.GetConfigValue( "LockdownPopup" ) then

	--Create vars that checks the last value of the var.
	local lastLockdown = GetGlobalBool("DarkRP_LockDown")

	--Create a timer that keeps track of if the player get's wanted or a lockdown is issued.
	timer.Create("EdgeHUD:SituationTrigger",0.5,0,function(  )

		--Get updated vars.
		local newLockdown = GetGlobalBool("DarkRP_LockDown")

		--Check if a lockdown has started.
		if lastLockdown == false and newLockdown == true then
			EdgeHUD.ShowHUDPopup( Color(255,106,106), EdgeHUD.GetPhrase("LOCKDOWN"), EdgeHUD.GetPhrase("LOCKDOWN_INITIATED") )
		end

		--Update the vars.
		lastLockdown = newLockdown

	end)

	hook.Add("EdgeHUD:AddonReload","EdgeHUD:Unload_SituationTrigger",function(  )
		timer.Remove("EdgeHUD:SituationTrigger")
	end)

end

--[[-------------------------------------------------------------------------
Door Menu
---------------------------------------------------------------------------]]

if EdgeHUD.Configuration.GetConfigValue( "DoorMenu" ) then

	local MAT_Gear = Material("edgehud/icon_gear.png", "smooth")

	--Create a table for what icon every specific button should have based on it's phrase.
	local buttonInfo = {
		[DarkRP.getPhrase("sell_x", DarkRP.getPhrase("door"))] = {Material("edgehud/icon_handshake.png", "smooth"),EdgeHUD.GetPhrase("DOORMENU_SELL_DOOR")},
		[DarkRP.getPhrase("sell_x", DarkRP.getPhrase("vehicle"))] = {Material("edgehud/icon_handshake.png", "smooth"),EdgeHUD.GetPhrase("DOORMENU_SELL_VEHICLE")},
		[DarkRP.getPhrase("buy_x", DarkRP.getPhrase("door"))] = {Material("edgehud/icon_handshake.png", "smooth"),EdgeHUD.GetPhrase("DOORMENU_BUY_DOOR")},
		[DarkRP.getPhrase("buy_x", DarkRP.getPhrase("vehicle"))] = {Material("edgehud/icon_handshake.png", "smooth"),EdgeHUD.GetPhrase("DOORMENU_BUY_VEHICLE")},
		[DarkRP.getPhrase("add_owner")] = {Material("edgehud/icon_plus.png", "smooth"),EdgeHUD.GetPhrase("DOORMENU_ADDOWNER")},
		[DarkRP.getPhrase("remove_owner")] = {Material("edgehud/icon_minus.png", "smooth"),EdgeHUD.GetPhrase("DOORMENU_REMOVEOWNER")},
		[DarkRP.getPhrase("allow_ownership")] = {Material("edgehud/icon_granted.png", "smooth"),EdgeHUD.GetPhrase("DOORMENU_ALLOWOWNERSHIP")},
		[DarkRP.getPhrase("disallow_ownership")] = {Material("edgehud/icon_denied.png", "smooth"),EdgeHUD.GetPhrase("DOORMENU_DISALLOWOWNERSHIP")},
		[DarkRP.getPhrase("set_x_title", DarkRP.getPhrase("door"))] = {Material("edgehud/icon_textbox.png", "smooth"),EdgeHUD.GetPhrase("DOORMENU_SETTITLE_DOOR")},
		[DarkRP.getPhrase("set_x_title", DarkRP.getPhrase("vehicle"))] = {Material("edgehud/icon_textbox.png", "smooth"),EdgeHUD.GetPhrase("DOORMENU_SETTITLE_VEHICLE")},
		[DarkRP.getPhrase("edit_door_group")] = {MAT_Gear,EdgeHUD.GetPhrase("DOORMENU_EDITGROUPS")},
	}

	hook.Add("onKeysMenuOpened","EdgeHUD:DoorMenu",function( ent, frame )

		--Disable the sandbox crosshair.
		hook.Add("HUDShouldDraw","EdgeHUD:RemoveCrosshair_DoorMenu",function( name )
			if name == "CHudCrosshair" then return false end
		end)

		--Get the onRemove function of the frame.
		local oldFunc = frame.OnRemove or function(  ) end

		--Inject into the ONRemove function of the frame.
		frame.OnRemove = function( ... )

			--Enable the crosshair again.
			hook.Remove("HUDShouldDraw","EdgeHUD:RemoveCrosshair_DoorMenu")

			--Call the old func and return data.
			return oldFunc(...)

		end

		--Get the Frame's child panels.
		local panels = frame:GetChildren()

		--Remove the PerformLayout function of the DFrame.
		frame.PerformLayout = function(  )	end

		--Remove some elements.
		for i = 1,4 do
			panels[i]:Remove()
			panels[i] = nil
		end

		--Clear the keys of panels.
		panels = table.ClearKeys(panels)

		--Make the Frame fullscreen.
		frame:SetSize(ScrW(),ScrH())

		--Make the frame invisible.
		frame.Paint = function(  ) end

		local closeCooldown = CurTime() + 0.2
		local allowClose = false

		frame.Think = function(  )

			--Check if the F2 key is pressed.
			if input.IsKeyDown(KEY_F2) then

				-- Return if we have a cooldown.
				if closeCooldown > CurTime() or !allowClose then return end

				frame:Close()
			else

				--Make sure that the F2 key is released once since the menu was opened.
				allowClose = true

			end

		end

		--Circle data.
		local xPos = ScrW() / 2
		local yPos = ScrH() / 2
		local radius = ScrH() * 0.3
		local seg = table.Count(panels)
		local circleData = {}

		for i = 1, seg do
			local a = math.rad( ( i / seg ) * -360 )
			table.insert( circleData, { x = xPos + math.sin( a ) * radius, y = yPos + math.cos( a ) * radius } )
		end

		--Determine the size of the buttons.
		local buttonWidth = ScrH() * 0.2
		local buttonHeight = ScrH() * 0.08

		--Determine the icon size.
		local iconSize = buttonHeight * 0.35

		--Create the closebutton.
		local closeButton = vgui.Create("DButton",frame)
		closeButton:SetText(EdgeHUD.GetPhrase("CLOSE"))
		closeButton:SetSize(ScrH() * 0.12,ScrH() * 0.04)
		closeButton:SetPos(ScrW() / 2 - closeButton:GetWide() / 2, ScrH() / 2 - closeButton:GetTall() / 2)

		--Create a DoClick function for the closeButton.
		closeButton.DoClick = function(  )
			frame:Close()
		end

		--Insert the closeButton into panels.
		table.insert(panels,closeButton)

		--Loop through the panels again.
		for k,v in pairs(panels) do

			--Change the font.
			v:SetFont("EdgeHUD:DoorMenu")
			v:SetTextColor(COLORS["White"])

			--Reskin the buttons.
			v.Paint = function( s, w, h )

				--Draw the background.
				surface.SetDrawColor(s:IsHovered() and COLORS["Gray_Transparent"] or COLORS["Black_Transparent"])
				surface.DrawRect(0,0,w,h)

				--Draw the white outline.
				surface.SetDrawColor(COLORS["White_Outline"])
				surface.DrawOutlinedRect(0,0,w,h)

				--Draw the corners.
				surface.SetDrawColor(COLORS["White_Corners"])
				EdgeHUD.DrawEdges(0,0,w,h, 8)

			end

			--Check if the circleData[k] exists. (Closebutton does not need to have its position/size changed)
			if circleData[k] then

				--Set the size.
				v:SetSize(buttonWidth,buttonHeight)

				--Set the position.
				v:SetPos(circleData[k].x - v:GetWide() / 2,circleData[k].y - v:GetTall() / 2)

				--Create a copy of the old paint function.
				local oldPaint = v.Paint

				--Get the icon.
				local icon = buttonInfo[v:GetValue()] and buttonInfo[v:GetValue()][1] or MAT_Gear

				--Reposition the text in the button.
				v.Paint = function( s, w, h )

					--Call the old paint function.
					oldPaint(s, w, h)

					--Draw the icon.
					surface.SetDrawColor(COLORS["White"])
					surface.SetMaterial(icon)
					surface.DrawTexturedRect(w / 2 - iconSize / 2,h * 0.15,iconSize,iconSize)

					--Draw the text.
					draw.SimpleText(v:GetValue(),"EdgeHUD:DoorMenu",w / 2,h * 0.85,COLORS["White"],TEXT_ALIGN_CENTER,TEXT_ALIGN_BOTTOM)

					--Return true to not draw the text.
					return true

				end


			end

			--Set the text.
			v:SetText(buttonInfo[v:GetValue()] and buttonInfo[v:GetValue()][2] or v:GetValue())

		end

	end)


	hook.Add("EdgeHUD:AddonReload","EdgeHUD:Unload_DoorMenu",function(  )
		hook.Remove("onKeysMenuOpened","EdgeHUD:DoorMenu")
	end)

end

--[[-------------------------------------------------------------------------
Notification system
---------------------------------------------------------------------------]]

local notificationSystemConfig = EdgeHUD.Configuration.GetConfigValue( "NotificationSystem" )

--Check if EdgeHUD should load the notifications or if another addon has been given priority.
if notificationSystemConfig != "Other Design" then

	if notificationSystemConfig == "EdgeHUD Design" then

		--REad the original derma file.
		local notificationDermaFile = file.Read("lua/includes/modules/notification.lua","GAME")

		--Append code to the bottom so we get access to the panel.
		notificationDermaFile = notificationDermaFile .. "\nEdgeHUD.NotificationPanel = PANEL"

		--Change the notification startpos.
		notificationDermaFile = string.Replace(notificationDermaFile,"local ideal_y = ScrH() - 150 - h - total_h","local ideal_y = ScrH() - 210 - h - total_h")

		--Make it idiot proof to avoid unnecessary errors pointing to EdgeHUD.
		notificationDermaFile = string.Replace(notificationDermaFile, "Panel.Length = length", "Panel.Length = length or 3")

		--Run the code.
		RunString(notificationDermaFile,"EdgeHUD")

		--Save the PANEL:Init function.
		EdgeHUD.NotificationPanel.oldFunc = EdgeHUD.NotificationPanel.Init

		--Create a table for the notifications.
		local notificationsTbl = {}

		--OVerride the PANEL:Init function.
		function EdgeHUD.NotificationPanel:Init(  )

			--Call the old PANEL:Init function.
			self:oldFunc()

			timer.Simple(0,function(  )

				if !IsValid(self) then return end

				local oldPos = self.fy

				self.fy = oldPos - 100

			end)

			notificationsTbl[self] = true

			--Set the default font.
			self.Label:SetFont("EdgeHUD:Notification")

			--Disable positioning stuff.
			self.Label:Dock(NODOCK)
			self.Label:SetContentAlignment(7)

		end

		function EdgeHUD.NotificationPanel:OnRemove(  )

			notificationsTbl[self] = nil

		end

		function EdgeHUD.NotificationPanel:Think()
			self:SetAlpha(EdgeHUD.shouldDraw and 255 or 0)
		end

		--Override the paint function.
		EdgeHUD.NotificationPanel.Paint = function( s,w,h )

			surface.SetDrawColor(COLORS["Black_Transparent"])
			surface.DrawRect(0,0,w,h)

			--Draw the white outline.
			surface.SetDrawColor(COLORS["White_Outline"])
			surface.DrawOutlinedRect(0,0,w,h)

			--Draw the corners.
			surface.SetDrawColor(COLORS["White_Corners"])
			EdgeHUD.DrawEdges(0,0,w,h, 8)


			if ( !s.Progress ) then return end

			--Determine the position.
			local x, y = 8, math.floor(s:GetTall() * 0.82 - 5)

			--Determine the size.
			local barBackgroundWidth, barBackgroundHeight = s:GetWide() - 16, 5

			--Draw a dark background.
			surface.SetDrawColor( 50, 50, 50, 150 )
			surface.DrawRect( x, y, barBackgroundWidth, barBackgroundHeight )

			--Draw a darker outline.
			surface.SetDrawColor(0,0,0,80)
			surface.DrawOutlinedRect(x,y,barBackgroundWidth,barBackgroundHeight)

			local barWidth = math.floor(barBackgroundWidth * 0.3)

			local propWidth = barBackgroundWidth / 100
			local prop = CurTime() % propWidth / propWidth

			local barPos = math.floor((barBackgroundWidth + barWidth) * prop)

			surface.SetDrawColor(66, 134, 244, 255)
			surface.DrawRect(math.max(x,barPos - barWidth + x) + 1,y + 1,math.min(barWidth,barBackgroundWidth + barWidth - barPos,barPos) - 2,3)

		end

		--OVerride the SizeToContents func.
		function EdgeHUD.NotificationPanel:SizeToContents(  )

			--Resize the label.
			self.Label:SizeToContents()

			--Get the size of the label.
			local width, height = self.Label:GetSize()

			--Set the height.
			local notificationHeight = 45

			--Add some margin at the sides.
			width = width + 16

			--Determine the position of the DLabel.
			local labelX, labelY = 8, notificationHeight * 0.18

			--Check if we got a valid image.
			if IsValid(self.Image) then

				--Disable docking.
				self.Image:Dock(NODOCK)

				--Set the size of the image.
				self.Image:SetSize(30,30)

				--Add the size of the image + some margin.
				width = width + self.Image:GetTall() + 8

				--Set the position of the image.
				self.Image:SetPos(8,notificationHeight / 2 - self.Image:GetTall() / 2)

				--Determine the position of the Label.
				labelX, labelY = 16 + self.Image:GetTall(),notificationHeight / 2 - height / 2

			end

			--Set the position of the label.
			self.Label:SetPos(math.floor(labelX), math.floor(labelY))

			--Set the notification size.
			self:SetSize(math.floor(width),math.floor(notificationHeight))

			--Call self:InvalidateLayout
			self:InvalidateLayout()

		end

		hook.Add("EdgeHUD:AddonReload","EdgeHUD:Unload_Notifications",function(  )

			for k,v in pairs(notificationsTbl) do
				if IsValid(k) then
					k:SetVisible(false)
				end
			end

		end)

	else

		--REad the original derma file.
		local notificationDermaFile = file.Read("lua/includes/modules/notification.lua","GAME")

		--Append code to the bottom so we get access to the panel.
		notificationDermaFile = notificationDermaFile .. "\nEdgeHUD.NotificationPanel = PANEL"

		--Make it idiot proof to avoid unnecessary errors pointing to EdgeHUD.
		notificationDermaFile = string.Replace(notificationDermaFile, "Panel.Length = length", "Panel.Length = length or 3")

		--Run the code.
		RunString(notificationDermaFile,"EdgeHUD")

		--Save the PANEL:Init function.
		EdgeHUD.NotificationPanel.oldFunc = EdgeHUD.NotificationPanel.Init

		--Create a table for the notifications.
		local notificationsTbl = {}

		--OVerride the PANEL:Init function.
		function EdgeHUD.NotificationPanel:Init(  )

			--Call the old PANEL:Init function.
			self:oldFunc()

			notificationsTbl[self] = true

		end

		function EdgeHUD.NotificationPanel:OnRemove(  )

			notificationsTbl[self] = nil

		end

		hook.Add("EdgeHUD:AddonReload","EdgeHUD:Unload_DefaultNotifications",function(  )
			for k,v in pairs(notificationsTbl) do
				if IsValid(k) then
					k:SetVisible(false)
				end
			end
		end)

	end

	--Add delayed notifications.
	for k,v in pairs(EdgeHUD_NotificationsQueue_Legacy) do
		notification.AddLegacy(v.text,v.type,v.length)
	end

	for k,v in pairs(EdgeHUD_NotificationsQueue_Progress) do
		notification.AddLegacy(k,v)
	end

	--Reset the EdgeHUD_NotificationsQueue_Legacy and EdgeHUD_NotificationsQueue_Progress.
	EdgeHUD_NotificationsQueue_Legacy = {}
	EdgeHUD_NotificationsQueue_Progress = {}

end

timer.Simple(0,function( )

	--For some reason some people are experiencing the _Notify being dropped.
	local function DisplayNotify(msg)

		local txt = msg:ReadString()
		GAMEMODE:AddNotify(txt, msg:ReadShort(), msg:ReadLong())
		surface.PlaySound("buttons/lightswitch2.wav")

		-- Log to client console
		MsgC(Color(255, 20, 20, 255), "[DarkRP] ", Color(200, 200, 200, 255), txt, "\n")

	end

	usermessage.Hook("_Notify", DisplayNotify)

end)

hook.Add("EdgeHUD:AddonReload", "EdgeHUD:ClearNotificationQueue", function ( )
	EdgeHUD_NotificationsQueue_Legacy = {}
	EdgeHUD_NotificationsQueue_Progress = {}
end)

--[[-------------------------------------------------------------------------
Crash Screen
---------------------------------------------------------------------------]]

if EdgeHUD.Configuration.GetConfigValue( "CrashScreen" ) then

	--Set cl_timeout to 1000.
	RunConsoleCommand("cl_timeout",1000)

	--Create materials.
	local icon_noconnection = Material("edgehud/icon_disconnected.png","smooth")

	--Create some vars.
	local iconSize = math.ceil(ScrH() * 0.185)
	local buttonWidth = ScrH() * 0.25
	local buttonHeight = ScrH() * 0.1

	--Create a var for the crashScreen panel.
	local crashScreen = vgui.Create("DPanel")
	crashScreen:SetSize(ScrW(),ScrH())
	crashScreen:SetAlpha(0)
	crashScreen:SetVisible(false)

	--Create a paint function.
	crashScreen.Paint = function( s, w, h )

		--Draw the background.
		surface.SetDrawColor(COLORS["Black_Crashscreen"])
		surface.DrawRect(0,0,w,h)

		surface.SetDrawColor(COLORS["White"])
		surface.SetMaterial(icon_noconnection)
		surface.DrawTexturedRect(w / 2 - iconSize / 2,h * 0.18,iconSize,iconSize)

		draw.SimpleText(EdgeHUD.GetPhrase("CRASHSCREEN_TITLE"),"EdgeHUD:CrashScreen:Large",w / 2,h * 0.23 + iconSize,COLORS["White"],TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP)
		draw.SimpleText(EdgeHUD.GetPhrase("CRASHSCREEN_TEXT1"),"EdgeHUD:CrashScreen:Small",w / 2, h * 0.34 + iconSize,COLORS["White"],TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP)
		draw.SimpleText(EdgeHUD.GetPhrase("CRASHSCREEN_TEXT2"),"EdgeHUD:CrashScreen:Small",w / 2, h * 0.37 + iconSize,COLORS["White"],TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP)

	end

	--Create a paint function for the buttons.
	local paintFunction = function( s, w, h )

		--Draw the background.
		surface.SetDrawColor(s:IsHovered() and COLORS["Gray_Transparent"] or COLORS["Black_Transparent"])
		surface.DrawRect(0,0,w,h)

		--Draw the white outline.
		surface.SetDrawColor(COLORS["White_Outline"])
		surface.DrawOutlinedRect(0,0,w,h)

		--Draw the corners.
		surface.SetDrawColor(COLORS["White_Corners"])
		EdgeHUD.DrawEdges(0,0,w,h, 8)

	end

	local finishTime = 0

	--Create reconnect button.
	local reconnectBtn = vgui.Create("DButton",crashScreen)
	reconnectBtn:SetSize(buttonWidth,buttonHeight)
	reconnectBtn:SetPos(ScrW() / 2 - buttonWidth - ScrH() * 0.04,ScrH() * 0.82 - buttonHeight)
	reconnectBtn:SetTextColor(COLORS["White"])
	reconnectBtn:SetFont("EdgeHUD:CrashScreen:Medium")
	reconnectBtn:SetText(EdgeHUD.GetPhrase("CRASHSCREEN_RECONNECT"))
	reconnectBtn.Paint = paintFunction
	reconnectBtn.Think = function (  )
		if finishTime - os.time() <= 0 then
			reconnectBtn.DoClick()
		end
	end
	reconnectBtn.DoClick = function(  )
		RunConsoleCommand("retry")
	end

	reconnectBtn.PaintOver = function( s, w, h )

		draw.SimpleText("[ " .. EdgeHUD.FormatTime( finishTime - os.time() )  .. " ]","EdgeHUD:CrashScreen:Small2",w / 2,h * 0.8,COLORS["White"],TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

	end

	--Create leave button.
	local leaveBtn = vgui.Create("DButton",crashScreen)
	leaveBtn:SetSize(buttonWidth,buttonHeight)
	leaveBtn:SetPos(ScrW() / 2 + ScrH() * 0.04, ScrH() * 0.82 - buttonHeight)
	leaveBtn:SetTextColor(COLORS["White"])
	leaveBtn:SetFont("EdgeHUD:CrashScreen:Medium")
	leaveBtn:SetText(EdgeHUD.GetPhrase("CRASHSCREEN_LEAVE"))
	leaveBtn.Paint = paintFunction
	leaveBtn.DoClick = function(  )
		RunConsoleCommand("disconnect")
	end

	--Create a var that checks when the last pingtime was.
	local lastPing = os.time()

	--Disable the crosshair.
	hook.Add("HUDShouldDraw","EdgeHUD:RemoveCrosshair_CrashScreen",function( name )
		if name == "CHudCrosshair" and EdgeHUD.Disconnected == true then return false end
	end)


	--Add a receiver for EdgeHUD:CrashScreenUpdate.
	net.Receive("EdgeHUD:CrashScreenUpdate",function(  )

		--Update lastPing.
		lastPing = os.time()

		--Check if the crashScreen exists.
		if crashScreen:IsVisible() then

			--Hide screen.
			crashScreen:AlphaTo(0,0.3,0)

			timer.Simple(0.3,function(  )
				if IsValid(crashScreen) and EdgeHUD.Disconnected == false then
					crashScreen:SetVisible(false)
				end
			end)

			--Disable mouse.
			gui.EnableScreenClicker(false)

		end

		local firstValue = EdgeHUD.Disconnected

		--Set EdgeHUD.Disconnected to false.
		EdgeHUD.Disconnected = false

		-- Update the HUD visibility
		if firstValue == true then
			hook.Run("EdgeHUD:RunVisibilityCheck")
		end

	end)

	local nextCheck = 0

	hook.Add("Think","EdgeHUD:CheckServerConnection", function(  )

		if nextCheck <= CurTime() then

			nextCheck = CurTime() + 1

			if os.time() - lastPing > 3 and EdgeHUD.Disconnected == false then

				--Set Disconnected to true.
				EdgeHUD.Disconnected = true

				--Set finishtime.
				finishTime = os.time() + EdgeHUD.Configuration.GetConfigValue( "CrashScreen_ReconnectTimer" )

				--MAke the panel visible.
				crashScreen:SetVisible(true)
				crashScreen:AlphaTo(255,0.3)

				--Enable mouse.
				gui.EnableScreenClicker(true)

				-- Update the HUD visibility
				hook.Run("EdgeHUD:RunVisibilityCheck")

			end

		end

	end)

	hook.Add("EdgeHUD:AddonReload","EdgeHUD:Unload_CrashScreen",function(  )

		hook.Remove("Think", "EdgeHUD:CheckServerConnection")

		net.Receive("EdgeHUD:CrashScreenUpdate",function(  ) end)

		crashScreen:Remove()

	end)

end

--[[-------------------------------------------------------------------------
Vehicle Warnings HUD
---------------------------------------------------------------------------]]

--Check if VCMod is installed.
if VC and EdgeHUD.Configuration.GetConfigValue( "Vehicle_DamageIndicators" )  then

	local indicators = {
		{
			Part = "light",
			Material = Material("edgehud/icon_headlight.png", "smooth"),
			getInfo = function(  )
				notification.AddLegacy(EdgeHUD.GetPhrase("VEHICLE_DMG_EXTERIORLIGHT"),NOTIFY_ERROR,10)
			end,
			showExtra = function(  ) end
		},
		{
			Part = "exhaust",
			Material = Material("edgehud/icon_exhaust.png", "smooth"),
			getInfo = function(  )
				notification.AddLegacy(EdgeHUD.GetPhrase("VEHICLE_DMG_EXHAUST"),NOTIFY_ERROR,10)
			end,
			showExtra = function(  ) end
		},
		{
			Part = "wheel",
			Material = Material("edgehud/icon_tire.png", "smooth"),
			getInfo = function(  )

				--Get the player vehicle.
				local veh = ply:GetVehicle()

				--Make sure the vehicle is valid.
				if !IsValid(veh) then return end

				--Get the damaged parts.
				local parts = veh:VC_getDamagedParts()

				--Make sure the tire is damaged.
				if !parts["wheel"] then return end

				--Create a string-var for the wheels that are damaged.
				local damagedTires = ""

				--Check what tires are damaged.
				if parts["wheel"][1] then
					damagedTires = damagedTires .. EdgeHUD.GetPhrase("VEHICLE_DMG_TIRE_FRONTLEFT") .. "/"
				end
				if parts["wheel"][2] then
					damagedTires = damagedTires .. EdgeHUD.GetPhrase("VEHICLE_DMG_TIRE_FRONTRIGHT") .. "/"
				end
				if parts["wheel"][3] then
					damagedTires = damagedTires .. EdgeHUD.GetPhrase("VEHICLE_DMG_TIRE_BACKLEFT") .. "/"
				end
				if parts["wheel"][4] then
					damagedTires = damagedTires .. EdgeHUD.GetPhrase("VEHICLE_DMG_TIRE_BACKRIGHT") .. "/"
				end

				--Show the notification
				notification.AddLegacy(string.Replace(EdgeHUD.GetPhrase("VEHICLE_DMG_TIRES"), "%T", string.Left(damagedTires,#damagedTires - 1)),NOTIFY_ERROR,10)

			end,
			showExtra = function(  ) end
		},
		{
			Part = "engine",
			Material = Material("edgehud/icon_engine_128.png", "smooth"),
			getInfo = function(  )
				notification.AddLegacy(EdgeHUD.GetPhrase("VEHICLE_DMG_ENGINE"),NOTIFY_ERROR,10)
			end,
			showExtra = function(  )

				--Get the vehicle.
				local veh = ply:GetVehicle()

				--Make sure that the vehicle is valid.
				if !IsValid(veh) then return end

				--Check if the engine light should show.
				return veh:VC_getHealth(true) <= 30

			end
		},
		{
			Part = "lowFuel",
			Material = Material("edgehud/icon_fuel_128.png", "smooth"),
			overrideColor = Color(219, 157, 0),
			getInfo = function(  ) end,
			showExtra = function(  )

				--Get the vehicle.
				local veh = ply:GetVehicle()

				--Make sure that the vehicle is valid.
				if !IsValid(veh) then return end

				--Check if the fuel is low.
				return veh:VC_fuelGet(true) <= 30

			end
		},
		{
			Part = "cruiseControl",
			Material = Material("edgehud/icon_speedometer_128.png", "smooth"),
			overrideColor = Color(88, 171, 75),
			getInfo = function(  ) end,
			showExtra = function(  )

				--Get the vehicle.
				local veh = ply:GetVehicle()

				--Make sure that the vehicle is valid.
				if !IsValid(veh) then return end

				--Check if cruise control is enabled.
				return veh:VC_getCruise() != nil

			end
		},
	}

	local startPos = screenWidth / 2 - (VARS.WidgetHeight * 4 + VARS.ElementsMargin * 3) / 2

	--Create the widgets.
	for k,v in pairs(indicators) do

		indicators[k].Element = vgui.Create("EdgeHUD:WidgetBox")
		indicators[k].Element:SetWidth(VARS.WidgetHeight)
		indicators[k].Element:SetVisible(false)

		indicators[k].Element:SetPos(startPos + (VARS.ElementsMargin + VARS.WidgetHeight) * k,screenHeight - VARS.ElementsMargin - VARS.WidgetHeight - EdgeHUD.BottomOffset)

		indicators[k].Element.PaintOver = function( s, w, h )

			surface.SetDrawColor(v.overrideColor or COLORS["Red"])
			surface.SetMaterial(v.Material)
			surface.DrawTexturedRect(w * 0.18 + 1,h * 0.18 + 1,w * 0.64,h * 0.64)

		end

		local button = vgui.Create("DButton",indicators[k].Element)
		button:SetSize(VARS.WidgetHeight,VARS.WidgetHeight)
		button:SetText("")
		button.Paint = function(  ) end
		button.DoClick = v.getInfo

	end

	--Create a var that holds if the indicators may be visible or not.
	local isVisible = false

	--Create a function to update the HUD.
	timer.Create("EdgeHUD:UpdateVehicleIndicators",0.2,0,function(  )

		local didChange = false

		if EdgeHUD.Player_IsDriver then

			local veh = ply:GetVehicle()

			--Check so the vehicle exists.
			if !IsValid(veh) then return end

			--Make sure VCMOd is loaded.
			if !veh.VC_getDamagedParts then return end

			--Set isVisible to true.
			isVisible = true

			--Get the damaged parts.
			local parts = veh:VC_getDamagedParts()

			--Loop through the indicators.
			for k,v in pairs(indicators) do

				--Check if the part is damaged.
				if (parts[v.Part] or v.showExtra() == true) and v.Element:IsVisible() == false then

					--Change didChange to true.
					didChange = true

					--Make the element visible.
					v.Element:SetVisible(true)

					--Show the information.
					v.getInfo()

				elseif !parts[v.Part] and v.showExtra() == false and v.Element:IsVisible() == true then

					--Change didChange to true.
					didChange = true

					--Make the element visible.
					v.Element:SetVisible(false)

				end

			end

		else

			--Check if the indicators are visible.
			if isVisible == true then

				--Make them invisible.
				for k,v in pairs(indicators) do

					didChange = true

					v.Element:SetVisible(false)

				end

				--Set isVisible to false.
				isVisible = false

			end

		end

		--Check if any of the indicators changed.
		if didChange == true then

			--Create a var for how many are visible.
			local visible = 0

			--Check how many are visible.
			for k,v in pairs(indicators) do

				--Check if the element is visible.
				if v.Element:IsVisible() == true then
					visible = visible + 1
				end

			end

			--Get the starting position.
			local nextPos = screenWidth / 2 - (VARS.WidgetHeight * visible + VARS.ElementsMargin * (visible - 1)) / 2

			for k,v in pairs(indicators) do

				--Check if the element is visible.
				if v.Element:IsVisible() == false then continue end

				--Set the position.
				v.Element:SetPos(nextPos,screenHeight - VARS.ElementsMargin - VARS.WidgetHeight - EdgeHUD.BottomOffset)

				nextPos = nextPos + VARS.ElementsMargin + VARS.WidgetHeight

			end

		end

	end)

	hook.Add("EdgeHUD:AddonReload","EdgeHUD:Unload_VehicleIndicators",function(  )

		timer.Remove("EdgeHUD:UpdateVehicleIndicators")

		for k,v in pairs(indicators) do
			if IsValid(v.Element) then
				v.Element:Remove()
			end
		end

	end)

end

--[[-------------------------------------------------------------------------
Battery Alerts
---------------------------------------------------------------------------]]

if EdgeHUD.Configuration.GetConfigValue( "BatteryAlerts" ) then

	--Get the battery of the system.
	local lastBattery = system.BatteryPower()

	--Create a timer that is called once every second.
	timer.Create("EdgeHUD:BatteryNotification",1,0,function(  )

		--Get the battery
		local battery = system.BatteryPower()

		--Check if the charger was inserted.
		if lastBattery <= 100 and battery == 255 then
			EdgeHUD.ShowHUDPopup( COLORS["Green"], EdgeHUD.GetPhrase("CHARGER_CONNECTED"), EdgeHUD.GetPhrase("CHARGING_STARTED") )
		elseif lastBattery == 255 and battery <= 100 then
			EdgeHUD.ShowHUDPopup( COLORS["Red"], EdgeHUD.GetPhrase("CHARGER_DISCONNECTED"), EdgeHUD.GetPhrase("CHARGING_ABORTED") )
		elseif (lastBattery > 20 and battery <= 20) or (lastBattery > 5 and battery <= 5) then
			EdgeHUD.ShowHUDPopup( COLORS["Red"], EdgeHUD.GetPhrase("BATTERY_STATUS"), string.Replace(EdgeHUD.GetPhrase("BATTERY_NOTICE"), "%B", battery) )
		end

		--Update lastBattery.
		lastBattery = battery

	end)

	hook.Add("EdgeHUD:AddonReload","EdgeHUD:Unload_BatteryNotification",function(  )
		timer.Remove("EdgeHUD:BatteryNotification")
	end)

end

--[[-------------------------------------------------------------------------
Hide WhoCanHearYouHUD
---------------------------------------------------------------------------]]

if EdgeHUD.Configuration.GetConfigValue( "DisableReceiversHUD" ) then

	local hooksTbl = hook.GetTable()
	local DarkRP_StartFindChatReceivers = hooksTbl["StartChat"]["DarkRP_StartFindChatReceivers"]
	local DarkRP_VoiceChatReceiverFinder = hooksTbl["PlayerStartVoice"]["DarkRP_VoiceChatReceiverFinder"]

	hook.Remove("StartChat", "DarkRP_StartFindChatReceivers")
	hook.Remove("PlayerStartVoice", "DarkRP_VoiceChatReceiverFinder")

	hook.Add("EdgeHUD:AddonReload","EdgeHUD:Unload_BatteryNotification",function(  )
		hook.Add("StartChat","DarkRP_StartFindChatReceivers",DarkRP_StartFindChatReceivers)
		hook.Add("PlayerStartVoice","DarkRP_VoiceChatReceiverFinder",DarkRP_VoiceChatReceiverFinder)
	end)

end

--[[-------------------------------------------------------------------------
Show speaker while talking
---------------------------------------------------------------------------]]

if EdgeHUD.Configuration.GetConfigValue( "EnableVoiceIcon" ) then

	local MAT_Speaker_256 = Material("edgehud/icon_speaker_256.png","smooth")
	local speakerSize = screenHeight * 0.07

	hook.Add("HUDPaint","EdgeHUD:ScreenSpeaker", function(  )

		if ply:IsSpeaking() then
			surface.SetDrawColor(COLORS["White"])
			surface.SetMaterial(MAT_Speaker_256)
			surface.DrawTexturedRect(screenWidth - speakerSize / 2 - VARS.extraWidgetsWidth / 2 - VARS.ScreenMargin, screenHeight * 0.73, speakerSize, speakerSize)
		end

	end)

	hook.Add("EdgeHUD:AddonReload", "EdgeHUD:DisbleScreenSpeaker", function(  )
		hook.Remove("HUDPaint", "EdgeHUD:ScreenSpeaker")
	end)

end

--[[-------------------------------------------------------------------------
DarkRP Leveling System
---------------------------------------------------------------------------]]

local DarkRPLevelSystem = EdgeHUD.Configuration.GetConfigValue( "DarkRPLevelSystem" )

if LevelSystemConfiguration and (DarkRPLevelSystem == "Show on change" or DarkRPLevelSystem == "Always show") then

	local barWidth = screenHeight * 0.75
	local barHeight = screenHeight * 0.03

	--Get the hooks table and create a var for the old hook function.
	local hooksTbl = hook.GetTable()
	local oldLevelPaintHook

	--Check if the hook painting the level HUD exists.
	if hooksTbl["HUDPaint"]["manolis:MVLevels:HUDPaintA"] then
		oldLevelPaintHook = hooksTbl["HUDPaint"]["manolis:MVLevels:HUDPaintA"]
	end

	--Remove the default level hud.
	hook.Remove("HUDPaint","manolis:MVLevels:HUDPaintA")

	local levelWidget = vgui.Create("DPanel")
	levelWidget:SetSize(barWidth,barHeight)
	levelWidget:SetPos(screenWidth / 2 - barWidth / 2,screenHeight * 0.03 + EdgeHUD.LevelbarOffset)
	levelWidget:SetAlpha(DarkRPLevelSystem == "Always show" and 255 or 0)

	--Register the derma element.
	EdgeHUD.RegisterDerma("LevelSystem_Widget", levelWidget)

	local needsUpdate = true
	local level = ply:getDarkRPVar('level') or 0
	local xp = ply:getDarkRPVar('xp') or 0
	local lerpedXP = xp

	local nextClose = 0

	timer.Create("EdgeHUD:UpdateLevel",1, 0, function(  )

		local newLevel = ply:getDarkRPVar('level')
		local newXP = ply:getDarkRPVar('xp')

		if DarkRPLevelSystem == "Show on change" then

			if newLevel != level or newXP != xp then

				nextClose = CurTime() + 3.5

				levelWidget:AlphaTo(255, 0.4)

				timer.Simple(0.8, function(  )
					level = newLevel
					xp = newXP
					needsUpdate = true
				end)

			end

			if nextClose < CurTime() and levelWidget:GetAlpha() == 255 and nextClose != -1 then
				levelWidget:AlphaTo(0, 0.4)
			end

		else
			level = newLevel
			xp = newXP
			needsUpdate = true
		end

	end)

	local percentage = lerpedXP / (20 + (level * (level + 1) * 90) * LevelSystemConfiguration.XPMult)

	local barText = EdgeHUD.GetPhrase("LEVELBAR")
	barText = string.Replace(barText, "%L", level)
	barText = string.Replace(barText, "%P", math.Round(percentage * 100))

	levelWidget.Paint = function( s, w, h )

		level = level or ply:getDarkRPVar('level') or 0
		xp = xp or ply:getDarkRPVar('xp') or 0
		lerpedXP = lerpedXP or 0

		if !EdgeHUD.shouldDraw then return end

		if math.Round(lerpedXP,5) != xp or needsUpdate then

			lerpedXP = Lerp(FrameTime() * 5, lerpedXP, xp)
			percentage = lerpedXP / (20 + (level * (level + 1) * 90) * LevelSystemConfiguration.XPMult)

			barText = EdgeHUD.GetPhrase("LEVELBAR")
			barText = string.Replace(barText, "%L", level)
			barText = string.Replace(barText, "%P", math.Round(percentage * 100))

			needsUpdate = false

		end

		--Draw the background.
		surface.SetDrawColor(COLORS["Black_Transparent"])
		surface.DrawRect(0,0,w,h)

		--Draw the bar.
		surface.SetDrawColor(Color(161, 52, 235, 100))
		surface.DrawRect(0,0,w * percentage,h)

		--Draw the white outline.
		surface.SetDrawColor(COLORS["White_Outline"])
		surface.DrawOutlinedRect(0,0,w,h)

		--Draw the corners.
		surface.SetDrawColor(COLORS["White_Corners"])
		EdgeHUD.DrawEdges(0,0,w,h, 8)

		draw.SimpleText(barText,"EdgeHUD:Small_2",w / 2,h / 2,Color(255, 255, 255, 255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

	end

	if DarkRPLevelSystem == "Show on change" then

		hook.Add("OnContextMenuOpen","EdgeHUD:ShowLevelOnContextMenu", function(  )
			levelWidget:SetAlpha(255)
			nextClose = -1
		end)

		hook.Add("OnContextMenuClose","EdgeHUD:HideLevelOnContextMenu", function(  )
			levelWidget:SetAlpha(0)
			nextClose = 0
		end)

	end

	--Unload EdgeHUD.
	hook.Add("EdgeHUD:AddonReload", "EdgeHUD:Unload_Level", function(  )

		--Check if the default paint function exists.
		if oldLevelPaintHook then
			hook.Add("HUDPaint", "manolis:MVLevels:HUDPaintA", oldLevelPaintHook)
		end

		timer.Remove("EdgeHUD:UpdateLevel")
		hook.Remove("OnContextMenuOpen", "EdgeHUD:ShowLevelOnContextMenu")
		hook.Remove("OnContextMenuClose", "EdgeHUD:HideLevelOnContextMenu")
	end)

end

--[[-------------------------------------------------------------------------
Admin tellall
---------------------------------------------------------------------------]]

if EdgeHUD.Configuration.GetConfigValue( "EnableDarkRPTellAll" ) then

	local oldTellAllHook

	timer.Create("EdgeHUD:LoadAdminTell",0.5,60,function(  )

		local userMsgs = usermessage.GetTable()

		if userMsgs["AdminTell"] then
			oldTellAllHook = userMsgs["AdminTell"]["Function"]
			timer.Remove("EdgeHUD:LoadAdminTell")
		else
			return
		end

		local atellQueue = {}

		--Add a umsg receiver.
		usermessage.Hook("AdminTell", function( data )

			--Read the message.
			local msg = data:ReadString()

			--Check if the player is active.
			if gui.IsGameUIVisible() then
				table.insert(atellQueue, msg)
			else
				EdgeHUD.ShowHUDPopup( Color(255,106,106), EdgeHUD.GetPhrase("ADMINTELL_TITLE"), msg == "" and EdgeHUD.GetPhrase("ADMINTELL_NOMSG") or msg )
			end

		end)

		--Add a timer to process queue.
		timer.Create("EdgeHUD:ProcessAdminTell", 1, 0, function(  )

			--Check if the player is active.
			if !gui.IsGameUIVisible() then

				--Add all messages
				for k,v in pairs(atellQueue) do
					EdgeHUD.ShowHUDPopup( Color(255,106,106), EdgeHUD.GetPhrase("ADMINTELL_TITLE"), v )
				end

				--Reset atellQueue.
				atellQueue = {}

			end

		end)

	end)

	hook.Add("EdgeHUD:AddonReload", "EdgeHUD:UnloadDarkRPTellAll", function(  )

		if oldTellAllHook and isfunction(oldTellAllHook) then
			usermessage.Hook("AdminTell", oldTellAllHook)
		end

		timer.Remove("EdgeHUD:ProcessAdminTell")
		timer.Remove("EdgeHUD:LoadAdminTell")

	end)

end

--[[-------------------------------------------------------------------------
Gesture Menu
---------------------------------------------------------------------------]]

if EdgeHUD.Configuration.GetConfigValue( "GestureMenu" ) then

	local MAT_Gesture = Material("edgehud/icon_gesture.png", "smooth")

	local cmdTbl, _ = concommand.GetTable()
	local oldCommandFunc = cmdTbl["_darkrp_animationmenu"]

	concommand.Add("_darkrp_animationmenu", function(  )

		--Disable the sandbox crosshair.
		hook.Add("HUDShouldDraw","EdgeHUD:RemoveCrosshair_GestureMenu",function( name )
			if name == "CHudCrosshair" then return false end
		end)

		local gesturePanels = {}

		local gestureFrame = vgui.Create("DPanel")
		gestureFrame:SetSize(screenWidth,screenHeight)
		gestureFrame:Center()
		gestureFrame:MakePopup()

		EdgeHUD.RegisterDerma("GestureMenu", gestureFrame)

		--Make the gestureFrame invisible.
		gestureFrame.Paint = function( ) end

		--Create a onremove function for the gestureFrame.
		gestureFrame.OnRemove = function(  )
			hook.Remove("HUDShouldDraw","EdgeHUD:RemoveCrosshair_GestureMenu")
		end

		local closeCooldown = CurTime() + 0.2
		local allowClose = false

		gestureFrame.Think = function(  )

			--Check if the F2 key is pressed.
			if input.IsKeyDown(KEY_R) then

				-- Return if we have a cooldown.
				if closeCooldown > CurTime() or !allowClose then return end

				gestureFrame:Remove()

			else

				--Make sure that the F2 key is released once since the menu was opened.
				allowClose = true

			end

		end

		local animations = {
			[ACT_GMOD_GESTURE_BOW] = EdgeHUD.GetPhrase("GESTURE_BOW"),
			[ACT_GMOD_TAUNT_MUSCLE] = EdgeHUD.GetPhrase("GESTURE_SEXYDANCE"),
			[ACT_GMOD_GESTURE_BECON] = EdgeHUD.GetPhrase("GESTURE_FOLLOWME"),
			[ACT_GMOD_TAUNT_LAUGH] = EdgeHUD.GetPhrase("GESTURE_LAUGH"),
			[ACT_GMOD_TAUNT_PERSISTENCE] = EdgeHUD.GetPhrase("GESTURE_LIONPOSE"),
			[ACT_GMOD_GESTURE_DISAGREE] = EdgeHUD.GetPhrase("GESTURE_NONVERBALNO"),
			[ACT_GMOD_GESTURE_AGREE] = EdgeHUD.GetPhrase("GESTURE_THUMBSUP"),
			[ACT_GMOD_GESTURE_WAVE] = EdgeHUD.GetPhrase("GESTURE_WAVE"),
			[ACT_GMOD_TAUNT_DANCE] = EdgeHUD.GetPhrase("GESTURE_DANCE"),
		}

		for k,v in pairs(animations) do

			local gestureButton = vgui.Create("DButton",gestureFrame)
			gestureButton:SetText(v)

			gestureButton.DoClick = function(  )
				RunConsoleCommand("_DarkRP_DoAnimation", k)
				gestureFrame:Remove()
			end

			table.insert(gesturePanels, gestureButton)

		end

		--Circle data.
		local radius = ScrH() * 0.35
		local seg = table.Count(gesturePanels)
		local circleData = {}

		for i = 1, seg do
			local a = math.rad( ( i / seg ) * -360 )
			table.insert( circleData, { x = screenWidth / 2 + math.sin( a ) * radius, y = screenHeight / 2 + math.cos( a ) * radius } )
		end

		--Determine the size of the buttons.
		local buttonWidth = ScrH() * 0.18
		local buttonHeight = ScrH() * 0.075

		--Determine the icon size.
		local iconSize = buttonHeight * 0.35

		--Create the closeButtonGesture.
		local closeButtonGesture = vgui.Create("DButton",gestureFrame)
		closeButtonGesture:SetText(EdgeHUD.GetPhrase("CLOSE"))
		closeButtonGesture:SetSize(ScrH() * 0.12,ScrH() * 0.04)
		closeButtonGesture:SetPos(ScrW() / 2 - closeButtonGesture:GetWide() / 2, ScrH() / 2 - closeButtonGesture:GetTall() / 2)

		--Create a DoClick function for the closeButtonGesture.
		closeButtonGesture.DoClick = function(  )
			gestureFrame:Remove()
		end

		--Insert the closeButtonGesture into gesturePanels.
		table.insert(gesturePanels,closeButtonGesture)

		--Loop through the gesturePanels again.
		for k,v in pairs(gesturePanels) do

			--Change the font.
			v:SetFont("EdgeHUD:Medium")
			v:SetTextColor(COLORS["White"])

			--Reskin the buttons.
			v.Paint = function( s, w, h )

				--Draw the background.
				surface.SetDrawColor(s:IsHovered() and COLORS["Gray_Transparent"] or COLORS["Black_Transparent"])
				surface.DrawRect(0,0,w,h)

				--Draw the white outline.
				surface.SetDrawColor(COLORS["White_Outline"])
				surface.DrawOutlinedRect(0,0,w,h)

				--Draw the corners.
				surface.SetDrawColor(COLORS["White_Corners"])
				EdgeHUD.DrawEdges(0,0,w,h, 8)

			end

			--Check if the circleData[k] exists. (closeButtonGesture does not need to have its position/size changed)
			if circleData[k] then

				--Set the size.
				v:SetSize(buttonWidth,buttonHeight)

				--Set the position.
				v:SetPos(circleData[k].x - v:GetWide() / 2,circleData[k].y - v:GetTall() / 2)

				--Create a copy of the old paint function.
				local oldPaint = v.Paint

				--Reposition the text in the button.
				v.Paint = function( s, w, h )

					--Call the old paint function.
					oldPaint(s, w, h)

					--Draw the icon.
					surface.SetDrawColor(COLORS["White"])
					surface.SetMaterial(MAT_Gesture)
					surface.DrawTexturedRect(w / 2 - iconSize / 2,h * 0.15,iconSize,iconSize)

					--Draw the text.
					draw.SimpleText(v:GetValue(),"EdgeHUD:Medium",w / 2,h * 0.85,COLORS["White"],TEXT_ALIGN_CENTER,TEXT_ALIGN_BOTTOM)

					--Return true to not draw the text.
					return true

				end


			end

		end


	end)

	hook.Add("EdgeHUD:AddonReload","EdgeHUD:Unload_GestureMenu",function(  )
		concommand.Add("_darkrp_animationmenu",oldCommandFunc)
	end)

end

--[[-------------------------------------------------------------------------
Voice Visualizers
---------------------------------------------------------------------------]]

timer.Remove("EdgeHUD:LoadVisualizers")

local function loadVisualizers(  )

	--Change the size of the g_VoicePanelList to avoid it from covering the lower right widgets.
	g_VoicePanelList:SetTall(screenHeight * 0.65)

	--Create a variable for the oldPaintFunc.
	local oldPaintFunc = VoiceNotify.Paint

	--Read the config-
	local voiceVisualizers = EdgeHUD.Configuration.GetConfigValue( "VoiceVisualizers" )

	--Check what to do next depending on the config.
	if voiceVisualizers == "Disabled" then

		--Hide the voice visualizers
		g_VoicePanelList:SetVisible(false)

	elseif voiceVisualizers == "EdgeHUD Design" then

		--Override the default VoiceNotify paint function.
		VoiceNotify.Paint = function( s, w, h )

			if !IsValid(s.ply) then return end

			--Draw the background.
			surface.SetDrawColor(COLORS["Black_Transparent"])
			surface.DrawRect(0,0,w,h)

			surface.SetDrawColor(66, 144, 245, s.ply:VoiceVolume() * 200)
			surface.DrawRect(0, 0, w, h)

			--Draw the white outline.
			surface.SetDrawColor(COLORS["White_Outline"])
			surface.DrawOutlinedRect(0,0,w,h)

			--Draw the corners.
			surface.SetDrawColor(COLORS["White_Corners"])
			EdgeHUD.DrawEdges(0,0,w,h, 8)

		end

	end

	hook.Add("EdgeHUD:AddonReload","EdgeHUD:UnloadVoiceVisualizers", function(  )

		--Make the g_VoicePanelList visible.
		g_VoicePanelList:SetVisible(true)

		--Reset the paint function.
		VoiceNotify.Paint = oldPaintFunc

	end)

end

if !IsValid(g_VoicePanelList) then

	timer.Create("EdgeHUD:LoadVisualizers",0.5,120,function(  )

		if !loadVisualizers or !isfunction(loadVisualizers) then
			timer.Remove("EdgeHUD:LoadVisualizers")
		end

		if IsValid(g_VoicePanelList) then
			loadVisualizers()
			timer.Remove("EdgeHUD:LoadVisualizers")
		end

	end)

	hook.Add("EdgeHUD:AddonReload","EdgeHUD:UnloadLoadVisualizersTimer",function(  )
		timer.Remove("EdgeHUD:LoadVisualizers")
	end)

else
	loadVisualizers()
end



--[[-------------------------------------------------------------------------
Itempickup HUD
---------------------------------------------------------------------------]]

--Save GAMEMODE.HUDDrawPickupHistory
local oldHUDDrawPickupHistory = GAMEMODE.HUDDrawPickupHistory

local ItemPickups = EdgeHUD.Configuration.GetConfigValue( "ItemPickups" )

if ItemPickups == "EdgeHUD Design" then

	local itemPickupWidth = math.floor(screenHeight * 0.35)
	local minItemPickupWidth = math.floor(screenHeight * 0.18)

	local itemHeight = math.floor(screenHeight * 0.028)
	local itemMargin = math.floor(screenHeight * 0.007)

	local itemPickupHeight = itemHeight * 10 + itemMargin * 9

	--Create a table for all items.
	local items = {}

	--Create a function to add new items to the list.
	local function addNewItem( text )

		--Get the text width.
		surface.SetFont("EdgeHUD:ItemPickup")
		local textWidth = surface.GetTextSize(text)

		local item = {}
		item.text = text
		item.curTime = CurTime() + 5
		item.itemWidth = math.Clamp(textWidth + screenHeight * 0.02, minItemPickupWidth, itemPickupWidth)

		table.insert(items, item)

	end

	--Create the DPanel that will hold all the items.
	local itemPickupFrame = vgui.Create("DPanel")
	itemPickupFrame:SetSize(itemPickupWidth, itemPickupHeight)
	itemPickupFrame:SetPos(screenWidth - VARS.ScreenMargin - itemPickupFrame:GetWide(), screenHeight * 0.35)
	itemPickupFrame:ParentToHUD()

	EdgeHUD.RegisterDerma("itemPickupFrame", itemPickupFrame)

	itemPickupFrame.Paint = function()

		for k,v in pairs(items) do

			--Update v.destination
			v.destination = (itemHeight + itemMargin) * k

			--Create data.
			if !v.lerpedYPos then
				v.lerpedYPos = v.destination
				v.lerpedXPos = itemPickupWidth
				v.alpha = 1
			end

			--Fade away the box.
			if v.curTime < CurTime() then
				v.alpha = Lerp(FrameTime() * 6.5, v.alpha, 0)
			end

			--Remove the box.
			if v.alpha < 0.05 then
				items[k] = nil
				items = table.ClearKeys(items)
				continue
			end

			--Lerp data.
			v.lerpedYPos = Lerp(FrameTime() * 8, v.lerpedYPos, v.destination)
			v.lerpedXPos = Lerp(FrameTime() * 12, v.lerpedXPos, itemPickupWidth - v.itemWidth)

			--Draw the background.
			surface.SetDrawColor(ColorAlpha(COLORS["Black_Transparent"], v.alpha * COLORS["Black_Transparent"].a))
			surface.DrawRect(math.Round(v.lerpedXPos),math.Round(v.lerpedYPos),v.itemWidth,itemHeight)

			--Draw the white outline.
			surface.SetDrawColor(ColorAlpha(COLORS["White_Outline"], v.alpha * COLORS["White_Outline"].a))
			surface.DrawOutlinedRect(math.Round(v.lerpedXPos),math.Round(v.lerpedYPos),v.itemWidth,itemHeight)

			--Draw the corners.
			surface.SetDrawColor(ColorAlpha(COLORS["White_Corners"], v.alpha * COLORS["White_Corners"].a))
			EdgeHUD.DrawEdges(math.Round(v.lerpedXPos),math.Round(v.lerpedYPos),v.itemWidth,itemHeight, 8)

			draw.SimpleText( v.text, "EdgeHUD:ItemPickup", math.Round(v.lerpedXPos) + v.itemWidth / 2, math.Round(v.lerpedYPos) + itemHeight / 2, ColorAlpha(COLORS["White"], v.alpha * COLORS["White"].a), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		end

	end

	--Hook into HUDItemPickedUp.
	hook.Add("HUDItemPickedUp","EdgeHUD:HUDItemPickedUp", function( itemName )

		if !IsValid(ply) or !ply:Alive() then return end

		addNewItem(language.GetPhrase("#" .. itemName))

	end)

	--Hook into HUDWeaponPickedUp
	hook.Add("HUDWeaponPickedUp","EdgeHUD:HUDWeaponPickedUp", function( wep )


		if !IsValid(ply) or !ply:Alive() then return end
		if !IsValid(wep) then return end
		if !isfunction(wep.GetPrintName) then return end

		addNewItem(wep:GetPrintName())

	end)

	--Hook into HUDAmmoPickedUp
	hook.Add("HUDAmmoPickedUp","EdgeHUD:HUDWeaponPickedUp", function( itemname, amount )

		if !IsValid(ply) or !ply:Alive() then return end

		addNewItem(language.GetPhrase( "#" .. itemname .. "_Ammo" ) .. " +" .. amount)

	end)

end

if ItemPickups != "Default Design" then

	--Remove GAMEMODE.HUDDrawPickupHistory.
	timer.Create("EdgeHUD:Remove_DrawPickupHistory",1,0,function(  )
		GAMEMODE.HUDDrawPickupHistory = function(  )  end
	end)

end

--Add a EdgeHUD:AddonReload hook.
hook.Add("EdgeHUD:AddonReload","EdgeHUD:UnloadItemPickup", function(  )
	timer.Remove("EdgeHUD:Remove_DrawPickupHistory")
	GAMEMODE.HUDDrawPickupHistory = oldHUDDrawPickupHistory
	hook.Remove("HUDItemPickedUp", "EdgeHUD:HUDItemPickedUp")
	hook.Remove("HUDWeaponPickedUp", "EdgeHUD:HUDWeaponPickedUp")
	hook.Remove("HUDAmmoPickedUp", "EdgeHUD:HUDAmmoPickedUp")
end)

--[[-------------------------------------------------------------------------
Outdated information
---------------------------------------------------------------------------]]

--Get who was access to the config.
local configTxt = EdgeHUD.Configuration.GetConfigValue( "ConfigAccess" )

--Remove the semicolonn if there is one at the end.
if string.Right(configTxt, 1) == ";" then
	configTxt = string.Left(configTxt, #configTxt - 1)
end

--Get the usergroups.
local groupsAccess = string.Explode(";", configTxt)

--Check if the message should show.
if EdgeHUD.LatestVersion != EdgeHUD.Version and EdgeHUD.LatestVersion != "" and (EdgeHUD.Owner == ply:SteamID64() or table.HasValue(groupsAccess, ply:GetUserGroup())) then

	local outdatedFrameWidth, outdatedFrameHeight = screenHeight * 0.55, screenHeight * 0.2

	local OutdatedFrame = vgui.Create("DFrame")
	OutdatedFrame:SetSize(outdatedFrameWidth, outdatedFrameHeight)
	OutdatedFrame:Center()
	OutdatedFrame:SetTitle("")
	OutdatedFrame:MakePopup()
	OutdatedFrame:ShowCloseButton(false)

	hook.Add("EdgeHUD:AddonReload","EdgeHUD:Unload_OutdatedFrame", function(  )

		if IsValid(OutdatedFrame) then
			OutdatedFrame:Remove()
		end

	end)

	local titleWidth, titleHeight

	OutdatedFrame.Paint = function( s, w, h )

		--Draw the background.
		surface.SetDrawColor(COLORS["Black_Transparent"])
		surface.DrawRect(0,0,w,h)

		--Draw the white outline.
		surface.SetDrawColor(COLORS["White_Outline"])
		surface.DrawOutlinedRect(0,0,w,h)

		--Draw the corners.
		surface.SetDrawColor(COLORS["White_Corners"])
		EdgeHUD.DrawEdges(0,0,w,h, 8)

		--Draw title.
		titleWidth, titleHeight = draw.SimpleText( "New Update", "EdgeHUD:OutdatedWindow:Title", w / 2, VARS.ElementsMargin, COLORS["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )

		surface.SetDrawColor(COLORS["White"])
		surface.DrawRect(w / 2 - titleWidth * 1.1 / 2,h * 0.15 + titleHeight * 0.6,titleWidth * 1.1,1)

	end

	--Calculate the closeButton size.
	local closeBtnSize = OutdatedFrame:GetTall() * 0.2

	--Create a close button in the top right.
	local closeButton = vgui.Create("DButton",OutdatedFrame)
	closeButton:SetSize(closeBtnSize,closeBtnSize)
	closeButton:SetPos(OutdatedFrame:GetWide() - closeBtnSize,0)
	closeButton:SetText("✖")
	closeButton:SetFont("EdgeHUD:Setup:CloseBtn")
	closeButton:SetTextColor(COLORS["White"])

	closeButton.Paint = function() end

	closeButton.Think = function (  )

		--Set the TextColor.
		closeButton:SetTextColor(closeButton:IsHovered() and COLORS["Gray"] or COLORS["White"])

	end

	closeButton.DoClick = function(  )
		OutdatedFrame:Remove()
	end

	local informationText = vgui.Create("RichText",OutdatedFrame)
	informationText:SetSize(OutdatedFrame:GetWide() * 0.7,OutdatedFrame:GetTall() * 0.65)
	informationText:SetPos(OutdatedFrame:GetWide() / 2 - informationText:GetWide() / 2,OutdatedFrame:GetTall() - VARS.ElementsMargin - informationText:GetTall())
	informationText:SetVerticalScrollbarEnabled(false)
	informationText:InsertColorChange(255,255,255,255)
	informationText:AppendText("You are currently using version " .. EdgeHUD.Version .. " of EdgeHUD which now has become outdated. The latest version of EdgeHUD is version " .. EdgeHUD.LatestVersion .. " and can be downloaded from Gmodstore.com. Keeping addons updated is important to make sure you receive new features, bug fixes, etc. This message is only shown to those who has configuration access.")

	informationText.PerformLayout = function(  )
		informationText:SetFontInternal("EdgeHUD:OutdatedWindow:Text")
	end

end

--[[-------------------------------------------------------------------------
Announcements
---------------------------------------------------------------------------]]

if EdgeHUD.Owner == ply:SteamID64() and tobool(ply:GetPData("EdgeHUD_Announcements",true)) == true then

	http.Fetch("http://jompe.phy.sx/edgehud_announcement.php",function( result )

		-- Check if we have a message to show.
		if result == "" then return end

		-- Tags.
		result = string.Replace(result,"{{USER}}",ply:SteamName())
		result = string.Replace(result,"{{VERSION}}",EdgeHUD.Version)
		result = string.Replace(result,"{{OWNER}}",EdgeHUD.Owner)

		chat.AddText("\n")
		chat.AddText(Color(50,50,50,255),"[EdgeHUD] ", Color(255,255,255,255), "[Announcement] ", result)
		chat.AddText("\n")
	end)

end

concommand.Add("edgehud_toggleannouncements",function(  )

	-- Get and update the data.
	local data = tobool(ply:GetPData("EdgeHUD_Announcements",true))
	ply:SetPData("EdgeHUD_Announcements",!data)

	chat.AddText(Color(50,50,50,255),"[EdgeHUD] ", Color(255,255,255,255), "Developer announcements has been turned " .. (!data == false and "off. Sorry for any inconvenience!" or "on.") .. "")

end)