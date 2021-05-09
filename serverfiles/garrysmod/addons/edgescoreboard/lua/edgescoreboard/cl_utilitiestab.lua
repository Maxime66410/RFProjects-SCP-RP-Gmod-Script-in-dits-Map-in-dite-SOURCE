-- Get the calculated values.
local listData = EdgeScoreboard.listData

-- Get the colors.
local COLORS = EdgeScoreboard.Colors

-- Calculate some stuff.
local widgetWidth = (listData.ScrollPanelWidth - EdgeScoreboard.elementMargin * 2) / 3
local iconSize = widgetWidth * 0.35

local headerHeight = math.Round(listData.ScrollPanelHeight * 0.225)
local headerIconMargin = math.Round(headerHeight * 0.15)
local headerIconSize = headerHeight - headerIconMargin * 2
local descriptionHeight = math.Round(headerHeight * 0.42)
local headerTopPadding = math.Round(EdgeScoreboard.GetConfigValue( "Hide_Header" ) and headerHeight * 0.142 or headerHeight * 0.165)
local buttonWidth = math.Round((listData.ScrollPanelWidth - EdgeScoreboard.elementMargin * 1) / 2)
local buttonHeight = math.Round(listData.ScrollPanelHeight * 0.095)

-- Create a table for the widgets.
local utilitiesWidgets = {
	{
		name = EdgeScoreboard.GetPhrase("UTIL_PERSONAL"),
		icon = Material("edgescoreboard/icon_personal.png","smooth"),
		description = EdgeScoreboard.GetPhrase("UTIL_PERSONAL_DESC"),
		items = {}
	},
	{
		name = EdgeScoreboard.GetPhrase("UTIL_SCOREBOARD"),
		icon = Material("edgescoreboard/icon_scoreboard.png","smooth"),
		description = EdgeScoreboard.GetPhrase("UTIL_SCOREBOARD_DESC"),
		items = {}
	},
	{
		name = EdgeScoreboard.GetPhrase("UTIL_SERVER"),
		icon = Material("edgescoreboard/icon_server.png","smooth"),
		description = EdgeScoreboard.GetPhrase("UTIL_SERVER_DESC"),
		items = {}
	},
}

-- Create a table for all the permissions.
local fakeIDPerms = {
	["Hide"] = "FakeIdentity:Hide",
	["Username"] = "FakeIdentity:SpoofUsername",
	["Avatar"] = "FakeIdentity:SpoofAvatar",
	["Rank"] = "FakeIdentity:SpoofRank",
}

-- Crate a function for the perms.
local function getFakeIDPerms( id )

	-- Cache the player.
	local ply = LocalPlayer()

	-- Check if we have an id.
	if !id then

		-- Loop through the perms and see if we have access to anything.
		for k,v in pairs(fakeIDPerms) do

			-- Get the permission.
			local permission = EdgeScoreboard.GetUsergroupConfigValue(ply, v)

			-- Check if the permision is equal isn't equal to false or "Not Allowed"
			if permission != false and permission != "Not Allowed" then
				return true
			end

		end

		-- Return false.
		return false

	else

		-- Return the permission.
		return EdgeScoreboard.GetUsergroupConfigValue(ply, fakeIDPerms[id])

	end

end

-- Call a hook to add gamemode specific widgets.
hook.Run("EdgeScoreboard:PersonalWidgets",utilitiesWidgets[1].items)

table.insert(utilitiesWidgets[1].items, {
	title = EdgeScoreboard.GetPhrase("PERS_UTIL_SLAY"), subTitle = EdgeScoreboard.GetPhrase("PERS_UTIL_SLAY_DESC"), onClick = function(  )
		EdgeScoreboard.DermaQuery(EdgeScoreboard.GetPhrase("PERS_UTIL_QUERY_SLAY"), {{function(  )
			RunConsoleCommand("kill")
		end}})
	end
})

-- Add the buttons to the scoreboard tab.
table.insert(utilitiesWidgets[2].items, {
	title = EdgeScoreboard.GetPhrase("SCRB_UTIL_RESET"), subTitle = EdgeScoreboard.GetPhrase("SCRB_UTIL_RESET_DESC"), enabled = function (  ) return getFakeIDPerms() end, onClick = function(  )
		EdgeScoreboard.DermaQuery( EdgeScoreboard.GetPhrase("PERS_UTIL_QUERY_RESET"), {{function(  )
			net.Start("EdgeScoreboard:Identity:Reset")
			net.SendToServer()
		end}})
	end
})

table.insert(utilitiesWidgets[2].items, {
	getTitle = function() return EdgeScoreboard.GetFakeIdentity("Hidden") and EdgeScoreboard.GetPhrase("SCRB_UTIL_SHOW") or EdgeScoreboard.GetPhrase("SCRB_UTIL_HIDE") end, getSubTitle = function() return EdgeScoreboard.GetFakeIdentity("Hidden") and EdgeScoreboard.GetPhrase("SCRB_UTIL_SHOW_DESC") or EdgeScoreboard.GetPhrase("SCRB_UTIL_HIDE_DESC") end, enabled = function (  ) return getFakeIDPerms("Hide") end, onClick = function(  )
		EdgeScoreboard.DermaQuery( EdgeScoreboard.GetPhrase("PERS_UTIL_QUERY_VISIBILITY"), {{function(  )
			net.Start(EdgeScoreboard.GetFakeIdentity("Hidden") and "EdgeScoreboard:Identity:Show" or "EdgeScoreboard:Identity:Hide")
			net.SendToServer()
		end}})
	end
})

table.insert(utilitiesWidgets[2].items, {
	title = EdgeScoreboard.GetPhrase("SCRB_UTIL_USERNAME"), subTitle = EdgeScoreboard.GetPhrase("SCRB_UTIL_USERNAME_DESC"), enabled = function (  ) return getFakeIDPerms("Username") end, onClick = function(  )
		EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PERS_UTIL_QUERY_USERNAME"), EdgeScoreboard.GetFakeIdentity("Name") or "", function( text )
			net.Start("EdgeScoreboard:Identity:SetName")
				net.WriteString(string.Left(text,30))
			net.SendToServer()
		end)
	end
})

table.insert(utilitiesWidgets[2].items, {
	title = EdgeScoreboard.GetPhrase("SCRB_UTIL_AVATAR"), subTitle = EdgeScoreboard.GetPhrase("SCRB_UTIL_AVATAR_DESC"), enabled = function (  ) return getFakeIDPerms("Avatar") end, onClick = function(  )
		EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PERS_UTIL_QUERY_AVATAR"), "", function( text )

			-- Make sure we have a SteamID.
			if text != "" and string.match(text,"^STEAM_%d:%d:%d+$") == nil then

				-- Show a notification.
				EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_POPUP, EdgeScoreboard.GetPhrase("PERS_UTIL_INVALIDSTEAMID") )

				-- Stop the code.
				return

			end

			-- Set the text to nothing if the steamid is ours.
			if LocalPlayer():SteamID() == text then
				text = ""
			end

			-- Cut out the necessary part of the string and send it.
			net.Start("EdgeScoreboard:Identity:SetAvatar")
				net.WriteString(text)
			net.SendToServer()

		end)
	end
})

table.insert(utilitiesWidgets[2].items, {
	getTitle = function(  ) return getFakeIDPerms("Rank") == "Custom Rank" and EdgeScoreboard.GetPhrase("SCRB_UTIL_RANK_SPOOF") or (EdgeScoreboard.GetFakeIdentity("Rank") and EdgeScoreboard.GetPhrase("SCRB_UTIL_RANK_SHOW") or EdgeScoreboard.GetPhrase("SCRB_UTIL_RANK_HIDE")) end, getSubTitle = function(  ) return getFakeIDPerms("Rank") == "Custom Rank" and EdgeScoreboard.GetPhrase("SCRB_UTIL_RANK_FAKE_DESC") or (EdgeScoreboard.GetFakeIdentity("Rank") and EdgeScoreboard.GetPhrase("SCRB_UTIL_RANK_SHOW_DESC") or EdgeScoreboard.GetPhrase("SCRB_UTIL_RANK_HIDE_DESC")) end, enabled = function (  ) return getFakeIDPerms("Rank") != "Not Allowed" and getFakeIDPerms("Rank") != false end, onClick = function(  )

		-- Check what we have permission to.
		if getFakeIDPerms( "Rank" ) == "Custom Rank" then

			EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("PERS_UTIL_QUERY_RANK"), EdgeScoreboard.GetFakeIdentity("Rank") or "", function( text )
				net.Start("EdgeScoreboard:Identity:SetRank")
					net.WriteString(string.Left(text,20))
				net.SendToServer()
			end)

		else
			EdgeScoreboard.DermaQuery( EdgeScoreboard.GetPhrase("PERS_UTIL_QUERY_RANKVISIBILITY"), {{function(  )
				net.Start("EdgeScoreboard:Identity:SetRank")
					net.WriteString(EdgeScoreboard.GetFakeIdentity("Rank") and "" or EdgeScoreboard.GetConfigValue("DefaultRank"))
				net.SendToServer()
			end}})
		end

	end
})

table.insert(utilitiesWidgets[3].items, {
	title = EdgeScoreboard.GetPhrase("SCRB_UTIL_RESTARTMAP"),
	subTitle = EdgeScoreboard.GetPhrase("SCRB_UTIL_RESTARTMAP_DESC"),
	onClick = function(  )

		-- Generate 2 random numbers
		local num1, num2 = math.random(1,10), math.random(1,10)

		-- Math question.
		EdgeScoreboard.StringRequest( string.Replace(EdgeScoreboard.GetPhrase("SERV_UTIL_MATHQUESTION"), "%Q", num1 .. " + " .. num2), "", function( text )

			-- Make the text a number.
			text = tonumber(text)

			-- Check if the answer was correct.
			if !text or text != num1 + num2 then
				EdgeScoreboard.ShowMessage( EdgeScoreboard.GetPhrase("SERV_UTIL_MATHWRONG") )
				return
			end

			net.Start("EdgeScoreboard:PerformServerAction")
				net.WriteString("RESTARTMAP")
			net.SendToServer()

		end)

	end,
	enabled = function(  )
		return EdgeScoreboard.GetUsergroupConfigValue( LocalPlayer(), "RestartMap" )
	end
})

table.insert(utilitiesWidgets[3].items, {
	title = EdgeScoreboard.GetPhrase("SCRB_UTIL_CLEANSERVERPROPS"),
	subTitle = EdgeScoreboard.GetPhrase("SCRB_UTIL_CLEANSERVERPROPS_DESC"),
	onClick = function(  )

		-- Generate 2 random numbers
		local num1, num2 = math.random(1,10), math.random(1,10)

		-- Math question.
		EdgeScoreboard.StringRequest( string.Replace(EdgeScoreboard.GetPhrase("SERV_UTIL_MATHQUESTION"), "%Q", num1 .. " + " .. num2), "", function( text )

			-- Make the text a number.
			text = tonumber(text)

			-- Check if the answer was correct.
			if !text or text != num1 + num2 then
				EdgeScoreboard.ShowMessage( EdgeScoreboard.GetPhrase("SERV_UTIL_MATHWRONG") )
				return
			end

			net.Start("EdgeScoreboard:PerformServerAction")
				net.WriteString("CLEANUPPROPS")
			net.SendToServer()

		end)

	end,
	enabled = function(  )
		return EdgeScoreboard.GetUsergroupConfigValue( LocalPlayer(), "CleanUpProps" )
	end
})

table.insert(utilitiesWidgets[3].items, {
	title = EdgeScoreboard.GetPhrase("SCRB_UTIL_SERVERANNOUNCEMENT"),
	subTitle = EdgeScoreboard.GetPhrase("SCRB_UTIL_SERVERANNOUNCEMENT_DESC"),
	onClick = function(  )

		EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("SERV_UTIL_ANNOUNCEMENT_TITLE"), "", function( text1 )
			EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("SERV_UTIL_ANNOUNCEMENT_MESSAGE"), "", function( text2 )
				net.Start("EdgeScoreboard:PerformServerAction")
					net.WriteString("ANNOUNCEMENT")
					net.WriteTable({Title = text1, Message = text2})
				net.SendToServer()
			end)
		end)

	end,
	enabled = function(  )
		return EdgeScoreboard.GetUsergroupConfigValue( LocalPlayer(), "Announcement" )
	end
})

table.insert(utilitiesWidgets[3].items, {
	title = EdgeScoreboard.GetPhrase("SCRB_UTIL_SCCONFIG"),
	subTitle = EdgeScoreboard.GetPhrase("SCRB_UTIL_SCCONFIG_DESC"),
	onClick = function(  )
		RunConsoleCommand("edgescoreboard_config")
		GAMEMODE.ScoreboardHide()
	end,
	enabled = function(  )
		return EdgeScoreboard.GetUsergroupConfigValue( LocalPlayer(), "ConfigurationAccess" )
	end
})

-- ADd the buttons for the server tab.
if FAdmin and EdgeScoreboard.GetConfigValue("FAdminServerActions") then

	-- Hotfix for some things being visible anyway.
	local permissionHotFix = {
		["Set server limits"] = "ServerSetting",
		["Unban"] = "UnBan",
	}

	-- Loop through FAdmin.ScoreBoard.Server.ActionButtons
	for k,v in pairs(FAdmin.ScoreBoard.Server.ActionButtons) do

		-- Get the widgetname.
		local widgetName = isstring(v.Name) and v.Name or v.Name()

		-- Insert the button.
		table.insert(utilitiesWidgets[3].items, {
			getTitle = function() return "[FAdmin] " .. widgetName end,
			subTitle = EdgeScoreboard.GetPhrase("SERV_UTIL_FADMIN_DESC"),
			onClick = v.Action,
			enabled = function(  )

				-- Check if there is a hotfix for this widget.
				if permissionHotFix[widgetName] then
					return FAdmin.Access.PlayerHasPrivilege(LocalPlayer(), permissionHotFix[widgetName])
				end

				-- Return the original value.
				return isbool(v.Visible) and v.Visible or v.Visible(LocalPlayer())

			end
		})

	end

end

-- Create a table to store the derma element in.
local PANEL = {}

-- Create a function to open a utilities page.
function PANEL:OpenPage( widgetTable )

	-- Create a var for if there is a visible item.
	local itemVisible = false

	-- LOop through widgetTable.items
	for k,v in pairs(widgetTable.items) do

		-- Check if the item is visible.
		if v.enabled == nil or v.enabled() then

			-- Set itemVisible to true and break.
			itemVisible = true
			break

		end

	end

	-- Check if we have any items visible.
	if !itemVisible then

		-- Tell the player that there are no visible items in there.
		EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_POPUP, EdgeScoreboard.GetPhrase("UTIL_SERVER_NOPERMISSION") )

		-- Stop the code.
		return

	end

	-- Move the active panel up.
	self.activePanel:AlphaTo(0,0.1,0,function( _, pnl )

		-- Remove the panel if the active panel isn't the widgetsPanel.
		if pnl != self.widgetsPanel then
			pnl:Remove()
		end

	end)

	-- Create a panel for the utilities.
	local utilityPanel = vgui.Create("DScrollPanel",self)
	utilityPanel:SetSize(self:GetWide(),self:GetTall())
	utilityPanel.Paint = function(  ) end
	utilityPanel.VBar:SetWide(0)

	-- Enable smooth scrolling.
	utilityPanel.VBar.AddScroll = function( _, scroll )

		-- Get the old scrollposition.
		local oldScroll = utilityPanel.VBar:GetScroll()

		-- Animate to the new scrollposition instead of setting it directly.
		utilityPanel.VBar:AnimateTo(oldScroll + scroll * 40, 0.2, 0, 0.5)

		-- Return if we have reached the bottom.
		return oldScroll != utilityPanel.VBar:GetScroll()

	end

	-- Fade in the utilityPanel.
	utilityPanel:SetAlpha(0)
	utilityPanel:AlphaTo(255,0.1)

	-- Update self.activePanel
	self.activePanel = utilityPanel

	-- Create the header.
	local header = vgui.Create("DPanel",utilityPanel)
	header:SetSize(self:GetWide(),headerHeight)
	EdgeScoreboard.SetEdgeTheme( header, true, false, function( s, w, h )

		-- Draw the icon.
		surface.SetDrawColor(COLORS["White"])
		surface.SetMaterial(widgetTable.icon)
		surface.DrawTexturedRect(headerIconMargin,headerIconMargin,headerIconSize,headerIconSize)

		-- Draw the title.
		draw.SimpleText(string.Replace(widgetTable.name,"//"," "),"EdgeScoreboard:Utilities_HeaderTitle",headerIconMargin * 2 + headerIconSize,headerTopPadding,COLORS["White"])

	end)

	-- Create a label for the description.
	local description = vgui.Create("DLabel",header)
	description:SetSize(header:GetWide() - headerIconMargin * 3 - headerIconSize, descriptionHeight)
	description:SetPos(headerIconMargin * 2 + headerIconSize,header:GetTall() - descriptionHeight - headerTopPadding)
	description:SetTextColor(COLORS["White"])
	description:SetFont("EdgeScoreboard:Utilities_HeaderSubTitle")
	description:SetWrap(true)
	description:SetText(widgetTable.description)
	description:SetContentAlignment(7)

	-- Create the backButton
	local backButton = vgui.Create("DButton",utilityPanel)
	backButton:SetSize(buttonWidth,buttonHeight)
	backButton:SetPos(0,headerHeight + EdgeScoreboard.elementMargin)
	backButton:SetText("")

	EdgeScoreboard.SetEdgeTheme( backButton, true, false, function( s, w, h )
		draw.SimpleText(EdgeScoreboard.GetPhrase("UTIL_GOBACK"),"EdgeScoreboard:Utilities_CloseButton",h * 0.13,h / 2,COLORS["ServerList_Widget"],TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
	end)

	-- Create the DoClick function for the backbutton
	backButton.DoClick = function(  )

		-- Hide the utilityPanel
		utilityPanel:AlphaTo(0,0.1,0,function(  )

			-- Remove the utilityPanel
			utilityPanel:Remove()

		end)

		-- Update the activePanel
		self.activePanel = self.widgetsPanel

		-- Show the widgetsPanel.
		self.widgetsPanel:AlphaTo(255,0.1)

	end

	backButton.OnCursorEntered = EdgeScoreboard.ClickSound

	-- Create a var for the loopindex
	local loopIndex = 2

	-- Loop through the items.
	for k,v in pairs(widgetTable.items) do

		-- Check if the button should be visible.
		if v.enabled == false or isfunction(v.enabled) and v.enabled(LocalPlayer()) == false then continue end

		-- Create a var for the xPos.
		local xPos = 0

		-- Update nextXPos.
		if loopIndex % 2 == 0 then
			xPos = self:GetWide() - buttonWidth
		else
			xPos = (loopIndex % 2 - 1) * (buttonWidth + EdgeScoreboard.elementMargin)
		end

		-- Create the Button
		local button = vgui.Create("DButton",utilityPanel)
		button:SetSize(buttonWidth,buttonHeight)
		button:SetPos(xPos,math.ceil(loopIndex / 2 - 1) * (buttonHeight + EdgeScoreboard.elementMargin) + headerHeight + EdgeScoreboard.elementMargin)
		button:SetText("")

		button.OnCursorEntered = EdgeScoreboard.ClickSound

		-- For Fadmin......
		button.SetImage2 = function(  ) end

		button.DoClick = function(  )
			v.onClick(button)
			button:SetText("")
		end

		local textMargin = EdgeScoreboard.GetConfigValue("Hide_Header") and buttonHeight * 0.13 or buttonHeight * 0.18

		EdgeScoreboard.SetEdgeTheme( button, true, false, function( s, w, h )

			--Draw the text.
			draw.SimpleText(v.title or v.getTitle(),"EdgeScoreboard:Utilities_ButtonTitle",textMargin,textMargin,COLORS["ServerList_Widget"])
			draw.SimpleText(v.subTitle or v.getSubTitle(),"EdgeScoreboard:Utilities_ButtonSubTitle",textMargin,h - textMargin,COLORS["White"],TEXT_ALIGN_LEFT,TEXT_ALIGN_BOTTOM)

		end)

		-- INcrease loopIndex by 1
		loopIndex = loopIndex + 1

	end

end

-- Create a init function for the panel.
function PANEL:Init( )

	-- Setup the list
	self:SetSize(listData.ScrollPanelWidth, listData.ScrollPanelHeight)

	-- Create a panel for the widgetButtons.
	self.widgetsPanel = vgui.Create("DPanel",self)
	self.widgetsPanel:SetSize(self:GetWide(),self:GetTall())
	self.widgetsPanel.Paint = function(  ) end

	-- Create a var for the activePanel.
	self.activePanel = self.widgetsPanel

	local textMargin = EdgeScoreboard.GetConfigValue( "Hide_Header" ) and 0.06 or 0.05
	local iconPos = !EdgeScoreboard.GetConfigValue("Hide_Rightbar") and EdgeScoreboard.GetConfigValue("Hide_Header") and listData.ScrollPanelHeight * 0.28 or listData.ScrollPanelHeight * 0.34

	-- Loop through utilitiesWidgets.
	for k,v in pairs(utilitiesWidgets) do

		-- Create the widget.
		local utilityWidget = vgui.Create("DButton",self.widgetsPanel)
		utilityWidget:SetSize(widgetWidth, listData.ScrollPanelHeight)
		utilityWidget:SetPos((widgetWidth + EdgeScoreboard.elementMargin) * (k - 1) , 0)
		utilityWidget:SetText("")
		EdgeScoreboard.SetEdgeTheme( utilityWidget, true, false, function( s, w, h )

			-- Draw the icon.
			surface.SetDrawColor(COLORS["White"])
			surface.SetMaterial(v.icon)
			surface.DrawTexturedRect(w / 2 - iconSize / 2, iconPos, iconSize, iconSize)

			local explodedName = string.Explode("//",v.name)

			-- Draw the subtitle.
			draw.SimpleText( explodedName[1], "EdgeScoreboard:Utilities_TabTitle", w / 2, h * 0.6, COLORS["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM )
			draw.SimpleText( explodedName[2], "EdgeScoreboard:Utilities_TabTitle", w / 2, h * (0.6 + textMargin), COLORS["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM )

		end )

		-- Set the DoClick func.
		utilityWidget.DoClick = function(  )
			self:OpenPage(v)
		end

		utilityWidget.OnCursorEntered = EdgeScoreboard.ClickSound

	end

end

-- Register the derma element.
vgui.Register("EdgeScoreboard:UtilitiesTab", PANEL)