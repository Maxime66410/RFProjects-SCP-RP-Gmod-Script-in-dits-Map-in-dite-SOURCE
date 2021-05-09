if EdgeHUD.Configuration.GetConfigValue( "LowerLeft" ) then

	--Create a variable for the local player.
	local ply = LocalPlayer()

	--Create a copy of the colors and vars table.
	local COLORS = table.Copy(EdgeHUD.Colors)
	local VARS = table.Copy(EdgeHUD.Vars)

	local screenWidth = ScrW()
	local screenHeight = ScrH()

	local alwaysShowPercentage = EdgeHUD.Configuration.GetConfigValue( "LowerLeft_AlwaysShow" )

	--Create a table where we store information about the statuswidgets.
	local statusWidgets = {
		{
			Icon = Material("edgehud/icon_health.png", "smooth"),
			Color = Color(115,47,47),
			getData = function(  )
				return ply:Health()
			end,
			getMax = function(  )
				return ply:GetMaxHealth()
			end
		},
		{
			Icon = Material("edgehud/icon_armor.png", "smooth"),
			Color = Color(47,82,144),
			getData = function(  )
				return ply:Armor()
			end,
			getMax = function(  )
				return 100
			end
		},
	}

	local ingameName = EdgeHUD.Configuration.GetConfigValue( "Lowerleft_IdentityType" ) == "Ingame Name"

	--Create a table where we store information about the widgets to add.
	local infoWidgets = {
		{
			Title = EdgeHUD.GetPhrase("JOB"),
			Icon = Material("edgehud/icon_job.png", "smooth"),
			getData = function (  )
				return ply:getDarkRPVar("job")
			end
		},
		{
			Title = EdgeHUD.GetPhrase("IDENTITY"),
			Icon = Material("edgehud/icon_user.png", "smooth"),
			getData = function (  )

				-- Create a variable for the name
				local name = ingameName and ply:Name() or ply:SteamName()

				-- Check if we have EdgeScoreboard installed.
				if EdgeScoreboard and EdgeScoreboard.GetConfigValue and EdgeScoreboard.GetConfigValue("FAKEONHUD") and EdgeScoreboard.GetFakeIdentity("Name") then
					name = EdgeScoreboard.GetFakeIdentity("Name") .. " (" .. name .. ")"
				end

				return name
			end
		}
	}

	--[[-------------------------------------------------------------------------
	Hungermod support
	---------------------------------------------------------------------------]]

	--Check if hungermod is enabled.
	if VARS.hungerMod then

		--Insert intot he table.
		table.insert(statusWidgets,	{
			Icon = Material("edgehud/icon_hunger.png", "smooth"),
			Color = Color(131,90,38),
			getData = function(  )
				return ply:getDarkRPVar("Energy")
			end,
			getMax = function(  )
				return 100
			end
		})

	end

	--[[-------------------------------------------------------------------------
	Status Widgets. (Health, Armor, Hunger)
	---------------------------------------------------------------------------]]

	--Loop through statusWidgets.
	for i = 1,#statusWidgets do

		--Create a x & y var for the position.
		local x = VARS.ScreenMargin + (VARS.ElementsMargin + VARS.statusWidgetWidth) * (i - 1)
		local y = screenHeight - VARS.ScreenMargin - VARS.WidgetHeight * 3 - VARS.ElementsMargin * 2

		--Create a var for the current widget.
		local curWidget = statusWidgets[i]

		--Create a widgetbox.
		local statusWidget = vgui.Create("EdgeHUD:WidgetBox")
		statusWidget:SetWidth(VARS.statusWidgetWidth)
		statusWidget:SetPos(x + EdgeHUD.LeftOffset,y - EdgeHUD.BottomOffset)

		--Register the derma element.
		EdgeHUD.RegisterDerma("StatusWidget_" .. i, statusWidget)

		--Create the icon.
		local Icon = vgui.Create("DImage",statusWidget)
		Icon:SetSize(VARS.iconSize_Small,VARS.iconSize_Small)
		Icon:SetPos(statusWidget:GetWide() / 2 - VARS.iconSize_Small / 2, VARS.iconMargin_Small)
		Icon:SetMaterial(curWidget.Icon)

		--Create a lerpedData for the curWidget.
		local lerpedData = curWidget.getData()

		--Create a lerpedSize var.
		local lerpedSize = Icon:GetWide()

		--Create a lerpedPos var.
		local xPos, lerpedPos = Icon:GetPos()

		--Create a lerpedAlha var.
		local lerpedAlpha = 255

		--Create a PaintOVer function for the statusWidget.
		statusWidget.Paint = function( s, w, h )

			--Draw the background.
			surface.SetDrawColor(COLORS["Black_Transparent"])
			surface.DrawRect(0,0,w,h)

			--Get the player's max health.
			local max = curWidget.getMax()
			local data = math.max(curWidget.getData() or 0,0)

			--Cache the FrameTime.
			local FT = FrameTime() * 5

			--Lerp the EdgeHUD.calcData.
			lerpedData = Lerp(FT or 0,lerpedData or 0,data or 0)

			--Calculate the proportion.
			local prop = math.Clamp(lerpedData / max,0,1)

			--Lerp the Alpha.
			lerpedAlpha = Lerp(FT,lerpedAlpha,prop > 0.999 and alwaysShowPercentage == false and data <= max and 0 or 255)

			--Calculate the height.
			local height = h * prop

			--Draw the overlay.
			surface.SetDrawColor(ColorAlpha(curWidget.Color,lerpedAlpha))
			surface.DrawRect(0,h - height,w,height)

			--Draw the infotext.
			draw.SimpleText(math.max(math.Round(lerpedData),0) .. "%","EdgeHUD:Small",w / 2,h - VARS.iconMargin_Small,ColorAlpha(COLORS["White"],lerpedAlpha),TEXT_ALIGN_CENTER,TEXT_ALIGN_BOTTOM)

			--Draw the white outline.
			surface.SetDrawColor(COLORS["White_Outline"])
			surface.DrawOutlinedRect(0,0,w,h)

			--Draw the corners.
			surface.SetDrawColor(COLORS["White_Corners"])
			EdgeHUD.DrawEdges(0,0,w,h, 8)

			--Calculate the new size.
			lerpedSize = Lerp(FT,lerpedSize,prop > 0.999 and alwaysShowPercentage == false and data <= max  and VARS.iconSize or VARS.iconSize_Small)

			--Update the size.
			Icon:SetSize(lerpedSize,lerpedSize)

			--Calculate the new ypos.
			lerpedPos = Lerp(FT,lerpedPos,prop > 0.999 and alwaysShowPercentage == false and data <= max  and VARS.iconMargin or VARS.iconMargin_Small)

			--Update the position.
			Icon:SetPos(xPos,lerpedPos)

		end

	end

	--[[-------------------------------------------------------------------------
	Information Widgets (Name, job)
	---------------------------------------------------------------------------]]

	--Loop through the infoWidgets table.
	for i = 1,#infoWidgets do

		--Create a reference to the current widget.
		local curWidget = infoWidgets[i]

		--Set variables for the position.
		local x = VARS.ScreenMargin
		local y = screenHeight - VARS.ScreenMargin - VARS.WidgetHeight * i - VARS.ElementsMargin * (i - 1)

		--Create a widgetbox.
		local infoWidget = vgui.Create("EdgeHUD:WidgetBox")
		infoWidget:SetWidth(VARS.infoWidgetWidth)
		infoWidget:SetPos(x + EdgeHUD.LeftOffset,y - EdgeHUD.BottomOffset)

		--Register the derma element.
		EdgeHUD.RegisterDerma("InfoWidget_" .. i, infoWidget)

		--Create the Icon.
		local Icon = vgui.Create("DImage",infoWidget)
		Icon:SetSize(VARS.iconSize,VARS.iconSize)
		Icon:SetPos(VARS.iconMargin,VARS.iconMargin)
		Icon:SetMaterial(curWidget.Icon)

		--Get the titleLabelXPos.
		local titleLabelXPos = VARS.iconMargin * 1.75 + VARS.iconSize

		--Create the titleLabel.
		local titleLabel = vgui.Create("DLabel",infoWidget)
		titleLabel:SetFont("EdgeHUD:Small_Bold")
		titleLabel:SetTextColor(COLORS["White"])
		titleLabel:SetText(curWidget.Title .. ": ")
		titleLabel:SizeToContents()
		titleLabel:SetPos(titleLabelXPos,infoWidget:GetTall() / 2 - titleLabel:GetTall() / 2)

		--Get the infoLabelXPos.
		local infoLabelXPos = titleLabelXPos + titleLabel:GetWide()

		--Create the infoLabel.
		local infoLabel = vgui.Create("DLabel",infoWidget)
		infoLabel:SetFont("EdgeHUD:Small")
		infoLabel:SetTextColor(COLORS["White"])
		infoLabel:SetText(DarkRP.deLocalise(curWidget.getData() or ""))
		infoLabel:SetSize(infoWidget:GetWide() - infoLabelXPos,infoWidget:GetTall())
		infoLabel:SetPos(infoLabelXPos,0)

		--Create a UpdateInfo func for the infoWidget to update the labels.
		infoWidget.UpdateInfo = function(  )

			--Update the text of the infoLabel.
			infoLabel:SetText(DarkRP.deLocalise(curWidget.getData() or ""))

		end

	end

end