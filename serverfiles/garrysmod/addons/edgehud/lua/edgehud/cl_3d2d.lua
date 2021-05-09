--Create a var for the local player.
local ply = LocalPlayer()

--Create a copy of the colors and vars table.
local COLORS = table.Copy(EdgeHUD.Colors)

EdgeHUD.Loaded3D2D = true

--[[-------------------------------------------------------------------------
Player overhead
---------------------------------------------------------------------------]]

-- Create a table for the jobcategorycolors.
local categoryColors = {}

if DarkRP then

	-- Loop through all the job categories.
	for k,v in pairs(DarkRP.getCategories()["jobs"]) do
		categoryColors[v.name] = v.color
	end

end

local overheadTeamConfig = EdgeHUD.Configuration.GetConfigValue("OverheadJob" )

if EdgeHUD.Configuration.GetConfigValue( "PlayerOverhead" ) then

	--Create materials.
	local MAT_USER =  Material("edgehud/icon_user.png", "smooth")
	local MAT_LICENSE =  Material("edgehud/icon_gunlicense.png", "smooth")
	local MAT_SPEAKER =  Material("edgehud/icon_speaker.png", "smooth")
	local MAT_CHAT =  Material("edgehud/icon_chatting.png", "smooth")
	local MAT_WANTED =  Material("edgehud/icon_wanted.png", "smooth")
	local MAT_MUTED = Material("edgehud/icon_muted.png","smooth")

	local darkrpSpeachBubbleFunc

	local hooksTbl = hook.GetTable()

	if !hooksTbl["PostPlayerDraw"] or !hooksTbl["PostPlayerDraw"]["DarkRP_ChatIndicator"] then
		darkrpSpeachBubbleFunc = function(  ) end
	else
		darkrpSpeachBubbleFunc = hooksTbl["PostPlayerDraw"]["DarkRP_ChatIndicator"]
	end

	--Remove the DarkRP speach bubble.
	hook.Remove("PostPlayerDraw", "DarkRP_ChatIndicator")

	--Create some vars.
	local margin = 15
	local boxSize = 85
	local iconSize = boxSize * 0.6
	local iconMargin = (boxSize - iconSize) / 2
	local iconVehicleSize = 100

	local playersToRender = {}

	timer.Create("EdgeHUD:UpdatePlayerOverhead",0.15,0,function(  )

		--Check if we should draw.
		if !EdgeHUD.shouldDraw then return end

		--Reset playersToRender.
		playersToRender = {}

		--Get all players.
		local players = player.GetAll()

		--Loop through all players.
		for k,v in pairs(players) do

			--Make sure the player is valid.
			if !IsValid(v) then continue end

			--Dont draw ourselves.
			if v == ply then continue end

			--Check so the player is close enough.
			if ply:GetPos():DistToSqr( v:GetPos() ) < 300^2 or v:IsSpeaking() then
				table.insert(playersToRender,v)
			end

		end

	end)

	--Create the hook to draw the player overhead.
	hook.Add("PostDrawTranslucentRenderables","EdgeHUD:PostPlayerDraw",function(  )

		--Check if we should draw.
		if !EdgeHUD.shouldDraw then return end

		for k,v in pairs(playersToRender) do

			--Make sure the player is valid.
			if !IsValid(v) then continue end

			--Check if the player is dead.
			if !v:Alive() then continue end

			--Check so the player isn't dormant.
			if v:IsDormant() then continue end

			--Check if the player is cloaked.
			if v:GetColor().a < 100 or v:GetNoDraw() then continue end

			--Get the local player's eye angles.
			local eyeAngs = ply:EyeAngles()

			--Cache the playername, jobname and health.
			local name = v:Name()
			local jobname = "Unknown"
			local jobcolor = Color(255, 255, 255, 255)
			local health = v:Health()
			local maxHealth = v:GetMaxHealth()
			local hasLicense = v:getDarkRPVar("HasGunlicense") or false
			local showMuted = v:IsMuted()

			if overheadTeamConfig == "Job Name" then
				jobname = v:getDarkRPVar("job") or "Unknown"
				jobcolor = team.GetColor(v:Team())
			else
				jobname = RPExtraTeams[v:Team()].category or "Uncategorized"
				jobcolor = categoryColors[jobname]
			end

			-- Check if we have EdgeScoreboard installed.
			if EdgeScoreboard and EdgeScoreboard.GetConfigValue and EdgeScoreboard.GetConfigValue("FAKEONHUD") and EdgeScoreboard.GetFakeIdentity("Name",v) != nil then
				name = EdgeScoreboard.GetFakeIdentity("Name",v) .. (EdgeScoreboard.GetUsergroupConfigValue( LocalPlayer(), "FakeIdentity:SeeOriginal" ) and " (" .. name .. ")" or "")
			end

			-- Check if the muted icon should be drawn.
			if math.Round(RealTime() % 1) == 1 then
				showMuted = false
			end

			--Get the text size of the name.
			surface.SetFont("EdgeHUD:3D2D:Large")
			local nameTextWidth, _ = surface.GetTextSize(name)

			--Get the text size of the job.
			surface.SetFont("EdgeHUD:3D2D:Small")
			local jobTextWidth, _ = surface.GetTextSize(jobname)

			--Calculate the boxPos.
			local boxPos = -((boxSize + margin + math.max(nameTextWidth,jobTextWidth)) / 2)

			local inVehicle = v:InVehicle()

			local eyePos = v:EyePos()

			local playerHeightOffset = 0

			if !inVehicle then
				playerHeightOffset = eyePos.z - v:GetPos().z
			end

			--Start cam3D
			cam.Start3D2D(Vector(eyePos.x, eyePos.y,v:GetPos().z) + (inVehicle and Vector(0,0,60) or Vector(0,0,math.max(playerHeightOffset + 18, 55))),ply:InVehicle() and Angle(0,ply:GetVehicle():GetAngles().y + eyeAngs.y - 90,90) or Angle(0,eyeAngs.y - 90,90),0.1)

				if inVehicle and (v:IsSpeaking() or v:IsTyping()) then

					--Draw icon.
					surface.SetDrawColor(COLORS["White"])
					surface.SetMaterial(v:IsSpeaking() and MAT_SPEAKER or v:IsTyping() and MAT_CHAT or v:getDarkRPVar("wanted") == true and MAT_WANTED or MAT_USER)
					surface.DrawTexturedRect(- iconVehicleSize / 2,- iconVehicleSize / 2,iconVehicleSize,iconVehicleSize)

				elseif !inVehicle then

					--Draw the gray square.
					surface.SetDrawColor(COLORS["Black_Transparent"])
					surface.DrawRect(boxPos,0,boxSize,boxSize)

					--Check if health is bellow max.
					if health < maxHealth then

						--Check if the health is above 10
						if health > 10 then

							local size = boxSize * math.Clamp(health / maxHealth,0,1)

							--Draw health.
							surface.SetDrawColor(COLORS["3D2D_Green"])
							surface.DrawRect(boxPos,boxSize - size,boxSize,size)

						else

							--Draw health.
							surface.SetDrawColor(ColorAlpha(COLORS["Red"],70 * math.Round(CurTime() % 1)))
							surface.DrawRect(boxPos,0,boxSize,boxSize)

						end

					end

					--Draw the outline.
					surface.SetDrawColor(COLORS["White_Outline"])
					surface.DrawOutlinedRect(boxPos,0,boxSize,boxSize)

					--Draw edges.
					surface.SetDrawColor(COLORS["White_Corners"])
					EdgeHUD.DrawEdges(boxPos,0,boxSize,boxSize,8)

					--Draw icon.
					surface.SetDrawColor(COLORS["White"])
					surface.SetMaterial(showMuted and MAT_MUTED or v:IsSpeaking() and !v:IsMuted() and MAT_SPEAKER or v:IsTyping() and MAT_CHAT or v:getDarkRPVar("wanted") == true and MAT_WANTED or hasLicense and MAT_LICENSE or MAT_USER)	
					surface.DrawTexturedRect(boxPos + iconMargin,0 + iconMargin,iconSize,iconSize)

					--Draw info.

					if overheadTeamConfig != "Hidden" then
						draw.SimpleText(name,"EdgeHUD:3D2D:Large",boxPos + boxSize + margin,0,Color(200,200,200,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
						draw.SimpleText(jobname,"EdgeHUD:3D2D:Small",boxPos + boxSize + margin,boxSize,jobcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
					else
						draw.SimpleText(name,"EdgeHUD:3D2D:Large",boxPos + boxSize + margin,boxSize / 2,Color(200,200,200,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
					end


				end

			--End cam3d2d
			cam.End3D2D()

		end

	end)

	hook.Add("EdgeHUD:AddonReload","EdgeHUD:Unload_PlayerOverhead",function(  )
		hook.Remove("PostDrawTranslucentRenderables","EdgeHUD:PostPlayerDraw")
		timer.Remove("EdgeHUD:UpdatePlayerOverhead")
		hook.Add("PostPlayerDraw","DarkRP_ChatIndicator",darkrpSpeachBubbleFunc)
	end)

end

--[[-------------------------------------------------------------------------
Door Display
---------------------------------------------------------------------------]]

if EdgeHUD.Configuration.GetConfigValue( "DoorDisplay" ) then

	--Create a table for cached doorData.
	local doorCache = {}

	--Create a function to draw the door.
	local function draw3D2DDoor( door )

		--Check if we should draw.
		if !EdgeHUD.shouldDraw then return end

		--[[-------------------------------------------------------------------------
		Door Display - DisplayData
		---------------------------------------------------------------------------]]

		--Create a table for the displayData.
		local displayData = {}

		--Get the doorangles.
		local doorAngles = door:GetAngles()

		--Check if the door data is cached.
		if doorCache[door] then

			displayData = doorCache[door]

		else

			-- Make sure the door has offsets.
			door.EdgeHUD_DoorOffset = door.EdgeHUD_DoorOffset or {Angles = Angle(0,0,0), Position = Vector(0,0,0)}

			--Get some vars.
			local OBBMaxs = door:OBBMaxs()
			local OBBMins = door:OBBMins()
			local OBBCenter = door:OBBCenter()

			--Get the size of the door.
			local size = OBBMins - OBBMaxs
			size = Vector(math.abs(size.x),math.abs(size.y),math.abs(size.z))

			--Get OBBCenter local to world.
			local obbCenterToWorld = door:LocalToWorld(OBBCenter)

			--Set the settings for the trace.
			local traceTbl = {
				endpos = obbCenterToWorld,
				filter = function( ent )
					return !(ent:IsPlayer() or ent:IsWorld())
				end
			}

			--Create a variable that holds the door angles. (Bigger scope)
			local offset
			local DrawAngles
			local CanvasPos1
			local CanvasPos2

			--Check what rotation the door has.
			if size.x > size.y then

				--Set the drawangles of the door.
				DrawAngles = Angle(0,0,90)

				--Set the start position of the trace.
				traceTbl.start = obbCenterToWorld + door:GetRight() * (size.y / 2)

				--Calculate the thickness of the door.
				local thickness = util.TraceLine(traceTbl).Fraction * (size.y / 2) + 0.85

				--Set the offset.
				offset = Vector(size.x / 2,thickness,0)

			else

				--Set the drawangles of the door.
				DrawAngles = Angle(0,90,90)

				--Set the start position of the trace.
				traceTbl.start = obbCenterToWorld + door:GetForward() * (size.x / 2)

				--Calculate the thickness of the door.
				local thickness = (1 - util.TraceLine(traceTbl).Fraction) * (size.x / 2) + 0.85

				--Set the offset.
				offset = Vector(-thickness,size.y / 2,0)

			end

			--Decide the heightOffset.
			local heightOffset = Vector(0,0,15)

			--Calculate the positions for the 3D2D.
			CanvasPos1 = OBBCenter - offset + heightOffset
			CanvasPos2 = OBBCenter + offset + heightOffset

			--Create a var for the 3D2D-Scale.
			local scale = 0.1

			local canvasWidth

			if size.x > size.y then
				canvasWidth = size.x / scale
			else
				canvasWidth = size.y / scale
			end

			--Create the displaydata.
			displayData = {
				DrawAngles = DrawAngles,
				CanvasPos1 = CanvasPos1,
				CanvasPos2 = CanvasPos2,
				scale = scale,
				canvasWidth = canvasWidth,
				start = traceTbl.start
			}

			--Cache the data.
			doorCache[door] = displayData

		end

		--[[-------------------------------------------------------------------------
		Door Display - Drawing
		---------------------------------------------------------------------------]]

		--Get the doorData.
		local doorData = door:getDoorData()

		--Create variables for the text.
		local doorHeader = ""
		local doorSubHeader = ""
		local extraText = {}

		--Check if the door is owned.
		if table.Count( doorData ) > 0 then

			--Who the owner is.
			if doorData.groupOwn then

				--Set the header.
				doorHeader = doorData.title or EdgeHUD.GetPhrase("DOOR_GROUP_TITLE")

				--Set the subHeader.
				doorSubHeader = string.Replace(EdgeHUD.GetPhrase("DOOR_ACCESS_GROUP"), "%G", doorData.groupOwn)

			elseif doorData.nonOwnable then

				doorHeader = doorData.title or ""

			elseif doorData.teamOwn then

				--Set the header.
				doorHeader = doorData.title or EdgeHUD.GetPhrase("DOOR_TEAM_TITLE")

				--Set the subHeader.
				doorSubHeader = string.Replace(EdgeHUD.GetPhrase("DOOR_ACCESS_TEAM"), "%J", table.Count(doorData.teamOwn))

				--Add the job titles.
				for k,_ in pairs(doorData.teamOwn) do
					table.insert(extraText, team.GetName(k))
				end

			elseif doorData.owner then

				--Set the header.
				doorHeader = doorData.title or EdgeHUD.GetPhrase("DOOR_SOLD")

				--Get the doorOwner.
				local doorOwner = Player(doorData.owner)

				--Make sure the owner is valid.
				if IsValid(doorOwner) then

					--Set the subHeader.
					doorSubHeader = string.Replace(EdgeHUD.GetPhrase("DOOR_OWNER"), "%N", doorOwner:Name())

				else

					doorSubHeader = EdgeHUD.GetPhrase("DOOR_OWNER_UNKNOWN")

				end

				--Check if there are any allowed co-owners.
				if doorData.allowedToOwn then

					--Check players.
					for k,v in pairs(doorData.allowedToOwn) do

						--Get the player.
						doorData.allowedToOwn[k] = Player(k)

						--Make sure that the player is valid.
						if !IsValid(doorData.allowedToOwn[k]) then

							--Remove the player.
							doorData.allowedToOwn[k] = nil

						end

					end

					--Check so we have any players left.
					if table.Count(doorData.allowedToOwn) > 0 then

						--Insert a title
						table.insert(extraText,EdgeHUD.GetPhrase("DOOR_ALLOWED_COOWNERS"))

						--Add the owners.
						for k,v in pairs(doorData.allowedToOwn) do

							--Insert the player into the extraText table.
							table.insert(extraText,v:Name())

						end

						--Insert an empty line.
						table.insert(extraText,"")

					end

				end

				--Check if there are any co-owners.
				if doorData.extraOwners then

					--Filter out any invalid players.
					for k,v in pairs(doorData.extraOwners) do

						doorData.extraOwners[k] = Player(k)

						if !IsValid(doorData.extraOwners[k]) then
							doorData.extraOwners[k] = nil
						end

					end

					--Check if we have any extraowners left.
					if table.Count(doorData.extraOwners) > 0 then

						--Insert a title
						table.insert(extraText,EdgeHUD.GetPhrase("DOOR_COOWNERS"))

						--Add the owners.
						for k,v in pairs(doorData.extraOwners) do
							table.insert(extraText,v:Name())
						end

					end

				end

			end

		else

			--Set the texts.
			doorHeader = EdgeHUD.GetPhrase("DOOR_FORSALE")
			doorSubHeader = EdgeHUD.GetPhrase("DOOR_F2PURCHASE")

		end

		--Enforce string length limits.
		doorHeader = string.Left(doorHeader,25)
		doorSubHeader = string.Left(doorSubHeader,35)

		--Create the draw function.
		local function drawDoor( )

			--Check if we are currently modifying the door.
			if EdgeHUD.IsModifyingDoor then
				surface.SetDrawColor(255,0,0,255)
				surface.DrawOutlinedRect(0,0,displayData.canvasWidth,350)
			end

			--Draw the header text.
			draw.SimpleText(doorHeader,"EdgeHUD:3D2D_Door:Large",displayData.canvasWidth / 2,0,Color(255,255,255,255), TEXT_ALIGN_CENTER)

			--Draw the sub-header.
			draw.SimpleText(doorSubHeader,"EdgeHUD:3D2D_Door:Medium",displayData.canvasWidth / 2,50,Color(255,255,255,255), TEXT_ALIGN_CENTER)

			--Loop through the other text.
			for i = 1,#extraText do

				--Get the text.
				local text = extraText[i]

				--Draw the sub-header.
				draw.SimpleText(text,"EdgeHUD:3D2D_Door:Small",displayData.canvasWidth / 2,90 + i * 20,Color(255,255,255,255), TEXT_ALIGN_CENTER)

			end

		end

		--Start 3D env.
		cam.Start3D()

			--Draw the first side of the door.
			cam.Start3D2D(door:LocalToWorld(displayData.CanvasPos1 + door.EdgeHUD_DoorOffset.Position),displayData.DrawAngles + doorAngles + door.EdgeHUD_DoorOffset.Angles,displayData.scale)
				drawDoor()
			cam.End3D2D()

			--Draw the other side of the door.
			cam.Start3D2D(door:LocalToWorld(displayData.CanvasPos2 + door.EdgeHUD_DoorOffset.Position * Vector(-1,-1,1)),displayData.DrawAngles + Angle(doorAngles.pitch,doorAngles.yaw,-doorAngles.roll) + Angle(0,180,0) + door.EdgeHUD_DoorOffset.Angles,displayData.scale)
				drawDoor()
			cam.End3D2D()

		cam.End3D()

	end

	hook.Add("RenderScreenspaceEffects","EdgeHUD:DoorsHUD",function(  )

		--Find entities within sphere.
		local entities = ents.FindInSphere(ply:EyePos(),250)

		--Loop through all entities.
		for i = 1,#entities do

			--Make a var for the current entity.
			local curEnt = entities[i]

			--Check so it's a door.
			if curEnt:isDoor() and curEnt:GetClass() != "prop_dynamic" and !curEnt:GetNoDraw() then
				draw3D2DDoor( curEnt )
			end


		end

	end)

	hook.Add("EdgeHUD:AddonReload","EdgeHUD:Unload_DoorDisplay",function(  )
		hook.Remove("RenderScreenspaceEffects","EdgeHUD:DoorsHUD")
	end)

end