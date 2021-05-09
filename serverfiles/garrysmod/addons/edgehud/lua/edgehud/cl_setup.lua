local Gray_Transparent = Color(80,80,80,200)
local Black_Transparent = Color(50,50,50,180)
local White = Color(255,255,255,255)
local White_Outline = Color(255,255,255,100)
local White_Corners = Color(255,255,255,180)
local Gray = Color(200,200,200,255)

--Create a function used to draw the edges.
local function DrawEdges( x, y, width, height, edgeSize, edgeWidth )

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

--Create a function for buttons.
local function buttonDrawFunc( s, w, h )

	--Draw the background.
	surface.SetDrawColor(s:IsHovered() and Gray_Transparent or Black_Transparent)
	surface.DrawRect(0,0,w,h)

	--Draw the white outline.
	surface.SetDrawColor(White_Outline)
	surface.DrawOutlinedRect(0,0,w,h)

	--Draw the corners.
	surface.SetDrawColor(White_Corners)
	DrawEdges(0,0,w,h,8,2)

end

--Check if we are running DarkRP.
if DarkRP == nil then

	local icon_warning = Material("edgehud/icon_warning.png", "smooth")

	surface.CreateFont( "EdgeHUD:Title_Warning", {
		font = "roboto",
		size = ScrH() * 0.05,
		weight = 500,
	} )

	surface.CreateFont( "EdgeHUD:Subtitle_Warning", {
		font = "roboto",
		size = ScrH() * 0.024,
		weight = 300,
	} )

	surface.CreateFont( "EdgeHUD:Button_Warning", {
		font = "roboto",
		size = ScrH() * 0.023,
		weight = 300,
	} )

	local Frame = vgui.Create("DFrame")
	Frame:SetSize(ScrH() * 0.8, ScrH() * 0.5)
	Frame:Center()
	Frame:MakePopup()
	Frame:SetTitle("")
	Frame:ShowCloseButton(false)

	local iconSize = ScrH() * 0.15

	Frame.Paint = function( s, w, h )

		surface.SetDrawColor(Black_Transparent)
		surface.DrawRect(0,0,w,h)

		surface.SetDrawColor(White_Outline)
		surface.DrawOutlinedRect(0,0,w,h)

		surface.SetDrawColor(White_Corners)
		DrawEdges(0,0,w,h,16,5)

		surface.SetDrawColor(White)
		surface.SetMaterial(icon_warning)
		surface.DrawTexturedRect(w / 2 - iconSize / 2,h * 0.1,iconSize,iconSize)

		draw.SimpleText("Missing DarkRP Installation","EdgeHUD:Title_Warning",w / 2,h * 0.51,White,TEXT_ALIGN_CENTER,TEXT_ALIGN_BOTTOM)

		draw.SimpleText("EdgeHUD requires the DarkRP gamemode to work correctly.","EdgeHUD:Subtitle_Warning",w / 2,h * 0.53,White,TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP)

	end

	local closeButton = vgui.Create("DButton",Frame)
	closeButton:SetSize(Frame:GetWide() * 0.14,Frame:GetTall() * 0.14)
	closeButton:SetPos(Frame:GetWide() / 2 - closeButton:GetWide() / 2,Frame:GetTall() * 0.9 - closeButton:GetTall())
	closeButton:SetText("Close")
	closeButton:SetTextColor(White)
	closeButton:SetFont("EdgeHUD:Button_Warning")

	closeButton.DoClick = function(  )
		Frame:Remove()
	end

	closeButton.Paint = buttonDrawFunc

else

	--Create fonts.
	surface.CreateFont( "EdgeHUD:Setup:CloseBtn", {
		font = "roboto",
		weight = 500,
		size = ScrH() * 0.02,
	} )

	surface.CreateFont( "EdgeHUD:Setup:CloseBtn2", {
		font = "roboto",
		weight = 1000,
		size = ScrH() * 0.05,
	} )

	surface.CreateFont( "EdgeHUD:Setup:Title", {
		font = "roboto",
		weight = 10,
		size = ScrH() * 0.035,
	} )

	surface.CreateFont( "EdgeHUD:Setup:Title2", {
		font = "roboto",
		weight = 1000,
		size = ScrH() * 0.027,
	} )

	surface.CreateFont( "EdgeHUD:Setup:Title3", {
		font = "roboto",
		weight = 300,
		size = ScrH() * 0.018,
	} )

	surface.CreateFont( "EdgeHUD:Setup:ExampleText", {
		font = "roboto",
		weight = 500,
		size = ScrH() * 0.021,
	} )

	local Frame

	--Create a console command to open the config.
	concommand.Add("edgehud_config",function(  )

		local configTxt = EdgeHUD.Configuration.GetConfigValue( "ConfigAccess" )

		if string.Right(configTxt, 1) == ";" then
			configTxt = string.Left(configTxt, #configTxt - 1)
		end

		local groupsAccess = string.Explode(";", configTxt)

		if EdgeHUD.Owner != LocalPlayer():SteamID64() and !table.HasValue(groupsAccess, LocalPlayer():GetUserGroup()) then
			notification.AddLegacy( "[EdgeHUD] Only " .. util.SteamIDFrom64( EdgeHUD.Owner ) .. " and users with the following ranks can open the configuration menu: " .. table.concat(groupsAccess, ", "),NOTIFY_ERROR,10)
			return
		end

		--Check if the frame is valid.
		if IsValid(Frame) then Frame:Remove() end

		--Create a table for all the data modifiers.
		local dataModifiers = {}

		--Create the frame.
		Frame = vgui.Create("DFrame")
		Frame:SetSize(ScrH() * 0.8, ScrH() * 0.5)
		Frame:Center()
		Frame:MakePopup()
		Frame:SetTitle("")
		Frame:ShowCloseButton(false)

		local titlePos = (Frame:GetTall() * 0.3 - Frame:GetWide() * 0.075) / 2

		Frame.Paint = function( s, w, h )

			surface.SetDrawColor(Black_Transparent)
			surface.DrawRect(0,0,w,h)

			surface.SetDrawColor(White_Outline)
			surface.DrawOutlinedRect(0,0,w,h)

			local width, height = draw.SimpleText("Configuration","EdgeHUD:Setup:Title",w / 2,titlePos,White,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

			surface.SetDrawColor(White)
			surface.DrawRect(w / 2 - width * 1.1 / 2,titlePos + height * 0.6,width * 1.1,1)

		end

		--Calculate the closeButton size.
		local closeBtnSize = Frame:GetTall() * 0.06

		--Create a close button in the top right.
		local closeButton = vgui.Create("DButton",Frame)
		closeButton:SetSize(closeBtnSize,closeBtnSize)
		closeButton:SetPos(Frame:GetWide() - closeBtnSize,0)
		closeButton:SetText("✖")
		closeButton:SetFont("EdgeHUD:Setup:CloseBtn")
		closeButton:SetTextColor(White)

		closeButton.Paint = function() end

		closeButton.Think = function (  )

			--Set the TextColor.
			closeButton:SetTextColor(closeButton:IsHovered() and Gray or White)

		end

		closeButton.DoClick = function(  )

			Derma_Query("Would you like to save the changes made to the configuration?","EdgeHUD - Save Configuration","Save Changes",function(  )

				local config = {}

				for k,v in pairs(dataModifiers) do

					config[v.interactElement.ID] = v.interactElement:GetValue()

				end

				net.Start("EdgeHUD:SaveConfiguration")
					net.WriteTable(config)
				net.SendToServer()

				Frame:Remove()

			end,"Disregard Changes",function(  )
				Frame:Remove()
				chat.AddText(Color(50,50,50,255),"[EdgeHUD] ", Color(255,255,255,255), "No changes were saved to the configuration.")
			end,"Cancel")

		end

		--Create a panel for the config.
		local configPanel = vgui.Create("DScrollPanel",Frame)
		configPanel:SetSize(Frame:GetWide() * 0.85,Frame:GetTall() * 0.7)
		configPanel:SetPos(Frame:GetWide() * 0.075,Frame:GetTall() - configPanel:GetTall() - Frame:GetWide() * 0.075)

		configPanel.Paint = function() end

		local optionHeight = configPanel:GetTall() * 0.25
		local optionMargins = configPanel:GetTall() * 0.075

		--Loop through the EdgeHUD.Configuration.ConfigOptions table.
		for k,v in SortedPairsByMemberValue(EdgeHUD.Configuration.ConfigOptions,"Order",false) do

			local configOption = vgui.Create("DPanel",configPanel)
			configOption:SetSize(configPanel:GetWide(),optionHeight)
			configOption:DockMargin(0,0,0,optionMargins)
			configOption:Dock(TOP)

			configOption.Paint = function( s, w, h ) end

			local title = vgui.Create("DLabel",configOption)
			title:SetFont("EdgeHUD:Setup:Title2")
			title:SetText(v.Title)
			title:SetTextColor(White)
			title:SizeToContents()

			local description = vgui.Create("DLabel",configOption)
			description:SetFont("EdgeHUD:Setup:Title3")
			description:SetText(v.Description)
			description:SetTextColor(White)
			description:SizeToContents()
			description:SetPos(0,configOption:GetTall() * 0.29)
			description:SetWrap(true)
			description:SetSize(configOption:GetWide() * 0.75,description:GetTall() * 2)

			local dataModifier = vgui.Create("EdgeHUD:DataModifier",configOption)
			dataModifier:SetSize(configOption:GetWide() * 0.3,configOption:GetTall() * 0.27)
			dataModifier:SetPos(0,configOption:GetTall() * 0.73)
			dataModifier:SetID(k)
			table.insert(dataModifiers,dataModifier)

			local MAT_ExampleMaterial = Material("edgehud/mat_example.png")

			local imageHeight = configOption:GetTall() * 0.8
			local exampleButton = vgui.Create("DButton",configOption)
			exampleButton:SetSize(imageHeight / 9 * 16,imageHeight)
			exampleButton:SetPos(configOption:GetWide() - exampleButton:GetWide() * 1.2,configOption:GetTall() / 2 - exampleButton:GetTall() / 2)
			exampleButton.PaintOver = function( s, w, h )

				if v.ExampleImage != "" then

					surface.SetDrawColor(White)
					surface.SetMaterial(MAT_ExampleMaterial)
					surface.DrawTexturedRect(0,0,w,h)

					surface.SetDrawColor(0,0,0,215)
					surface.DrawRect(0,0,w,h)

					draw.SimpleText("Click for","EdgeHUD:Setup:ExampleText",w / 2,h * 0.3675,s:IsHovered() and Gray or White,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					draw.SimpleText("example","EdgeHUD:Setup:ExampleText",w / 2,h * 0.6325,s:IsHovered() and Gray or White,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

				else

					surface.SetDrawColor(50,50,50,255)
					surface.DrawRect(0,0,w,h)

					draw.SimpleText("No example","EdgeHUD:Setup:ExampleText",w / 2,h * 0.3675,White,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					draw.SimpleText("available","EdgeHUD:Setup:ExampleText",w / 2,h * 0.6325,White,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

				end

				surface.SetDrawColor(Gray)
				surface.DrawOutlinedRect(0,0,w,h)

			end

			exampleButton.DoClick = function(  )

				if v.ExampleImage == "" then return end

				local exampleImageFrame = vgui.Create("DFrame")
				exampleImageFrame:SetSize(ScrW(),ScrH())
				exampleImageFrame:MakePopup()
				exampleImageFrame.Paint = function( s, w, h )

					surface.SetDrawColor(50,50,50,255)
					surface.DrawRect(0,0,w,h)

					draw.SimpleText("Page is loading...","EdgeHUD:Setup:Title",w / 2,h / 2,White,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

				end

				local HTMLPanel = vgui.Create("DHTML",exampleImageFrame)
				HTMLPanel:SetSize(exampleImageFrame:GetWide(),exampleImageFrame:GetTall())
				HTMLPanel:OpenURL("http://www.jompe.phy.sx/edgehud/getExample.php?reqImage=" .. v.ExampleImage)

				local closeBtnSize2 = exampleImageFrame:GetTall() * 0.1

				local closeHTMLButton = vgui.Create("DButton",HTMLPanel)
				closeHTMLButton:SetSize(closeBtnSize2,closeBtnSize2)
				closeHTMLButton:SetPos(exampleImageFrame:GetWide() - closeBtnSize2,0)
				closeHTMLButton:SetText("✖")
				closeHTMLButton:SetFont("EdgeHUD:Setup:CloseBtn2")
				closeHTMLButton:SetTextColor(White)

				closeHTMLButton.Paint = function() end

				closeHTMLButton.Think = function (  )

					--Set the TextColor.
					closeHTMLButton:SetTextColor(closeHTMLButton:IsHovered() and Gray or White)

				end

				closeHTMLButton.DoClick = function(  )
					exampleImageFrame:Remove()
				end

			end


		end

	end)

end

--Add a receiver for EdgeHUD:ConfigurationSaved.
net.Receive("EdgeHUD:ConfigurationSaved",function(  )
	chat.AddText(Color(50,50,50,255),"[EdgeHUD] ", Color(255,255,255,255), "Configuration was saved successfully.")
end)