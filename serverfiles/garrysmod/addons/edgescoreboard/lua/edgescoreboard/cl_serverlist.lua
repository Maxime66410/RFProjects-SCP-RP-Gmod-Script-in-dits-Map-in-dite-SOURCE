-- Get the calculated values.
local listData = EdgeScoreboard.listData

-- Get the colors.
local COLORS = EdgeScoreboard.Colors

-- Calculate the titleHeight.
local titleHeight = math.Round(listData.ScrollPanelHeight * 0.05)
local widgetHeight = math.Round(EdgeScoreboard.GetConfigValue( "Hide_Header" ) and listData.ScrollPanelHeight * 0.1 or listData.ScrollPanelHeight * 0.085)
local buttonSize = widgetHeight * 2 + EdgeScoreboard.elementMargin
local iconSize = buttonSize * 0.45
local binoIconSize = listData.ScrollPanelHeight * 0.2
local widgetWidth = math.Round((listData.ScrollPanelWidth - buttonSize - EdgeScoreboard.elementMargin * 2) / 2)
local containerWidth = listData.ScrollPanelWidth
local containerHeight = buttonSize
local serverMargin = math.floor(EdgeScoreboard.GetConfigValue( "Hide_Header" ) and (listData.ScrollPanelHeight - (titleHeight + EdgeScoreboard.elementMargin + containerHeight) * 3) / 2 or (listData.ScrollPanelHeight - (titleHeight + EdgeScoreboard.elementMargin + containerHeight) * 4) / 3 )

-- Create a material for the binoculars.
local MAT_BINOCULARS = Material("edgescoreboard/icon_binoculars.png", "smooth")

-- Create a table to store the derma element in.
local PANEL = {}

-- Create a init function for the panel.
function PANEL:Init( )

	-- Setup the list
	self:SetSize(listData.ScrollPanelWidth, listData.ScrollPanelHeight)
	-- Enable smooth scrolling.
	self.VBar.AddScroll = function( _, scroll )

		-- Get the old scrollposition.
		local oldScroll = self.VBar:GetScroll()

		-- Animate to the new scrollposition instead of setting it directly.
		self.VBar:AnimateTo(oldScroll + scroll * 40, 0.2, 0, 0.5)

		-- Return if we have reached the bottom.
		return oldScroll != self.VBar:GetScroll()

	end

	-- Create a var if the list has any servers.
	self.hasServers = false

	self.VBar:SetWide(0)

end

-- Create the paint function for the panel.
function PANEL:Paint( w, h )

	-- CHeck if the panel has any servers.
	if !self.hasServers then

		-- Draw the binoculars icon.
		surface.SetDrawColor(COLORS["White"])
		surface.SetMaterial(MAT_BINOCULARS)
		surface.DrawTexturedRect(w / 2 - binoIconSize / 2, h * 0.15, binoIconSize, binoIconSize)

		-- Draw the title
		draw.SimpleText( EdgeScoreboard.GetPhrase("SERVERLIST_NOADD"), "EdgeScoreboard:ServerList_Bino_Title", w / 2, h * 0.38, COLORS["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		draw.SimpleText( EdgeScoreboard.GetPhrase("SERVERLIST_NOADD_SUBTIT"), "EdgeScoreboard:ServerList_Bino_SubTitle", w / 2, h * 0.44, COLORS["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

	end

end

-- Create the materials.
local MAT_CONNECT = Material("edgescoreboard/icon_connect.png", "smooth")

-- Create a function to add a new server.
function PANEL:AddServer( serverID )

	local serverData = EdgeScoreboard.Configuration.Servers[serverID]

	widgetTbl = {
		{prefix = EdgeScoreboard.GetPhrase("SERVERS_MAP_PREFIX"), data = serverData.Map},
		{prefix = EdgeScoreboard.GetPhrase("SERVERS_GM_PREFIX"), data = serverData.Gamemode},
		{prefix = EdgeScoreboard.GetPhrase("SERVERS_PS_PREFIX"), data = serverData.Slots .. " Slots"},
		{prefix = EdgeScoreboard.GetPhrase("SERVERS_IP_PREFIX"), data = serverData.Address .. ":" .. serverData.Port},
	}

	-- Set self.hasServers .
	self.hasServers = true

	-- Create the title.
	local title = vgui.Create("DLabel",self)
	title:SetText(serverData.Name)
	title:SetFont("EdgeScoreboard:ServerListTitle")
	title:SetColor(COLORS["White"])
	title:SizeToContents()
	title:SetTall(titleHeight)
	title:Dock(TOP)
	title:DockMargin(0, 0, 0, EdgeScoreboard.elementMargin)

	-- Create the widgetContainer.
	local widgetContainer = vgui.Create("DPanel", self)
	widgetContainer:SetSize(containerWidth, containerHeight)
	widgetContainer:Dock(TOP)
	widgetContainer:DockMargin(0, 0, 0, serverMargin)

	-- Make the widgetContainer invisible.
	widgetContainer.Paint = function(  ) end

	-- Loop through the widgetTbl.
	for k,v in pairs(widgetTbl) do

		-- Create a var for the xpos and ypos.
		local xPos = 0
		local yPos = 0

		-- Check if we are to the left or right
		if k % 2 == 0 then

			-- Set the XPos to the right.
			xPos = widgetWidth + EdgeScoreboard.elementMargin

		end

		-- Check if we are to the first or second row.
		if k > 2 then

			-- Set the XPos to the right.
			yPos = widgetHeight + EdgeScoreboard.elementMargin

		end

		-- Create the widget.
		local widget = vgui.Create("DPanel", widgetContainer)
		widget:SetSize(widgetWidth, widgetHeight)
		widget:SetPos(xPos, yPos)

		-- Draw the widget.
		EdgeScoreboard.SetEdgeTheme( widget, true, false, function( s, w, h )

			-- Draw the title.
			draw.SimpleText( v.prefix, "EdgeScoreboard:ServerList_WidgetTitle", h * 0.13, h * 0.13, COLORS["ServerList_Widget"] )
			draw.SimpleText( v.data, "EdgeScoreboard:ServerList_WidgetData", h * 0.13, h * 0.87, COLORS["White"], TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )

		end )

	end

	-- Add the button.
	local button = vgui.Create("DButton",widgetContainer)
	button:SetText("")
	button:SetSize(buttonSize, buttonSize)
	button:SetPos(widgetContainer:GetWide() - button:GetWide(), 0)

	-- Draw the widget.
	EdgeScoreboard.SetEdgeTheme( button, true, false, function( s, w, h )

		-- Draw the icon.
		surface.SetDrawColor(COLORS["White"])
		surface.SetMaterial(MAT_CONNECT)
		surface.DrawTexturedRect(w / 2 - iconSize / 2, h * 0.17, iconSize, iconSize)

		-- Draw the text.
		draw.SimpleText(EdgeScoreboard.GetPhrase("SERVERLIST_CONNECT"), "EdgeScoreboard:ServerList_Button", w / 2, h * 0.83, COLORS["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)

	end )

	-- Set the action of the button.
	button.DoClick = function(  )

		-- Get the phrase.
		local phrase = EdgeScoreboard.GetPhrase("SERVERLIST_VERIFY_CONNECT")

		-- Replace tags.
		phrase = string.Replace(phrase,"%S",serverData.Name)

		-- Ask the player before connecting.
		EdgeScoreboard.DermaQuery(phrase, {{function(  )

			-- Connect to the server.
			LocalPlayer():ConCommand("connect " .. serverData.Address .. ":" .. serverData.Port)

		end}})

	end

	button.OnCursorEntered = EdgeScoreboard.ClickSound

end

-- Register the derma element.
vgui.Register("EdgeScoreboard:ServerList", PANEL, "DScrollPanel")