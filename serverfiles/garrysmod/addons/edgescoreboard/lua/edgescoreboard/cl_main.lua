--[[-------------------------------------------------------------------------
Colors
---------------------------------------------------------------------------]]

--Create a table to store all the colors in.
EdgeScoreboard.Colors = {}

EdgeScoreboard.Colors["Black"] = Color(0,0,0,255)
EdgeScoreboard.Colors["Black_Transparent"] = Color(50,50,50,200)
EdgeScoreboard.Colors["Gray_Transparent"] = Color(80,80,80,200)
EdgeScoreboard.Colors["Gray"] = Color(200,200,200,255)
EdgeScoreboard.Colors["Dark_Gray"] = Color(50,50,50,250)
EdgeScoreboard.Colors["White"] = Color(255,255,255,255)
EdgeScoreboard.Colors["White_Outline"] = Color(255,255,255,50)
EdgeScoreboard.Colors["White_Corners"] = Color(255,255,255,120)
EdgeScoreboard.Colors["White_Button_Idle"] = Color(255,255,255,5)
EdgeScoreboard.Colors["White_Button_Hover"] = Color(255,255,255,12)
EdgeScoreboard.Colors["DTextEntry_Highlight"] = Color(39,102,138,255)
EdgeScoreboard.Colors["Avatar_Outline"] = Color(255,255,255,50)
EdgeScoreboard.Colors["ServerList_Widget"] = Color(82, 189, 255)
EdgeScoreboard.Colors["Chat_Prefix"] = Color(65, 65, 65, 255)
EdgeScoreboard.Colors["Chat_Suffix"] = Color(150, 150, 150, 255)
EdgeScoreboard.Colors["Hidden_Red"] = Color(185, 70, 70, 255)
EdgeScoreboard.Colors["Avatar_Gray"] = Color(80, 80, 80)
EdgeScoreboard.Colors["HoverRow"] = Color(240,240,240,2)
EdgeScoreboard.Colors["Row_Friend"] = Color(52,161,224,25)
EdgeScoreboard.Colors["Row_Dead"] = Color(180,15,15,45)
EdgeScoreboard.Colors["Muted_Red"] = Color(185, 70, 70, 255)
EdgeScoreboard.Colors["TTT_Detective"] = Color(15,19,255,20)
EdgeScoreboard.Colors["TTT_Traitor"] = Color(255,15,15,20)



EdgeScoreboard.Colors["defaultCategory_Blue"] = Color(92, 181, 250)
EdgeScoreboard.Colors["defaultCategory_Gray"] = Color(171, 171, 171)
EdgeScoreboard.Colors["defaultCategory_Green"] = Color(84, 204, 112)
EdgeScoreboard.Colors["defaultCategory_Red"] = Color(204, 84, 84)
EdgeScoreboard.Colors["defaultCategory_Yellow"] = Color(255, 248, 115)
EdgeScoreboard.Colors["defaultCategory_Purple"] = Color(176, 115, 255)
EdgeScoreboard.Colors["defaultCategory_Pink"] = Color(255, 158, 234)

-- I'll keep these here if we ever use them.
EdgeScoreboard.Colors["Red"] = Color(255,106,106,255)
EdgeScoreboard.Colors["Green"] = Color(55,160,6,255)

COLORS = EdgeScoreboard.Colors

--[[-------------------------------------------------------------------------
Panel Calculations - BoardPanel
---------------------------------------------------------------------------]]

-- Create a table for all the data.
local boardData = {}

-- Get the screen height and width.
local screenWidth, screenHeight = ScrW(), ScrH()

--Check if the screen is a weird size.
if screenWidth <= screenHeight * 1.2 then

	-- Calculate the scoreboard size if the screen is weird.
	boardData.boardWidth = screenWidth * 0.8
	boardData.boardHeight = boardData.boardWidth / 1.68

else

	-- Calculate the scoreboard size is normal.
	boardData.boardWidth = screenHeight * 1.18
	boardData.boardHeight = screenHeight * 0.7

end

-- Floor the size.
boardData.boardWidth = math.Round(boardData.boardWidth)
boardData.boardHeight = math.Round(boardData.boardHeight)

-- Save the data globally.
EdgeScoreboard.boardData = boardData

--[[-------------------------------------------------------------------------
Panel Calculations - Misc
---------------------------------------------------------------------------]]

-- Calculate the margin.
EdgeScoreboard.elementMargin = math.Round(boardData.boardHeight * 0.01)

--[[-------------------------------------------------------------------------
Offsets
---------------------------------------------------------------------------]]

EdgeScoreboard.widthOffset = 0

if !EdgeScoreboard.GetConfigValue("Hide_Rightbar") and !EdgeScoreboard.GetConfigValue("Hide_Leftbar") then
	EdgeScoreboard.widthOffset = math.Round(boardData.boardWidth * 0.1)
end

EdgeScoreboard.heightOffset = 0

if !EdgeScoreboard.GetConfigValue("Hide_Header") and !EdgeScoreboard.GetConfigValue("Hide_Leftbar") then
	--EdgeScoreboard.heightOffset = math.Round(boardData.boardHeight * 0.05)
end

--[[-------------------------------------------------------------------------
Panel Calculations - Header
---------------------------------------------------------------------------]]

-- Create a table for all the data.
local headerData = {}

-- Calculate
headerData.headerWidth = math.Round(EdgeScoreboard.GetConfigValue("Hide_Rightbar") and boardData.boardWidth * 0.82 or boardData.boardWidth - EdgeScoreboard.widthOffset)
headerData.headerHeight = math.Round(boardData.boardHeight * 0.19)

-- Save the data globally.
EdgeScoreboard.headerData = headerData

--[[-------------------------------------------------------------------------
Panel Calculations - Right Sidebar
---------------------------------------------------------------------------]]

-- Create a table for all the data.
local rightData = {}

-- Calculate
rightData.rightsideWidth = math.Round(boardData.boardWidth * 0.18 - EdgeScoreboard.elementMargin)
rightData.rightsideHeight = math.Round(boardData.boardHeight)

-- Save the data globally.
EdgeScoreboard.rightData = rightData

--[[-------------------------------------------------------------------------
Panel Calculations - Searchbar
---------------------------------------------------------------------------]]

-- Create a table for all the data.
local searchbarData = {}

-- Calculate
searchbarData.searchbarWidth = rightData.rightsideWidth
searchbarData.searchbarHeight = math.Round(boardData.boardHeight * 0.045)

-- Save the data globally.
EdgeScoreboard.searchbarData = searchbarData

--[[-------------------------------------------------------------------------
Panel Calculations - Left Sidebar
---------------------------------------------------------------------------]]

-- Create a table for all the data.
local leftData = {}

-- Calculate.
leftData.leftsideWidth = rightData.rightsideWidth
leftData.leftsideHeight = math.Round(boardData.boardHeight - (EdgeScoreboard.GetConfigValue( "Hide_Header" ) and headerData.headerHeight + EdgeScoreboard.elementMargin or EdgeScoreboard.heightOffset) - searchbarData.searchbarHeight - EdgeScoreboard.elementMargin)

-- Save the data globally.
EdgeScoreboard.leftData = leftData

--[[-------------------------------------------------------------------------
Panel Calculations - List
---------------------------------------------------------------------------]]

-- Create a table for all the data.
local listData = {}

-- Calculate.
listData.listWidth = math.Round(boardData.boardWidth - (EdgeScoreboard.GetConfigValue("Hide_Leftbar") and leftData.leftsideWidth + EdgeScoreboard.elementMargin or 0) - (EdgeScoreboard.GetConfigValue("Hide_Rightbar") and rightData.rightsideWidth + EdgeScoreboard.elementMargin or EdgeScoreboard.widthOffset))
listData.listHeight = math.Round(boardData.boardHeight - (EdgeScoreboard.GetConfigValue( "Hide_Header" ) and headerData.headerHeight + EdgeScoreboard.elementMargin or EdgeScoreboard.heightOffset))

-- Calculate the sidemargin.
listData.list_SideMargin = math.Round(EdgeScoreboard.elementMargin * 1.5)
listData.RowWidth = listData.listWidth - listData.list_SideMargin * 2
listData.RowHeight = EdgeScoreboard.GetConfigValue( "Hide_Header" ) and math.Round(listData.listHeight * 0.08) or math.Round(listData.listHeight * 0.065)
listData.RowMargin = math.Round(listData.listHeight * 0.01)
listData.AvatarSize = math.Round(listData.RowHeight * 0.75)
listData.AvatarMargin = math.Round((listData.RowHeight - listData.AvatarSize) / 2)
listData.SectionMargin = math.Round(listData.listHeight * 0.026)
listData.TitleMargin = math.Round(listData.RowHeight * 0.14)
listData.RowTextMargin = math.Round(listData.RowHeight * 0.1)
listData.RowTextSideMargin = math.Round(listData.RowWidth * 0.04)
listData.TitleHeight = math.Round(listData.listHeight * 0.05)
listData.ScrollPanelWidth = listData.listWidth - listData.list_SideMargin * 2
listData.ScrollPanelHeight = listData.listHeight - listData.list_SideMargin * 2

-- Save the data globally.
EdgeScoreboard.listData = listData

--[[-------------------------------------------------------------------------
Fonts
---------------------------------------------------------------------------]]

surface.CreateFont( "EdgeScoreboard:HeaderTitle", {
	font = "Roboto Thin",
	size = ScrH() * 0.07,
	weight = 100,
} )

surface.CreateFont( "EdgeScoreboard:HeaderSubTitle", {
	font = "Roboto Thin",
	size = ScrH() * 0.03,
	weight = 100,
} )

surface.CreateFont( "EdgeScoreboard:LeftSidebar_Button", {
	font = "Roboto",
	size = ScrH() * 0.024,
	weight = 300,
} )

surface.CreateFont( "EdgeScoreboard:SearchBar", {
	font = "Roboto",
	size = ScrH() * 0.017,
	weight = 300,
} )

surface.CreateFont( "EdgeScoreboard:RightSidebar_Title", {
	font = "Roboto Light Italic",
	size = ScrH() * 0.025,
	weight = 400,
} )

surface.CreateFont( "EdgeScoreboard:RightSidebar_SubTitle", {
	font = "Roboto Light Italic",
	size = ScrH() * 0.017,
	weight = 400,
} )

surface.CreateFont( "EdgeScoreboard:RightSidebar_Fields", {
	font = "Roboto Light",
	size = ScrH() * 0.018,
	weight = 340,
} )

surface.CreateFont( "EdgeScoreboard:RightSidebar_WidgetTitle", {
	font = "Roboto Italic",
	size = ScrH() * 0.015,
	weight = 400,
} )

surface.CreateFont( "EdgeScoreboard:RightSidebar_WidgetData", {
	font = "Roboto",
	size = ScrH() * 0.0125,
	weight = 400,
} )

surface.CreateFont( "EdgeScoreboard:ListTeamTitle", {
	font = "Roboto Light",
	size = ScrH() * 0.028,
	weight = 0,
} )

surface.CreateFont( "EdgeScoreboard:ListRowPrefix", {
	font = "Roboto",
	size = ScrH() * 0.019,
	weight = 350,
} )

surface.CreateFont( "EdgeScoreboard:ListRowData", {
	font = "Roboto Light",
	size = ScrH() * 0.018,
	weight = 300,
} )

surface.CreateFont( "EdgeScoreboard:List_Avatar", {
	font = "Roboto",
	size = ScrH() * 0.022,
	weight = 300,
} )

surface.CreateFont( "EdgeScoreboard:ServerListTitle", {
	font = "Roboto Thin",
	size = ScrH() * 0.03,
	weight = 300,
} )

surface.CreateFont( "EdgeScoreboard:ServerList_WidgetTitle", {
	font = "Roboto",
	size = ScrH() * 0.023,
	weight = 300,
} )

surface.CreateFont( "EdgeScoreboard:ServerList_WidgetData", {
	font = "Roboto",
	size = ScrH() * 0.019,
	weight = 300,
} )

surface.CreateFont( "EdgeScoreboard:ServerList_Button", {
	font = "Roboto Light",
	size = ScrH() * 0.023,
	weight = 0,
} )

surface.CreateFont( "EdgeScoreboard:ServerList_Bino_Title", {
	font = "Roboto",
	size = ScrH() * 0.045,
	weight = 300,
} )

surface.CreateFont( "EdgeScoreboard:ServerList_Bino_SubTitle", {
	font = "Roboto",
	size = ScrH() * 0.022,
	weight = 300,
} )

surface.CreateFont( "EdgeScoreboard:Utilities_TabTitle", {
	font = "Roboto",
	size = ScrH() * 0.035,
	weight = 300,
} )

surface.CreateFont( "EdgeScoreboard:Utilities_HeaderTitle", {
	font = "Roboto",
	size = ScrH() * 0.036,
	weight = 300,
} )

surface.CreateFont( "EdgeScoreboard:Utilities_HeaderSubTitle", {
	font = "Roboto",
	size = ScrH() * 0.022,
	weight = 300,
} )

surface.CreateFont( "EdgeScoreboard:Utilities_ButtonTitle", {
	font = "Roboto",
	size = ScrH() * (EdgeScoreboard.GetConfigValue("Hide_Header") and 0.02 or 0.023),
	weight = 300,
} )

surface.CreateFont( "EdgeScoreboard:Utilities_ButtonSubTitle", {
	font = "Roboto",
	size = ScrH() * (EdgeScoreboard.GetConfigValue("Hide_Header") and 0.018 or 0.02),
	weight = 300,
} )

surface.CreateFont( "EdgeScoreboard:Utilities_CloseButton", {
	font = "Roboto",
	size = ScrH() * 0.024,
	weight = 300,
} )

surface.CreateFont( "EdgeScoreboard:Config_Sidebar", {
	font = "Roboto Light",
	size = ScrH() * 0.02,
	weight = 300,
} )

surface.CreateFont( "EdgeScoreboard:Config_OptionTitle", {
	font = "Roboto",
	size = ScrH() * 0.022,
	weight = 500,
} )

surface.CreateFont( "EdgeScoreboard:Config_OptionDesc", {
	font = "Roboto",
	size = ScrH() * 0.018,
	weight = 300,
} )

surface.CreateFont( "EdgeScoreboard:Config_ActionButton", {
	font = "Roboto",
	size = ScrH() * 0.017,
	weight = 500,
} )

surface.CreateFont( "EdgeScoreboard:Config_OptionButton", {
	font = "Roboto",
	size = ScrH() * 0.018,
	weight = 400,
} )

surface.CreateFont( "EdgeScoreboard:Config_AddGroup", {
	font = "Roboto",
	size = ScrH() * 0.02,
	weight = 500,
} )

surface.CreateFont( "EdgeScoreboard:Config_GroupTitle", {
	font = "Roboto",
	size = ScrH() * 0.02,
	weight = 300,
} )

surface.CreateFont( "EdgeScoreboard:Config_GroupButton", {
	font = "Roboto",
	size = ScrH() * 0.018,
	weight = 300,
} )

surface.CreateFont( "EdgeScoreboard:Config_GroupEditorTitle", {
	font = "Roboto",
	size = ScrH() * 0.04,
	weight = 300,
} )

surface.CreateFont( "EdgeScoreboard:Config_GroupEditorTReturn", {
	font = "Roboto",
	size = ScrH() * 0.02,
	weight = 300,
} )

surface.CreateFont( "EdgeScoreboard:WebsiteLoadingText", {
	font = "Roboto",
	size = ScrH() * 0.04,
	weight = 300,
} )

surface.CreateFont( "EdgeScoreboard:WebsiteButton", {
	font = "Roboto",
	size = ScrH() * 0.02,
	weight = 400,
} )

surface.CreateFont( "EdgeScoreboard:ColorPalette", {
	font = "Roboto",
	size = 25,
	weight = 400,
} )

surface.CreateFont( "EdgeScoreboard:ExampleLoading", {
	font = "Roboto",
	size = ScrH() * 0.06,
	weight = 100,
} )

surface.CreateFont( "EdgeScoreboard:ExampleExit", {
	font = "Roboto",
	size = ScrH() * 0.08,
	weight = 100,
} )

--[[-------------------------------------------------------------------------
Functions
---------------------------------------------------------------------------]]

-- Create a function used to format time
function EdgeScoreboard.FormatTime( Time, oneFormat )

	local TimeTable = {}

	TimeTable.Hours = math.floor(Time / 3600)
	TimeTable.Minutes = math.floor((Time / 60) % (3600 / 60))
	TimeTable.Seconds = math.floor(Time % 60)

	oneFormat = oneFormat or false

	if TimeTable.Hours > 0 then

		--Create a var for the formatted time.
		local formattedTime = ""

		if oneFormat then
			formattedTime = EdgeScoreboard.GetPhrase("FORMATTEDTIME_H")
		else
			formattedTime = EdgeScoreboard.GetPhrase("FORMATTEDTIME_HM")
		end
		
		formattedTime = string.Replace(formattedTime,"%H",TimeTable.Hours)
		formattedTime = string.Replace(formattedTime,"%M",TimeTable.Minutes)

		return formattedTime

	elseif TimeTable.Minutes > 0 then

		local formattedTime = ""

		if oneFormat then
			formattedTime = EdgeScoreboard.GetPhrase("FORMATTEDTIME_M")
		else
			formattedTime = EdgeScoreboard.GetPhrase("FORMATTEDTIME_MS")
		end

		formattedTime = string.Replace(formattedTime,"%M",TimeTable.Minutes)
		formattedTime = string.Replace(formattedTime,"%S",TimeTable.Seconds)

		return formattedTime

	else

		local formattedTime = EdgeScoreboard.GetPhrase("FORMATTEDTIME_S")
		formattedTime = string.Replace(formattedTime,"%S",TimeTable.Seconds)

		return formattedTime

	end

end

-- Create a function to lighten colors.
function EdgeScoreboard.LightenColors( color )

	if EdgeScoreboard.GetConfigValue( "ColorLightening" ) == false then
		return color
	end

	-- Convert the color to a table.
	local colorTbl = {color.r,color.g,color.b,color.a}

	-- Check how dark the color is.
	if colorTbl[1] < 80 and colorTbl[2] < 80 and colorTbl[3] < 80 then

		local mult = 120 / math.min(colorTbl[1],colorTbl[2],colorTbl[3])

		colorTbl[1] = colorTbl[1] * mult
		colorTbl[2] = colorTbl[2] * mult
		colorTbl[3] = colorTbl[3] * mult

	end



	return Color(colorTbl[1], colorTbl[2], colorTbl[3], colorTbl[4])

end

-- Create a function to play the UI click sound.
function EdgeScoreboard.ClickSound()

	-- Check if the sound should be played.
	if !EdgeScoreboard.GetConfigValue( "ClickSound" ) then return end

	-- Play the sound.
	surface.PlaySound("edgescoreboard/click.mp3")

end

--[[-------------------------------------------------------------------------
Scoreboard information
---------------------------------------------------------------------------]]

-- Add a var for the game uptime.
EdgeScoreboard_GameUptime = EdgeScoreboard_GameUptime or RealTime()

-- ADd a var for the uptime of the server.
EdgeScoreboard.ServerUptime = 0
EdgeScoreboard.UptimeOffset = 0

-- Add a receiver for EdgeScoreboard:SendUptime.
net.Receive("EdgeScoreboard:SendUptime", function(  ) 

	-- Read and set the uptime variable.
	EdgeScoreboard.ServerUptime = net.ReadUInt(22) or 0
	EdgeScoreboard.UptimeOffset = RealTime()

end)

-- Create a variable for the playTime and its offset.
EdgeScoreboard.PlayTime = 0
EdgeScoreboard.PlayTimeOffset = 0

-- Add a receiver for EdgeScoreboard:SendPlaytime.
net.Receive("EdgeScoreboard:SendPlaytime",function( )

	-- Read the data.
	EdgeScoreboard.PlayTime = net.ReadUInt(25)
	EdgeScoreboard.PlayTimeOffset = RealTime()

end)

--[[-------------------------------------------------------------------------
Fake Identities
---------------------------------------------------------------------------]]

local EDGESCOREBOARD_TABLE_MERGE = 1
local EDGESCOREBOARD_TABLE_FRESH = 2

-- Create a table for all fake identies.
EdgeScoreboard.FakeIdentities = {}

-- Create a function to get if a player has a fake identity.
function EdgeScoreboard.HasFakeIdentity(ply)

	-- Set ply to localplayer if nil.
	ply = ply or LocalPlayer()

	-- Return a bool.
	return ply.EdgeScoreboard_FakeIdentity and table.Count(ply.EdgeScoreboard_FakeIdentity) > 0

end

-- Create a function to get a player's fake identity.
function EdgeScoreboard.GetFakeIdentity(type, ply)

	-- Set ply to localplayer if nil.
	ply = ply or LocalPlayer()

	-- Return a bool.
	return ply.EdgeScoreboard_FakeIdentity and ply.EdgeScoreboard_FakeIdentity[type] or nil

end

-- Create a some vars.
local hiddenPlayers = {}

hook.Add("EdgeScoreboard:UpdateDerma","EdgeScoreboard:UpdateHiddenRows", function(  )

	-- Make sure that the scoreboard is visible.
	if !EdgeScoreboard.boardPanel or !EdgeScoreboard.boardPanel:IsVisible() or table.Count(hiddenPlayers) == 0 then return end

	-- Return if the player can see hidden rows.
	if EdgeScoreboard.GetUsergroupConfigValue(LocalPlayer(),"FakeIdentity:SeeHidden") then return end

	-- Loop through all players.
	for k,v in pairs(hiddenPlayers) do

		-- Check if the player has a fake identity.
		if !k.EdgeScoreboard_FakeIdentity or !k.EdgeScoreboard_FakeIdentity.Hidden then continue end

		-- Attempt to get the row from the player.
		local row = k.EdgeScoreboard_Row

		-- Check if the player should be hidden.
		if IsValid(row) then

			-- Simulate the row being removed.
			hook.Run("EdgeScoreboard:RowRemoved", row)

			-- Remove the row.
			row:Remove()

		end

	end

end)

-- Add a receiver for EdgeScoreboard:Identity:DataUpdate.
net.Receive("EdgeScoreboard:Identity:DataUpdate",function(  )

	-- Reset hiddenPlayers
	hiddenPlayers = {}

	-- REad the data.
	local actionType = net.ReadUInt(2)
	local data = net.ReadTable()

	-- Check what type the transfer is.
	if actionType == EDGESCOREBOARD_TABLE_FRESH then

		-- Read the table.
		EdgeScoreboard.FakeIdentities = data

	else

		-- Look for any empty values.
		for k,v in pairs(data) do

			if table.Count(v) != 0 then
				EdgeScoreboard.FakeIdentities[k] = v
			else
				EdgeScoreboard.FakeIdentities[k] = nil
			end

		end

	end

	-- Get if the player can see hidden palyers.
	local canSeeHidden = EdgeScoreboard.GetUsergroupConfigValue(LocalPlayer(),"FakeIdentity:SeeHidden")

	-- Loop through all players.
	for k,v in pairs(player.GetAll()) do

		-- Check if the player has a fake identity set.
		if EdgeScoreboard.FakeIdentities[v:SteamID()] then

			-- Set the fake identity var for the player.
			v.EdgeScoreboard_FakeIdentity = EdgeScoreboard.FakeIdentities[v:SteamID()]

			-- Attempt to get the row from the player.
			local row = v.EdgeScoreboard_Row

			-- Make sure that the row exists.
			if IsValid(row) then

				-- Check if the player has a fake avatar.
				if EdgeScoreboard.GetFakeIdentity("Avatar", v) then

					-- Set the fake avatar.
					row.avatar:SetSteamID(v.EdgeScoreboard_FakeIdentity.Avatar,row.avatar:GetTall())

				else

					-- Set the avatar to normal.
					row.avatar:SetPlayer(v,row.avatar:GetTall())

				end

				-- Check if the player should be hidden.
				if EdgeScoreboard.GetFakeIdentity("Hidden", v) then

					hiddenPlayers[v] = EdgeScoreboard.FakeIdentities[v:SteamID()]

					if !canSeeHidden then

						-- Simulate the row being removed.
						hook.Run("EdgeScoreboard:RowRemoved", row)

						-- Remove the row.
						row:Remove()

					end

				end

			end

		else

			-- Check if the player had a fake identity before.
			if v.EdgeScoreboard_FakeIdentity then

				-- Attempt to get the player's row.
				local row = v.EdgeScoreboard_Row

				-- Make sure that the row exists.
				if IsValid(row) then

					-- Reset the player's avatarImage.
					row.avatar:SetPlayer(v,row.avatar:GetTall())

				end

			end

			-- Reset the v.EdgeScoreboard_FakeIdentity table.
			v.EdgeScoreboard_FakeIdentity = nil

		end

	end

end)

--[[-------------------------------------------------------------------------
Server Transfer
---------------------------------------------------------------------------]]

-- Add a receiver for EdgeScoreboard:TransferPlayer.
net.Receive("EdgeScoreboard:TransferPlayer", function( _, ply )

	-- Read the data.
	local serverID = net.ReadUInt(6)

	-- Make sure that the server exists.
	if !EdgeScoreboard.Configuration.Servers[serverID] then return end

	-- Tell the server that it is being transfered.
	EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_POPUP, string.Replace(EdgeScoreboard.GetPhrase("TRANSFER_NOTIFY"),"%S",EdgeScoreboard.Configuration.Servers[serverID].Name) )

	-- Create a timer for the server transfer.
	timer.Simple(10,function(  )

		-- Connect the player.
		LocalPlayer():ConCommand("connect " .. EdgeScoreboard.Configuration.Servers[serverID].Address .. ":" .. EdgeScoreboard.Configuration.Servers[serverID].Port)

	end)

end)

-- Add a receiver for EdgeScoreboard:TransferPlayerToUnlisted.
net.Receive("EdgeScoreboard:TransferPlayerToUnlisted", function( _, ply )

	-- Read the data.
	local serverIP = net.ReadString()

	-- Tell the server that it is being transfered.
	EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_POPUP,EDGESCOREBOARD_NOTIFY_POPUP, string.Replace(EdgeScoreboard.GetPhrase("TRANSFER_NOTIFY"),"%S",serverIP) )

	-- Create a timer for the server transfer.
	timer.Simple(10,function(  )

		-- Connect the player.
		LocalPlayer():ConCommand("connect " .. serverIP)

	end)

end)

--[[-------------------------------------------------------------------------
Update Information
---------------------------------------------------------------------------]]

-- Add a receiver for EdgeScoreboard:UpdateInfo.
net.Receive("EdgeScoreboard:UpdateInfo",function(  )

	-- Read the data from the server.
	EdgeScoreboard.Outdated = net.ReadBool()
	EdgeScoreboard.LatestVersion = net.ReadString()

	if EdgeScoreboard.Outdated then

		EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_POPUP, "You are currently using version " .. EdgeScoreboard.Version .. " of EdgeScoreboard which now has become outdated.\nThe latest version of EdgeScoreboard is version " .. EdgeScoreboard.LatestVersion .. " and can be downloaded from Gmodstore.com.\nKeeping addons updated is important to make sure you receive new features, bug fixes, etc.\nThis message is only shown to those who has configuration access." )

	end

end)

--[[-------------------------------------------------------------------------
Announcements
---------------------------------------------------------------------------]]

if !ConVarExists( "edgescoreboard_announcements" ) then
	CreateClientConVar("edgescoreboard_announcements", "1", true, "Should developer announcements from the EdgeScoreboard developer be enabled. (1/0)")
end

local Convar_Announcements = GetConVar("edgescoreboard_announcements")

if EdgeScoreboard.Owner == LocalPlayer():SteamID64() and Convar_Announcements:GetBool() then

	http.Fetch("http://jompe.phy.sx/edgescoreboard_announcement.php",function( result )

		-- Check if we have a message to show.
		if result == "" then return end

		-- Tags.
		result = string.Replace(result,"{{USER}}",LocalPlayer():SteamName())
		result = string.Replace(result,"{{VERSION}}",EdgeScoreboard.Version)
		result = string.Replace(result,"{{OWNER}}",EdgeScoreboard.Owner)

		chat.AddText("\n")
		EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_CHAT, "[Announcement] : " .. result )
		chat.AddText("\n")

	end)

end

concommand.Add("edgescoreboard_toggleannouncements",function(  )

	-- Get and update the data.
	local data = Convar_Announcements:GetBool()
	Convar_Announcements:SetBool(!data)

	EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_CHAT, "Developer announcements has been turned " .. (data == true and "off. Sorry for any inconvenience!" or "on.") )

end)

--[[-------------------------------------------------------------------------
HUD popup
---------------------------------------------------------------------------]]

net.Receive("EdgeScoreboard:HUDAnnouncement", function(  )

	local title = net.ReadString()
	local message = net.ReadString()

	EdgeHUD.ShowHUDPopup( Color(245, 135, 127), title, message )

end)

--[[-------------------------------------------------------------------------
Player functions.
---------------------------------------------------------------------------]]
-- Get the metatable for players
local PLAYER = FindMetaTable("Player")

-- Create a cache for the displaynames.
local displayNamesCache = {}

-- Loop throgh all ranks
for k,v in pairs(EdgeScoreboard.Configuration.Usergroups) do

	-- Check if the usergroup has a custom displayname.
	if v["CustomDisplayName"] and v["CustomDisplayName"] != "" then
		displayNamesCache[string.lower(k)] = v["CustomDisplayName"]
	end

end

-- Create a function to get a player's rank display name.
function PLAYER:ESB_GetRank(getFakeRank)

	-- Get the usergroup of the player.
	local usergroup = ""

	if getFakeRank then
		usergroup = EdgeScoreboard.GetFakeIdentity("Rank", self) or ""
	else
		usergroup = self:GetUserGroup()
		usergroup = string.upper(usergroup[1]) .. string.lower(string.Right(usergroup,#usergroup - 1))
	end

	-- Check if the usergroup has a custom display name.
	if displayNamesCache[string.lower(usergroup)] then
		return displayNamesCache[string.lower(usergroup)]
	end

	-- Return the displayname.
	return usergroup

end

function PLAYER:ESB_GetJobCategory( )

	-- Check if we are running DarkRP.
	if DarkRP then

		-- Get the teamsTable.
		local teamTbl = RPExtraTeams[self:Team()]

		-- Check if the team has a category
		if teamTbl.category then
			return teamTbl.category
		end

		-- Return that the team is uncategorized.
		return EdgeScoreboard.GetPhrase("UNCATEGORIZED")

	else

		-- Return a value.
		return EdgeScoreboard.GetPhrase("UNCATEGORIZED")

	end

end

-- Create a table for the jobcategorycolors.
local categoryColors = {}

if DarkRP then

	-- Loop through all the job categories.
	for k,v in pairs(DarkRP.getCategories()["jobs"]) do
		categoryColors[v.name] = v.color
	end

end

-- Create a function to get a category color.
function EdgeScoreboard.GetCategoryColor( category )

	-- Return the color.
	return categoryColors[category] or Color(255, 255, 255, 255)

end


local runningTTT = engine.ActiveGamemode() == "terrortown"
local TTTGroups = {}
local TTTColors = {}

if runningTTT then

	TTTGroups = {
		[GROUP_TERROR] = LANG.GetTranslation("terrorists"),
		[GROUP_NOTFOUND] = LANG.GetTranslation("sb_mia"),
		[GROUP_FOUND] = LANG.GetTranslation("sb_confirmed"),
		[GROUP_SPEC] = LANG.GetTranslation("spectators"),
		[-1] = "Invalid"
	}

	TTTColors = {
		[TTTGroups[1]] = Color(86, 219, 119, 255),
		[TTTGroups[2]] = Color(93, 166, 111, 255),
		[TTTGroups[3]] = Color(175, 196, 128, 255),
		[TTTGroups[4]] = Color(219, 209, 86, 255),
		[TTTGroups[-1]] = Color(44, 55, 6, 255),
	}

end

local runningDeathrun = engine.ActiveGamemode() == "deathrun"

if runningDeathrun and EdgeScoreboard.GetConfigValue("DEATHRUN_Dead") then
	team.SetUp(-69, EdgeScoreboard.GetPhrase("PLAYERLIST_STATUS_DEAD"), Color(255, 0, 0, 255), false)
end

function PLAYER:ESB_GetTeam(  )

	-- Check what should be returned.
	if EdgeScoreboard.CategoriesHidden then 
		return "_"
	elseif runningTTT then
		return TTTGroups[ScoreGroup(self)]
	elseif runningDeathrun then

		if self:Alive() or !EdgeScoreboard.GetConfigValue("DEATHRUN_Dead") then
			return self:Team()
		else
			return -69
		end

	elseif !EdgeScoreboard.CategoriesAsJobs then
		return self:ESB_GetJobCategory( )
	end

	--Return the default team.
	return self:Team()

end

function EdgeScoreboard.GetTeamColor( teamID )

	if EdgeScoreboard.CategoriesHidden then
		return COLORS["defaultCategory_" .. EdgeScoreboard.GetConfigValue("HiddenCategoryColor")]
	elseif runningTTT then
		return TTTColors[teamID]
	elseif !EdgeScoreboard.CategoriesAsJobs then
		return EdgeScoreboard.LightenColors(EdgeScoreboard.GetCategoryColor(teamID))
	end

	return EdgeScoreboard.LightenColors( team.GetColor(teamID) )

end