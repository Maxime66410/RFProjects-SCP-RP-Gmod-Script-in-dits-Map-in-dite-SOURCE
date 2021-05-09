--[[-------------------------------------------------------------------------
Data Management
---------------------------------------------------------------------------]]

-- Get the local player.
local ply = LocalPlayer()

-- Create a table for the offsets.
EdgeHUD.DoorOffsets = {}

-- Create a timer that is called once every second to check for missing dooroffsets.
timer.Create("EdgeHUD:CheckDoorOffset",1,0,function(  )

	-- Get all entities within 500 units.
	local entities = ents.FindInSphere(ply:EyePos(),500)

	-- Create a table of offsets that we need.
	local requiredOffsets = {}

	-- Loop through all entities.
	for k,v in pairs(entities) do

		-- MAke sure the entity is valid, etc.
		if v == ply or !IsValid(v) or !v:isDoor() then continue end

		-- Check if we have requested the dooroffsets for the door.
		if v.EdgeHud_Requested then continue end

		-- Set v.EdgeHUD_Requested to true.
		v.EdgeHud_Requested = true

		-- Insert the entity in the required offsets.
		table.insert(requiredOffsets,v)

		-- Check if we have a maximum of 5 doors.
		if #requiredOffsets >= 5 then break end

	end

	-- Make sure we have any doors to request.
	if #requiredOffsets == 0 then return end

	-- Request the offsets.
	net.Start("EdgeHUD:RequestDoorOffsets")
		net.WriteTable(requiredOffsets)
	net.SendToServer()

end)

-- Create a net receiver for EdgeHUD:SendDoorOffsets.
net.Receive("EdgeHUD:SendDoorOffsets", function(  )

	-- Read the table.
	local requiredEntities = net.ReadTable()

	-- Loop through the entities.
	for k,v in pairs(requiredEntities) do

		-- Make sure that the entity exists.
		if !IsValid(k) then continue end

		-- Update the offsets.
		k.EdgeHUD_DoorOffset = {Angles = Angle(v.pi,v.ya,v.ro), Position = Vector(v.x,v.y,v.z)}

	end

end)

-- Add a receiver for EdgeHUD:DoorUpdated.
net.Receive("EdgeHUD:DoorUpdated", function(  )

	-- Read the door.
	local door = net.ReadEntity()

	-- Make sure that door is valid.
	if !IsValid(door) then return end

	-- Set EdgeHud_Requested to false.
	door.EdgeHud_Requested = false

	door.EdgeHUD_DoorOffset = {Angles = Angle(0,0,0), Position = Vector(0,0,0)}

end)

--[[-------------------------------------------------------------------------
Data Admin-Manipulation
---------------------------------------------------------------------------]]

-- Create a global variable to keep track of if we are modifying anything.
EdgeHUD.IsModifyingDoor = false

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
		notification.AddLegacy( "[EdgeHUD] Only " .. util.SteamIDFrom64( EdgeHUD.Owner ) .. " and users with the following ranks can open the door offset menu: " .. table.concat(groupsAccess, ", "),NOTIFY_ERROR,10)
		return false
	end

	-- Return true if nothing stopped us.
	return true

end

-- ADd a concommand to open the door offset menu.
concommand.Add("edgehud_dooroffset",function(  )

	--Check if the player has access.
	if !hasAccess(ply) then return end

	-- Get the door that the player is looking at.
	local door = ply:GetEyeTrace().Entity

	-- Make sure that the entity is a door.
	if !IsValid(door) or !door:isDoor() then
		notification.AddLegacy( "[EdgeHUD] You need to be looking at a door to open the door offset menu.",NOTIFY_ERROR,10)
		return
	end

	door.EdgeHUD_DoorOffset = door.EdgeHUD_DoorOffset or {Angles = Angle(0,0,0), Position = Vector(0,0,0)}

	local ang = door.EdgeHUD_DoorOffset.Angles
	local pos = door.EdgeHUD_DoorOffset.Position
	local initialOffset = {Angles = Angle(ang.pitch,ang.yaw,ang.roll), Position = Vector(pos.x,pos.y,pos.z)}

	EdgeHUD.IsModifyingDoor = true

	-- Create a DFrame.
	local Frame = vgui.Create("DFrame")
	Frame:SetSize(ScrH() * 0.25,ScrH() * 0.25)
	Frame:MakePopup()
	Frame:Center()
	Frame:SetTitle("")
	Frame:ShowCloseButton(false)

	Frame.OnRemove = function(  )
		EdgeHUD.IsModifyingDoor = false
		door.EdgeHUD_DoorOffset = initialOffset
	end

	Frame.Paint = function( s, w, h )

		--Draw the background.
		surface.SetDrawColor(EdgeHUD.Colors["Black_Transparent"])
		surface.DrawRect(0,0,w,h)

		--Draw the white outline.
		surface.SetDrawColor(EdgeHUD.Colors["White_Outline"])
		surface.DrawOutlinedRect(0,0,w,h)

		--Draw the corners.
		surface.SetDrawColor(EdgeHUD.Colors["White_Corners"])
		EdgeHUD.DrawEdges(0,0,w,h, 8)

		--Draw title.
		draw.SimpleText("Door Offsets","EdgeHUD:DoorOffsetMenu:Title",w / 2,h * 0.1,EdgeHUD.Colors["White"],TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

	end

	local closeBtnSize = ScrH() * 0.03

	--Create a close button in the top right.
	local closeButton = vgui.Create("DButton",Frame)
	closeButton:SetSize(closeBtnSize,closeBtnSize)
	closeButton:SetPos(Frame:GetWide() - closeBtnSize,0)
	closeButton:SetText("✖")
	closeButton:SetFont("EdgeHUD:Setup:CloseBtn")
	closeButton:SetTextColor(EdgeHUD.Colors["White"])

	closeButton.Paint = function() end

	closeButton.Think = function (  )

		--Set the TextColor.
		closeButton:SetTextColor(closeButton:IsHovered() and EdgeHUD.Colors["Gray"] or EdgeHUD.Colors["White"])

	end

	closeButton.DoClick = function(  )

		Derma_Query("Would you like to save the changes made to this door?","EdgeHUD - Save door offset","Save Changes",function(  )

			local toSend = {
				pi = door.EdgeHUD_DoorOffset.Angles.pitch,
				ya = door.EdgeHUD_DoorOffset.Angles.yaw,
				ro = door.EdgeHUD_DoorOffset.Angles.roll,
				x = door.EdgeHUD_DoorOffset.Position.x,
				y = door.EdgeHUD_DoorOffset.Position.y,
				z = door.EdgeHUD_DoorOffset.Position.z,
			}

			net.Start("EdgeHUD:SetDoorOffset")
				net.WriteEntity(door)
				net.WriteTable(toSend)
			net.SendToServer()

			Frame:Remove()
			chat.AddText(Color(50,50,50,255),"[EdgeHUD] ", Color(255,255,255,255), "Door offset data has been updated.")


		end,"Disregard Changes",function(  )
			Frame:Remove()
			chat.AddText(Color(50,50,50,255),"[EdgeHUD] ", Color(255,255,255,255), "No changes were saved to the door offset data.")
		end,"Cancel")

	end

	--Calculate the slidersize.
	local sliderWidth = Frame:GetWide() * 0.9
	local sliderHeight = Frame:GetTall() * 0.18

	local sliders = {
		["pitch"] = {
			title = "Pitch Rotation",
			min = 0,
			max = 180,
			position = 0,
			value = door.EdgeHUD_DoorOffset.Angles.pitch or 0,
			onChange = function( value )
				door.EdgeHUD_DoorOffset.Angles.pitch = value
			end
		},
		["yaw"] = {
			title = "Yaw Rotation",
			min = 0,
			max = 180,
			position = 1,
			value = door.EdgeHUD_DoorOffset.Angles.yaw or 0,
			onChange = function( value )
				door.EdgeHUD_DoorOffset.Angles.yaw = value
			end
		},
		["roll"] = {
			title = "Roll Rotation",
			min = 0,
			max = 180,
			position = 2,
			value = door.EdgeHUD_DoorOffset.Angles.roll or 0,
			onChange = function( value )
				door.EdgeHUD_DoorOffset.Angles.roll = value
			end
		},
		["x-axis"] = {
			title = "X-Axis",
			min = -150,
			max = 150,
			position = 3,
			value = door.EdgeHUD_DoorOffset.Position.x or 0,
			onChange = function( value )
				door.EdgeHUD_DoorOffset.Position.x = value
			end
		},
		["y-axis"] = {
			title = "Y-Axis",
			min = -150,
			max = 150,
			position = 4,
			value = door.EdgeHUD_DoorOffset.Position.y or 0,
			onChange = function( value )
				door.EdgeHUD_DoorOffset.Position.y = value
			end
		},
		["z-axis"] = {
			title = "Z-Axis",
			min = -150,
			max = 150,
			position = 5,
			value = door.EdgeHUD_DoorOffset.Position.z or 0,
			onChange = function( value )
				door.EdgeHUD_DoorOffset.Position.z = value
			end
		},
	}

	-- Create a var for the loop index.
	local loopIndex = 0

	-- Loop through the sliders we should create.
	for k,v in SortedPairsByMemberValue( sliders, "position" ) do

		--Create the slider.
		local valueSlider = vgui.Create( "DNumSlider", Frame )
		valueSlider:SetSize( sliderWidth, sliderHeight )
		valueSlider:SetPos( Frame:GetWide() / 2 - sliderWidth / 2, Frame:GetTall() * (0.15 + 0.1 * loopIndex) )
		valueSlider:SetText(v.title)
		valueSlider:SetMin( v.min )
		valueSlider:SetMax( v.max )
		valueSlider:SetDecimals( 0 )
		valueSlider:SetValue(v.value)
		valueSlider:SetDark(false)
		valueSlider.OnValueChanged = function( )
			v.onChange(math.Round(valueSlider:GetValue()))
		end

		--Add the element to the table.
		sliders[k].Element = valueSlider

		-- Add 1 to loopIndex.
		loopIndex = loopIndex + 1

	end

	local resetButton = vgui.Create("DButton",Frame)
	resetButton:SetSize(Frame:GetWide() * 0.4,Frame:GetTall() * 0.1)
	resetButton:SetText("Reset")
	resetButton:SetTextColor(EdgeHUD.Colors["White"])
	resetButton:SetFont("EdgeHUD:DoorOffsetMenu:RstBtn")
	resetButton:SetPos(Frame:GetWide() / 2 - resetButton:GetWide() / 2, Frame:GetTall() * 0.85)

	resetButton.Paint = function( s, w, h )

		--Draw the background.
		surface.SetDrawColor(s:IsHovered() and EdgeHUD.Colors["Gray_Transparent"] or EdgeHUD.Colors["Black_Transparent"])
		surface.DrawRect(0,0,w,h)

		--Draw the white outline.
		surface.SetDrawColor(EdgeHUD.Colors["White_Outline"])
		surface.DrawOutlinedRect(0,0,w,h)

		--Draw the corners.
		surface.SetDrawColor(EdgeHUD.Colors["White_Corners"])
		EdgeHUD.DrawEdges(0,0,w,h, 8)

	end

	resetButton.DoClick = function(  )

		net.Start("EdgeHUD:ResetDoorOffset")
			net.WriteEntity(door)
		net.SendToServer()

		Frame:Close()

	end

end)
