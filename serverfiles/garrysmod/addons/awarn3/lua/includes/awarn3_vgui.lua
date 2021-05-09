AddCSLuaFile()
--[[
      __          __              ____  
     /\ \        / /             |___ \ 
    /  \ \  /\  / /_ _ _ __ _ __   __) |
   / /\ \ \/  \/ / _` | '__| '_ \ |__ < 
  / ____ \  /\  / (_| | |  | | | |___) |
 /_/    \_\/  \/ \__,_|_|  |_| |_|____/ 

	AWarn3 by Mr.President
]]

MsgC( AWARN3_STATECOLOR, "[AWarn3] ", AWARN3_WHITE, "Loading VGUI Module\n" )

AWarn.SelectedLanguage = "EN-US"
hook.Add( "InitPostEntity", "awarn3_loadlanguage", function()
	AWarn.SelectedLanguage = LocalPlayer():GetPData( "awarn3_lang", "EN-US" )
end )

local function ScrWM()
	local wid = ScrW()
	if wid > 3840 then wid = 3840 end
	return wid
end

local function ScrHM()
	local hgt = ScrH()
	if hgt > 2160 then hgt = 2160 end
	return hgt
end

function ScreenScale( size )
	return size * ( ScrWM() / 640.0 )	
end

local screenscale = ScreenScale( 0.4 )

surface.CreateFont( "AWarn3NavButton", {
	font = "Arial",
	size = math.Round(18 * screenscale),
	weight = 800,
} )

surface.CreateFont( "AWarn3NavButton2", {
	font = "Arial",
	size = math.Round(24 * screenscale),
	weight = 800,
} )

surface.CreateFont( "AWarn3Label1", {
	font = "Arial",
	size = math.Round(20 * screenscale),
	weight = 800,
} )

surface.CreateFont( "AWarn3Label2", {
	font = "Arial",
	size = math.Round(16 * screenscale),
	weight = 800,
} )

surface.CreateFont( "AWarn3CardText1", {
	font = "Arial",
	size = math.Round(14 * screenscale),
	weight = 800,
} )

surface.CreateFont( "AWarn3CardText2", {
	font = "Arial",
	size = math.Round(12 * screenscale),
	weight = 800,
} )

local logoImage = Material( "materials/vgui/awarn3_logo2.png" )
local playerWarningsImage = Material( "materials/vgui/awarn3_playerwarnings.png" )
local optionsImage = Material( "materials/vgui/awarn3_options.png" )
local deleteImage = Material( "materials/vgui/awarn3_delete.png" )
local minusImage = Material( "materials/vgui/awarn3_minus.png" )
local searchImage = Material( "materials/vgui/awarn3_search.png" )

local easings = include("includes/awarn3_easings.lua")


AWarn.ColorsBackup = {
	COLOR_SELECTED = Color( 255, 136, 0, 200 ),
	COLOR_BUTTON = Color( 80, 80, 80, 200 ),
	COLOR_BUTTON_HOVERED = Color( 92, 92, 92, 200 ),
	COLOR_BUTTON_DISABLED = Color( 120, 120, 120, 40 ),
	COLOR_BUTTON_TEXT = Color( 255, 255, 255, 255 ),
	COLOR_LABEL_TEXT = Color( 255, 255, 255, 255 ),
	COLOR_LABEL_VALUE_TEXT = Color( 255, 136, 0, 255 ),
	COLOR_THEME_PRIMARY = Color( 40, 40, 40, 250 ),
	COLOR_THEME_SECONDARY = Color( 50, 50, 50, 250 )
}

AWarn.Colors = AWarn.Colors or AWarn.ColorsBackup

function AWarn:OpenMenu()
	if IsValid( self.menu ) then self.menu:Remove() end
	self.menu = vgui.Create( "awarn3_menu" )
	self.menu:SetWide( ScrWM() * 0.75 )
	self.menu:SetTall( ScrHM() * 0.75 )
	self.menu:Center()
	self.menu:MakePopup()
	self.menu:DrawElements()
	
	AWarn:RequestOptions()
	AWarn:RequestPunishments()
	AWarn:RequestOwnWarnings()
end

function AWarn:RequestOptions()
	net.Start( "awarn3_networkoptions" )
	net.WriteString( "update" )
	net.SendToServer()
end

function AWarn:RequestPunishments()
	net.Start( "awarn3_networkpunishments" )
	net.WriteString( "update" )
	net.SendToServer()
end

function AWarn:SendOptionUpdate( option, value )
	net.Start( "awarn3_networkoptions" )
	net.WriteString( "write" )
	
	if AWarn.Options[ option ].type == "boolean" then
		net.WriteString( option )
		net.WriteBool( value )
	elseif AWarn.Options[ option ].type == "integer" then
		net.WriteString( option )
		net.WriteInt( value, 32 )
	elseif AWarn.Options[ option ].type == "string" then
		net.WriteString( option )
		net.WriteString( value )
	end
	
	net.SendToServer()
end

net.Receive( "awarn3_networkoptions", function()
	if not IsValid( AWarn.menu ) then return end
	local options = net.ReadTable()
	AWarn.Options = options
	
	if table.Count( AWarn.Options ) > 0 then
		AWarn:RefreshSettings()
	else
		AWarn:RemoveSettings()
	end
end )

net.Receive( "awarn3_networkpunishments", function()
	if not IsValid( AWarn.menu ) then return end
	local punishments = net.ReadTable()
	AWarn.Punishments = punishments
	
	AWarn:RefreshPunishments()
end )

net.Receive( "awarn3_openmenu", function( l, pl )
	AWarn:OpenMenu()
end )

function AWarn:CloseMenu()
	if IsValid( self.menu ) then self.menu:Remove() end
	AWarn:SaveClientSettings()
end

local PANEL = {}
function PANEL:Init()
	self.startTime = SysTime()
	self:SetDraggable( false )
	self:SetTitle( "" )
	self:ShowCloseButton( false )
end
function PANEL:Paint()
	Derma_DrawBackgroundBlur( self, self.startTime )
	surface.SetDrawColor( AWarn.Colors.COLOR_THEME_SECONDARY )
	surface.DrawRect( 180 * screenscale, 70 * screenscale, self:GetWide(), self:GetTall() )
	surface.SetDrawColor( AWarn.Colors.COLOR_THEME_PRIMARY )
	surface.DrawRect( 0, 0, self:GetWide(), 70 * screenscale )
	surface.DrawRect( 0, 70 * screenscale, 180 * screenscale, self:GetTall() - 70 * screenscale )
	
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( logoImage	)
	surface.DrawTexturedRect( 16 * screenscale, 16 * screenscale, 129 * screenscale, 32 * screenscale )
end
function PANEL:DrawElements()

	local navButtonPanel = vgui.Create( "DPanel", self )
	navButtonPanel:SetPos( 0, 70 * screenscale )
	navButtonPanel:DockPadding( 0, 0, 0, 70 * screenscale )
	navButtonPanel:SetSize( 180 * screenscale, self:GetTall() )
	navButtonPanel.Paint = function()
		--Render Invisible
		surface.SetDrawColor( 200, 200, 200, 0 )
		surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	end

	local mainBodyPanel = vgui.Create( "DPanel", self )
	mainBodyPanel:SetPos( 180 * screenscale, 70 * screenscale )
	mainBodyPanel:DockPadding( 0, 0, 0, 0 )
	mainBodyPanel:SetSize( self:GetWide() - 180 * screenscale, self:GetTall() )
	mainBodyPanel.Paint = function()
		--Render Invisible
		surface.SetDrawColor( 200, 200, 200, 0 )
		surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	end
	
	if AWarn:CheckPermission( LocalPlayer(), "awarn_view" ) then
		if IsValid( self.adminWarningsView ) then self.adminWarningsView:Remove() end
		self.adminWarningsView = vgui.Create( "awarn3_adminwarningsview", mainBodyPanel )
	else
		if IsValid( self.selfWarningsView ) then self.selfWarningsView:Remove() end
		self.selfWarningsView = vgui.Create( "awarn3_selfwarningsview", mainBodyPanel )	
	end
	
	if IsValid( self.configurationview ) then self.configurationview:Remove() end
	self.configurationview = vgui.Create( "awarn3_configurationview", mainBodyPanel )
	self.configurationview:Dock( FILL )
	self.configurationview:InvalidateParent( true )
	self.configurationview:DrawElements()
	self.configurationview:Hide()
	
	local navButton = vgui.Create( "awarn3_navbutton", navButtonPanel )
	navButton:SetText(AWarn.Localization:GetTranslation( "viewwarnings" ))
	navButton:SetIcon( playerWarningsImage )
	navButton:SetEnabled( true )
	navButton.OnSelected = function()
		if AWarn:CheckPermission( LocalPlayer(), "awarn_view" ) then
			self.adminWarningsView:Show()
		else
			self.selfWarningsView:Show()
		end
		self.configurationview:Hide()
	end
	AWarn.lastSelectedNavButton = navButton
	
	local navButton = vgui.Create( "awarn3_navbutton", navButtonPanel )
	navButton:SetText(AWarn.Localization:GetTranslation( "configuration" ))
	navButton:SetIcon( optionsImage )
	navButton.OnSelected = function()
		if AWarn:CheckPermission( LocalPlayer(), "awarn_view" ) then
			self.adminWarningsView:Hide()
		else
			self.selfWarningsView:Hide()		
		end		
		self.configurationview:Show()
	end
	
	
	if AWarn:CheckPermission( LocalPlayer(), "awarn_view" ) then
		local navButton = vgui.Create( "awarn3_navbutton2", navButtonPanel )
		navButton:SetText( AWarn.Localization:GetTranslation( "searchplayers" ) )
		navButton:SetIcon( searchImage )
		navButton.OnSelected = function()
			if IsValid( AWarn.menu.playerwarndialogue ) then AWarn.menu.playerwarndialogue:Remove() end
			if IsValid( AWarn.menu.playersearch ) then AWarn.menu.playersearch:Remove() end
			AWarn.menu.playersearch = vgui.Create( "awarn3_playersearch" )
			AWarn.menu.playersearch:MakePopup()
			AWarn.menu.playersearch:SetParent( AWarn.menu )
		end
	end
	
	
	local closeButton = vgui.Create( "awarn3_iconbutton", self )
	closeButton:SetTooltip( AWarn.Localization:GetTranslation( "closemenu" ) )
	closeButton:SetSize(16 * screenscale, 16 * screenscale)
	closeButton:SetPos( self:GetWide() - closeButton:GetWide() - 12 * screenscale, 10 * screenscale )
	closeButton.OnSelected = function()
		AWarn:CloseMenu()
	end

	
end
function PANEL:Think()
	self:MoveToBack()
end
vgui.Register( "awarn3_menu", PANEL, "DFrame" )

local PANEL = {}
function PANEL:Init()
	self:SetDraggable( false )
	self:SetTitle( "" )
	self:ShowCloseButton( false )
	
end
function PANEL:Paint()
	--Render Invisible
	surface.SetDrawColor( 200, 100, 100, 0 )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	
end
function PANEL:DrawElements()

	local ClientConfigDock = vgui.Create( "DPanel", self )
	ClientConfigDock:SetWide( self:GetWide() / 4 )
	ClientConfigDock:DockPadding( 0, 20, 0, 0 )
	ClientConfigDock.Paint = function()
		--Render Invisible
		surface.SetDrawColor( 200, 200, 200, 0 )
		surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	end
	ClientConfigDock:Dock( LEFT )
		
	local vdiv = vgui.Create( "awarn3_vdiv", self )
	vdiv:Dock( LEFT )

	local ServerConfigDock = vgui.Create( "DPanel", self )
	ServerConfigDock:SetWide( self:GetWide() / 4 )
	ServerConfigDock:DockPadding( 0, 20, 0, 0 )
	ServerConfigDock.Paint = function()
		--Render Invisible
		surface.SetDrawColor( 200, 200, 200, 0 )
		surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	end
	ServerConfigDock:Dock( LEFT )
	
	local vdiv = vgui.Create( "awarn3_vdiv", self )
	vdiv:Dock( LEFT )

	local PunishmentsConfigDock = vgui.Create( "DPanel", self )
	PunishmentsConfigDock:DockPadding( 0, 20, 0, 0 )
	PunishmentsConfigDock.Paint = function()
		--Render Invisible
		surface.SetDrawColor( 200, 200, 200, 0 )
		surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
				
		surface.SetFont( "AWarn3CardText2" )
		local text = "Version: 129"
		local tW, tH = surface.GetTextSize( text )
		local x = PunishmentsConfigDock:GetWide() - tW - 15*screenscale
		local y = PunishmentsConfigDock:GetTall() - tH - 80*screenscale
		surface.SetTextColor( AWarn.Colors.COLOR_LABEL_TEXT )
		surface.SetTextPos( x, y )
		surface.DrawText( text )
	end
	PunishmentsConfigDock:Dock( FILL )
	
	
	
	local optionLabel = vgui.Create( "awarn3_configlabel", ClientConfigDock )
	optionLabel:SetText( AWarn.Localization:GetTranslation( "clientoptions" ) )
	optionLabel:Dock( TOP )
	optionLabel:SetFont("AWarn3NavButton2")
	optionLabel:DockMargin( 0, 0, 0, 8 * screenscale )
	
	local hdiv = vgui.Create( "awarn3_hdiv", ClientConfigDock )
	hdiv:Dock( TOP )
	
	local optionLabel = vgui.Create( "awarn3_configlabel", ClientConfigDock )
	optionLabel:SetText( AWarn.Localization:GetTranslation( "colorcustomization" ) )
	optionLabel:DockMargin( 0, 10 * screenscale, 0, 0 )
	optionLabel:Dock( TOP )
	
	local ColorOptionsPanel = vgui.Create( "DPanel", ClientConfigDock )
	ColorOptionsPanel:DockPadding( 0, 0, 30 * screenscale, 0 )
	ColorOptionsPanel.Paint = function()
		--Render Invisible
		surface.SetDrawColor( 200, 200, 120, 0 )
		surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	end
	ColorOptionsPanel:SetHeight( 230 * screenscale )
	ColorOptionsPanel:Dock( TOP )
	ColorOptionsPanel:InvalidateParent( true )
		
	for k, v in SortedPairs( AWarn.Colors ) do
		if k == "Backup" then continue end
		local color_option = vgui.Create( "awarn3_coloroptioncard", ColorOptionsPanel )
		color_option:SetColor( AWarn.Colors[ k ] )
		color_option:SetText( k )
		color_option:SetOptionColor( k )
	end
	
	local hdiv = vgui.Create( "awarn3_hdiv", ClientConfigDock )
	hdiv:Dock( TOP )
	
	local optionLabel = vgui.Create( "awarn3_configlabel", ClientConfigDock )
	optionLabel:SetText( AWarn.Localization:GetTranslation( "languageconfiguration" ) )
	optionLabel:DockMargin( 0, 20 * screenscale, 0, 0 )
	optionLabel:Dock( TOP )
	
	local LanguageOptionsPanel = vgui.Create( "DPanel", ClientConfigDock )
	LanguageOptionsPanel:DockPadding( 0, 0, 30 * screenscale, 0 )
	LanguageOptionsPanel.Paint = function()
		--Render Invisible
		surface.SetDrawColor( 200, 200, 120, 0 )
		surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	end
	LanguageOptionsPanel:SetHeight( 20 * screenscale )
	LanguageOptionsPanel:Dock( TOP )
	LanguageOptionsPanel:InvalidateParent( true )
	
	local comboBox = vgui.Create( "DComboBox", LanguageOptionsPanel )
	comboBox:SetWidth( 60 * screenscale )
	comboBox:SetValue( AWarn.SelectedLanguage or "EN-US")
	
	for k, v in pairs( AWarn.Localization.Languages ) do
		comboBox:AddChoice( AWarn.Localization.LangCodes[k], k )
	end
	comboBox:Dock( RIGHT )	
	function comboBox:OnSelect( index, text, data )
		AWarn.SelectedLanguage = data
		comboBox:SetValue( data )
		LocalPlayer():SetPData( "awarn3_lang", data )
	end
	comboBox:Dock( RIGHT )
	
	local languageLabel = vgui.Create( "awarn3_configlabel", LanguageOptionsPanel )
	languageLabel:SetText( AWarn.Localization:GetTranslation( "selectlanguage" ) )
	languageLabel:SetFont( "AWarn3Label2" )
	languageLabel:Dock( FILL )
	languageLabel:SetWidth( 100 )	
	
	
	local optionLabel = vgui.Create( "awarn3_configlabel", ServerConfigDock )
	optionLabel:SetText( AWarn.Localization:GetTranslation( "serveroptions" ) )
	optionLabel:Dock( TOP )
	optionLabel:SetFont("AWarn3NavButton2")
	optionLabel:DockMargin( 0, 0, 0, 8 * screenscale )
	
	local hdiv = vgui.Create( "awarn3_hdiv", ServerConfigDock )
	hdiv:Dock( TOP )
	
	local optionButtonsContainer = vgui.Create( "DPanel", ServerConfigDock )
	optionButtonsContainer:SetHeight( 400 * screenscale )
	optionButtonsContainer:DockPadding( 10 * screenscale, 15 * screenscale, 10 * screenscale, 10 * screenscale )
	optionButtonsContainer:Dock( FILL )
	optionButtonsContainer.Paint = function()
		--Render Invisible
		surface.SetDrawColor( 200, 200, 120, 0 )
		surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )	
	end
	
	local dCheckBoxKick = vgui.Create( "DCheckBoxLabel", optionButtonsContainer )
	dCheckBoxKick:SetText( AWarn.Localization:GetTranslation( "enablekickpunish" ) )
	dCheckBoxKick:DockMargin( 0, 0, 0, 4 * screenscale )
	dCheckBoxKick:Dock( TOP )
	dCheckBoxKick:SizeToContents()
	dCheckBoxKick.OptionString = "awarn_kick"
	function dCheckBoxKick:OnChange( val )
		AWarn:SendOptionUpdate( dCheckBoxKick.OptionString, val )
	end
	
	local dCheckBoxBan = vgui.Create( "DCheckBoxLabel", optionButtonsContainer )
	dCheckBoxBan:SetText( AWarn.Localization:GetTranslation( "enablebanpunish" ) )
	dCheckBoxBan:DockMargin( 0, 0, 0, 4 * screenscale )
	dCheckBoxBan:Dock( TOP )
	dCheckBoxBan:SizeToContents()
	dCheckBoxBan.OptionString = "awarn_ban"
	function dCheckBoxBan:OnChange( val )
		AWarn:SendOptionUpdate( dCheckBoxBan.OptionString, val )
	end
	
	local dCheckBoxDecay = vgui.Create( "DCheckBoxLabel", optionButtonsContainer )
	dCheckBoxDecay:SetText( AWarn.Localization:GetTranslation( "enabledecay" ) )
	dCheckBoxDecay:DockMargin( 0, 0, 0, 4 * screenscale )
	dCheckBoxDecay:Dock( TOP )
	dCheckBoxDecay:SizeToContents()
	dCheckBoxDecay.OptionString = "awarn_decay"
	function dCheckBoxDecay:OnChange( val )
		AWarn:SendOptionUpdate( dCheckBoxDecay.OptionString, val )
	end
	
	local dCheckBoxReasonReq = vgui.Create( "DCheckBoxLabel", optionButtonsContainer )
	dCheckBoxReasonReq:SetText( AWarn.Localization:GetTranslation( "reasonrequired" ) )
	dCheckBoxReasonReq:DockMargin( 0, 0, 0, 4 * screenscale )
	dCheckBoxReasonReq:Dock( TOP )
	dCheckBoxReasonReq:SizeToContents()
	dCheckBoxReasonReq.OptionString = "awarn_reasonrequired"
	function dCheckBoxReasonReq:OnChange( val )
		AWarn:SendOptionUpdate( dCheckBoxReasonReq.OptionString, val )
	end
	
	local dCheckBoxBanWarnReset = vgui.Create( "DCheckBoxLabel", optionButtonsContainer )
	dCheckBoxBanWarnReset:SetText( AWarn.Localization:GetTranslation( "resetafterban" ) )
	dCheckBoxBanWarnReset:DockMargin( 0, 0, 0, 4 * screenscale )
	dCheckBoxBanWarnReset:Dock( TOP )
	dCheckBoxBanWarnReset:SizeToContents()
	dCheckBoxBanWarnReset.OptionString = "awarn_reset_after_ban"
	function dCheckBoxBanWarnReset:OnChange( val )
		AWarn:SendOptionUpdate( dCheckBoxBanWarnReset.OptionString, val )
	end
	
	--[[
	local dCheckBoxLoggingEnabled = vgui.Create( "DCheckBoxLabel", optionButtonsContainer )
	dCheckBoxLoggingEnabled:SetText( "Log Warning Events" )
	dCheckBoxLoggingEnabled:DockMargin( 0, 0, 0, 4 * screenscale )
	dCheckBoxLoggingEnabled:Dock( TOP )
	dCheckBoxLoggingEnabled:SizeToContents()
	dCheckBoxLoggingEnabled.OptionString = "awarn_logging"
	function dCheckBoxLoggingEnabled:OnChange( val )
		AWarn:SendOptionUpdate( dCheckBoxLoggingEnabled.OptionString, val )
	end
	]]
	
	local dCheckBoxWarnAdmins = vgui.Create( "DCheckBoxLabel", optionButtonsContainer )
	dCheckBoxWarnAdmins:SetText( AWarn.Localization:GetTranslation( "allowwarnadmins" ) )
	dCheckBoxWarnAdmins:DockMargin( 0, 0, 0, 4 * screenscale )
	dCheckBoxWarnAdmins:Dock( TOP )
	dCheckBoxWarnAdmins:SizeToContents()
	dCheckBoxWarnAdmins.OptionString = "awarn_allow_warn_admins"
	function dCheckBoxWarnAdmins:OnChange( val )
		AWarn:SendOptionUpdate( dCheckBoxWarnAdmins.OptionString, val )
	end
	
	
	local ChatPrefixContainer = vgui.Create( "DPanel", optionButtonsContainer )
	ChatPrefixContainer:DockMargin( 0, 15 * screenscale, 0, 0 )
	ChatPrefixContainer.Paint = function()
		--Render Invisible
		surface.SetDrawColor( 200, 200, 120, 0 )
		surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
		
		if ChatPrefixContainer.isEditing then
			surface.SetFont( "AWarn3CardText1" )
			local tW, tH = surface.GetTextSize( AWarn.Localization:GetTranslation( "pressenter" ) )
			local x = 76 * screenscale
			local y = 35 * screenscale
			surface.SetTextColor( AWarn.Colors.COLOR_LABEL_VALUE_TEXT )
			surface.SetTextPos( x, y )
			surface.DrawText( AWarn.Localization:GetTranslation( "pressenter" ) )
		end
	end
	ChatPrefixContainer.isEditing = false
	ChatPrefixContainer:SetHeight( 70 * screenscale )
	ChatPrefixContainer:Dock( TOP )
	ChatPrefixContainer:InvalidateParent( true )
	
	local chatPrefixLabel = vgui.Create( "awarn3_configlabel", ChatPrefixContainer )
	chatPrefixLabel:SetText( AWarn.Localization:GetTranslation( "chatprefix" ) .. ": " )
	chatPrefixLabel:SetFont( "AWarn3Label2" )
	chatPrefixLabel:Dock( TOP )
	chatPrefixLabel.align = "left"
	
	local dTextEntryChatPrefix = vgui.Create( "DTextEntry", ChatPrefixContainer )
	dTextEntryChatPrefix:Dock( TOP )
	dTextEntryChatPrefix:InvalidateParent( true )
	dTextEntryChatPrefix:DockMargin( 0, 0, 175 * screenscale, 20 * screenscale )
	dTextEntryChatPrefix:SetFont( "AWarn3CardText1" )
	dTextEntryChatPrefix:SetUpdateOnType( true )
	dTextEntryChatPrefix.OptionString = "awarn_chat_prefix"
	dTextEntryChatPrefix.OnEnter = function()
		dTextEntryChatPrefix:SetTextColor( Color( 0, 200, 0, 255 ) )
		ChatPrefixContainer.isEditing = false
		dTextEntryChatPrefix:SetValue( dTextEntryChatPrefix:GetValue():gsub( " ", "" ) )
		AWarn:SendOptionUpdate( dTextEntryChatPrefix.OptionString, dTextEntryChatPrefix:GetValue():gsub( " ", "" ) )
	end
	function dTextEntryChatPrefix:OnValueChange( val )
		if self:IsEditing() then
			self:SetTextColor( Color( 200, 100, 100, 255 ) )
			ChatPrefixContainer.isEditing = true
		end
	end
	
	
	local WarningDecayTimeContainer = vgui.Create( "DPanel", optionButtonsContainer )
	WarningDecayTimeContainer:DockMargin( 0, 8 * screenscale, 0, 0 )
	WarningDecayTimeContainer.Paint = function()
		--Render Invisible
		surface.SetDrawColor( 200, 200, 120, 0 )
		surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
		
		if WarningDecayTimeContainer.isEditing then
			surface.SetFont( "AWarn3CardText1" )
			local tW, tH = surface.GetTextSize( AWarn.Localization:GetTranslation( "pressenter" ) )
			local x = 76 * screenscale
			local y = 35 * screenscale
			surface.SetTextColor( AWarn.Colors.COLOR_LABEL_VALUE_TEXT )
			surface.SetTextPos( x, y )
			surface.DrawText( AWarn.Localization:GetTranslation( "pressenter" ) )
		end
	end
	WarningDecayTimeContainer.isEditing = false
	WarningDecayTimeContainer:SetHeight( 70 * screenscale )
	WarningDecayTimeContainer:Dock( TOP )
	WarningDecayTimeContainer:InvalidateParent( true )
	
	local WarningDecayTimeLabel = vgui.Create( "awarn3_configlabel", WarningDecayTimeContainer )
	WarningDecayTimeLabel:SetText( AWarn.Localization:GetTranslation( "warningdecayrate" ) .. ": " )
	WarningDecayTimeLabel:SetFont( "AWarn3Label2" )
	WarningDecayTimeLabel:Dock( TOP )
	WarningDecayTimeLabel.align = "left"
	
	local dTextEntryWarningDecayTime = vgui.Create( "DTextEntry", WarningDecayTimeContainer )
	dTextEntryWarningDecayTime:Dock( TOP )
	dTextEntryWarningDecayTime:DockMargin( 0, 0, 175 * screenscale, 20 * screenscale )
	dTextEntryWarningDecayTime:SetFont( "AWarn3CardText1" )
	dTextEntryWarningDecayTime:SetUpdateOnType( true )
	dTextEntryWarningDecayTime:SetNumeric( true )
	dTextEntryWarningDecayTime.OptionString = "awarn_decayrate"
	dTextEntryWarningDecayTime.OnEnter = function()
		dTextEntryWarningDecayTime:SetTextColor( Color( 0, 200, 0, 255 ) )
		WarningDecayTimeContainer.isEditing = false
		AWarn:SendOptionUpdate( dTextEntryWarningDecayTime.OptionString, dTextEntryWarningDecayTime:GetValue() )
	end
	function dTextEntryWarningDecayTime:OnValueChange( val )
		if self:IsEditing() then
			self:SetTextColor( Color( 200, 100, 100, 255 ) )
			WarningDecayTimeContainer.isEditing = true
		end
	end
	
	
	
	
	local ServerNameContainer = vgui.Create( "DPanel", optionButtonsContainer )
	ServerNameContainer:DockMargin( 0, 8 * screenscale, 0, 0 )
	ServerNameContainer.Paint = function()
		--Render Invisible
		surface.SetDrawColor( 200, 200, 120, 0 )
		surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
		
		if ServerNameContainer.isEditing then
			surface.SetFont( "AWarn3CardText1" )
			local tW, tH = surface.GetTextSize( AWarn.Localization:GetTranslation( "entertosave" ) )
			local x = 136 * screenscale
			local y = 35 * screenscale
			surface.SetTextColor( AWarn.Colors.COLOR_LABEL_VALUE_TEXT )
			surface.SetTextPos( x, y )
			surface.DrawText( AWarn.Localization:GetTranslation( "entertosave" ) )
		end
	end
	ServerNameContainer.isEditing = false
	ServerNameContainer:SetHeight( 70 * screenscale )
	ServerNameContainer:Dock( TOP )
	ServerNameContainer:InvalidateParent( true )
	
	local ServerNameLabel = vgui.Create( "awarn3_configlabel", ServerNameContainer )
	ServerNameLabel:SetText( AWarn.Localization:GetTranslation( "servername" ) .. ": " )
	ServerNameLabel:SetFont( "AWarn3Label2" )
	ServerNameLabel:Dock( TOP )
	ServerNameLabel.align = "left"
	
	local dTextEntryServerName = vgui.Create( "DTextEntry", ServerNameContainer )
	dTextEntryServerName:Dock( TOP )
	dTextEntryServerName:DockMargin( 0, 0, 115 * screenscale, 20 * screenscale )
	dTextEntryServerName:SetFont( "AWarn3CardText1" )
	dTextEntryServerName:SetUpdateOnType( true )
	dTextEntryServerName.OptionString = "awarn_server_name"
	dTextEntryServerName.OnEnter = function()
		dTextEntryServerName:SetTextColor( Color( 0, 200, 0, 255 ) )
		ServerNameContainer.isEditing = false
		AWarn:SendOptionUpdate( dTextEntryServerName.OptionString, dTextEntryServerName:GetValue() )
	end
	function dTextEntryServerName:OnValueChange( val )
		if self:IsEditing() then
			self:SetTextColor( Color( 200, 100, 100, 255 ) )
			ServerNameContainer.isEditing = true
		end
	end
	
	local ServerLanguageLabel = vgui.Create( "awarn3_configlabel", optionButtonsContainer )
	ServerLanguageLabel:SetText( AWarn.Localization:GetTranslation( "serverlanguage" ) )
	ServerLanguageLabel:DockMargin( 0, 20 * screenscale, 0, 0 )
	ServerLanguageLabel:SetFont( "AWarn3Label2" )
	ServerLanguageLabel:Dock( TOP )
	ServerLanguageLabel.align = "left"
		
	local ServerLanguageOptionsPanel = vgui.Create( "DPanel", optionButtonsContainer )
	ServerLanguageOptionsPanel:DockPadding( 0, 0, 30 * screenscale, 0 )
	ServerLanguageOptionsPanel.Paint = function()
		--Render Invisible
		surface.SetDrawColor( 200, 200, 120, 0 )
		surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	end
	ServerLanguageOptionsPanel:SetHeight( 20 * screenscale )
	ServerLanguageOptionsPanel:Dock( TOP )
	ServerLanguageOptionsPanel:InvalidateParent( true )
	
	local comboBoxServerLang = vgui.Create( "DComboBox", ServerLanguageOptionsPanel )
	comboBoxServerLang:SetWidth( 60 * screenscale )
	comboBoxServerLang:SetValue( "EN-US" )
	for k, v in pairs( AWarn.Localization.Languages ) do
		comboBoxServerLang:AddChoice( AWarn.Localization.LangCodes[k], k )
	end
	comboBoxServerLang:Dock( RIGHT )
	comboBoxServerLang.OptionString = "awarn_server_language"
	
	function comboBoxServerLang:OnSelect( index, text, data )
		AWarn:SendOptionUpdate( comboBoxServerLang.OptionString, data )
	end
	
	local languageLabel = vgui.Create( "awarn3_configlabel", ServerLanguageOptionsPanel )
	languageLabel:SetText( AWarn.Localization:GetTranslation( "selectlanguage" ) )
	languageLabel:SetFont( "AWarn3Label2" )
	languageLabel:Dock( FILL )
	languageLabel:SetWidth( 100 )
	
	function AWarn:RefreshSettings()
		dCheckBoxKick:SetChecked( AWarn.Options.awarn_kick.value )
		dCheckBoxBan:SetChecked( AWarn.Options.awarn_ban.value )
		dCheckBoxDecay:SetChecked( AWarn.Options.awarn_decay.value )
		dCheckBoxReasonReq:SetChecked( AWarn.Options.awarn_reasonrequired.value )
		dCheckBoxBanWarnReset:SetChecked( AWarn.Options.awarn_reset_after_ban.value )
		--dCheckBoxLoggingEnabled:SetChecked( AWarn.Options.awarn_logging.value )
		dCheckBoxWarnAdmins:SetChecked( AWarn.Options.awarn_allow_warn_admins.value )
		dTextEntryChatPrefix:SetValue( AWarn.Options.awarn_chat_prefix.value )
		dTextEntryWarningDecayTime:SetValue( AWarn.Options.awarn_decayrate.value )
		comboBoxServerLang:SetValue( AWarn.Options.awarn_server_language.value )
		dTextEntryServerName:SetValue( AWarn.Options.awarn_server_name.value )
	end
	
	function AWarn:RemoveSettings()
		ServerConfigDock:Remove()
		PunishmentsConfigDock:Remove()
	end
	
	
	
	
	
	
	local punishmentsLabel = vgui.Create( "awarn3_configlabel", PunishmentsConfigDock )
	punishmentsLabel:SetText( AWarn.Localization:GetTranslation( "punishmentsconfiguration" ) )
	punishmentsLabel:Dock( TOP )
	punishmentsLabel:SetFont("AWarn3NavButton2")
	punishmentsLabel:DockMargin( 0, 0, 0, 8 * screenscale )
	
	local hdiv = vgui.Create( "awarn3_hdiv", PunishmentsConfigDock )
	hdiv:Dock( TOP )
	
	AWarn.menu.configurationview.PunishmentsCardsPanel = vgui.Create( "DScrollPanel", PunishmentsConfigDock )
	AWarn.menu.configurationview.PunishmentsCardsPanel:SetHeight( 300 * screenscale )
	AWarn.menu.configurationview.PunishmentsCardsPanel:Dock( TOP )
	AWarn.menu.configurationview.PunishmentsCardsPanel:DockMargin( 8 * screenscale, 0, 8 * screenscale, 2 * screenscale )
	AWarn.menu.configurationview.PunishmentsCardsPanel:GetCanvas():DockPadding( 0, 0, 0, 6 * screenscale )
	AWarn.menu.configurationview.PunishmentsCardsPanel.Paint = function()
		surface.SetDrawColor( 200, 100, 200, 0 )
		surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	end
		
	local ScrollBar = AWarn.menu.configurationview.PunishmentsCardsPanel:GetVBar()
	ScrollBar:SetHideButtons( true )
	ScrollBar:SetWidth( 6 * screenscale )
	function ScrollBar:Paint( w, h )
		surface.SetDrawColor( 0, 0, 0, 100 )
		surface.DrawRect( 0, 0, w, h )
	end
	function ScrollBar.btnGrip:Paint( w, h )
		surface.SetDrawColor( AWarn.Colors.COLOR_SELECTED )
		surface.DrawRect( 0, 0, w, h )
	end
	
	local buttonDock = vgui.Create( "DPanel", PunishmentsConfigDock )
	buttonDock:SetHeight( 100 )
	buttonDock:Dock( TOP )
	buttonDock:DockMargin( 8 * screenscale, 0, 8 * screenscale, 0 )
	buttonDock.Paint = function()
		surface.SetDrawColor( 200, 200, 200, 0 )
		surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	end
		
	local dockmargin = 6 * screenscale
	local addPunishmentButton = vgui.Create( "awarn3_button", buttonDock )
	addPunishmentButton:SetText(AWarn.Localization:GetTranslation( "addpunishment" ))
	addPunishmentButton:Dock( TOP )
	addPunishmentButton:DockMargin( dockmargin, dockmargin, dockmargin, 0 )
	addPunishmentButton.OnSelected = function()
		if IsValid( AWarn.menu.addpunishmentdialog ) then AWarn.menu.addpunishmentdialog:Remove() end
		AWarn.menu.addpunishmentdialog = vgui.Create( "awarn3_addpunishmentdialog" )
		AWarn.menu.addpunishmentdialog:MakePopup()
		AWarn.menu.addpunishmentdialog:SetParent( AWarn.menu )
	end
end
vgui.Register( "awarn3_configurationview", PANEL, "DFrame" )

function AWarn:CreatePunishmentCard( tblInfo )
	local searchPlayerCard = vgui.Create( "awarn3_punishmentcard" )
	AWarn.menu.configurationview.PunishmentsCardsPanel:AddItem( searchPlayerCard )
	searchPlayerCard:SetInfo( tblInfo )
	searchPlayerCard:Dock( TOP )
	local cardNum = #AWarn.menu.configurationview.PunishmentsCardsPanel:GetCanvas():GetChildren()
	AWarn.menu.configurationview.PunishmentsCardsPanel:SetHeight( math.Clamp( ( 60 * screenscale ) * cardNum, 100, 300 ) )
	searchPlayerCard:DrawElements()
end

function AWarn:RefreshPunishments()
	AWarn.menu.configurationview.PunishmentsCardsPanel:Clear()
	for k, v in SortedPairs( AWarn.Punishments ) do
		AWarn:CreatePunishmentCard( v )
	end
end

local PANEL = {}
function PANEL:Init()
	local dockMargin = 4 * screenscale
	self:DockMargin( dockMargin, dockMargin, dockMargin, 0 )
	self:SetHeight( 55 * screenscale )
	self:Dock( TOP )
	
	self.hovered = false
	
	self.start = RealTime()
	self.stop = RealTime() + 0.1
	self.animating = true

	self.wNum = 0
	self.pType = "NULL"
	self.pLength = 0
	self.pMessage = ""
	self.sMessage = ""

end
function PANEL:SetInfo( tbl )
	self.wNum = tbl.warnings or 0
	self.pType = tbl.pType or "NULL"
	self.pLength = tbl.pLength or 0
	self.pMessage = tbl.pMessage or "NULL"
	self.sMessage = tbl.sMessage or "NULL"
	
	
	self:SetTooltip( ([[
	%s: %u     %s: %s     %s: %u
	%s: %s
	%s: %s]]):format(AWarn.Localization:GetTranslation( "warnings" ), self.wNum, AWarn.Localization:GetTranslation( "punishtype" ), self.pType, AWarn.Localization:GetTranslation( "punishlength" ), self.pLength, AWarn.Localization:GetTranslation( "playermessage" ), self.pMessage, AWarn.Localization:GetTranslation( "servermessage" ), self.sMessage) )
end
function PANEL:Paint()
	
	if self.hovered == true then
		surface.SetDrawColor( AWarn.Colors.COLOR_BUTTON_HOVERED )
	else
		surface.SetDrawColor( AWarn.Colors.COLOR_BUTTON )
	end
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	
		
	surface.SetFont( "AWarn3CardText2" )
	local text = AWarn.Localization:GetTranslation( "warnings" ) .. ":"
	local tW, tH = surface.GetTextSize( text )
	local x = 10 * screenscale
	local y = 6 * screenscale
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_TEXT )
	surface.SetTextPos( x, y )
	surface.DrawText( text )
		
	text = self.wNum 
	x = x + tW + 6 * screenscale
	y = y
	tW, tH = surface.GetTextSize( text )
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_VALUE_TEXT )
	surface.SetTextPos( x, y )
	surface.DrawText( text )
	
	
	text = AWarn.Localization:GetTranslation( "punishtype" ) .. ":"
	x = x + tW + 30 * screenscale
	y = y
	tW, tH = surface.GetTextSize( text )
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_TEXT )
	surface.SetTextPos( x, y )
	surface.DrawText( text )
		
	text = self.pType
	x = x + tW + 6 * screenscale
	y = y
	tW, tH = surface.GetTextSize( text )
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_VALUE_TEXT )
	surface.SetTextPos( x, y )
	surface.DrawText( text )
	

	text = AWarn.Localization:GetTranslation( "punishlength" ) .. ":"
	x = x + tW + 30 * screenscale
	y = y
	tW, tH = surface.GetTextSize( text )
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_TEXT )
	surface.SetTextPos( x, y )
	surface.DrawText( text )
		
	text = self.pLength
	x = x + tW + 6 * screenscale
	y = y
	tW, tH = surface.GetTextSize( text )
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_VALUE_TEXT )
	surface.SetTextPos( x, y )
	surface.DrawText( text )
	
				
	local text = AWarn.Localization:GetTranslation( "playermessage" ) .. ":"
	local x = 10 * screenscale
	local y = 22 * screenscale
	local tW, tH = surface.GetTextSize( text )
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_TEXT )
	surface.SetTextPos( x, y )
	surface.DrawText( text )
		
	text = self.pMessage
	x = x + tW + 6 * screenscale
	y = y
	tW, tH = surface.GetTextSize( text )
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_VALUE_TEXT )
	surface.SetTextPos( x, y )
	surface.DrawText( text )
	
			
	local text = AWarn.Localization:GetTranslation( "servermessage" ) .. ":"
	local x = 10 * screenscale
	local y = 38 * screenscale
	local tW, tH = surface.GetTextSize( text )
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_TEXT )
	surface.SetTextPos( x, y )
	surface.DrawText( text )
		
	text = self.sMessage
	x = x + tW + 6 * screenscale
	y = y
	tW, tH = surface.GetTextSize( text )
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_VALUE_TEXT )
	surface.SetTextPos( x, y )
	surface.DrawText( text )

end
function PANEL:Think()
	if self:IsHovered() and not self.hovered then
		self.hovered = true
	elseif self.hovered and not self:IsHovered() then
		self.hovered = false
	end
	self:AnimateThink()
end
function PANEL:AnimateThink()
	if not self.animating then return end
	if RealTime() < self.stop then
		local easingsX = easings.outCubic( RealTime() - self.start, 0, self:GetWide(), 0.1 )
		local x, y = self:GetPos()
		local easeAmt = ( easingsX * -1 ) + self:GetWide()
		self:SetPos( easeAmt, y )
	else
		local x, y = self:GetPos()
		self.animating = false
	end
end
function PANEL:DrawElements( pl )
	local deleteButton = vgui.Create( "awarn3_iconbutton", self )
	deleteButton:SetTooltip(AWarn.Localization:GetTranslation( "deletewarning" ))
	deleteButton:SetSize(8 * screenscale, 8 * screenscale)
	deleteButton:SetIcon( deleteImage )
	deleteButton:SetPos( self:GetParent():GetWide() - deleteButton:GetWide() - 14 * screenscale, 6 * screenscale )
	deleteButton:SetPos( 454 * screenscale, 4 * screenscale )
	deleteButton.OnSelected = function()
		AWarn.Punishments[ self.wNum ] = nil
		self:Remove()
		local cardNum = #AWarn.menu.configurationview.PunishmentsCardsPanel:GetCanvas():GetChildren()
		AWarn.menu.configurationview.PunishmentsCardsPanel:SetHeight( math.Clamp( ( 60 * screenscale ) * cardNum, 100, 300 ) )
		AWarn:SavePunishments()
	end
end
vgui.Register( "awarn3_punishmentcard", PANEL )

function AWarn:SavePunishments()
	net.Start( "awarn3_networkpunishments" )
	net.WriteString( "write" )
	net.WriteTable( AWarn.Punishments )
	net.SendToServer()
end


local PANEL = {}
function PANEL:Init()
	self.start = RealTime()
	self.stop = RealTime() + 0.5
	self.animating = true
	self:SetWide( ScrWM() * 0.25 )
	self:SetTall( ScrHM() * 0.28 )
	self.dX = ScrWM() / 2 - self:GetWide() / 2
	self.dY = ScrHM() / 2 - self:GetTall() / 2
	self:SetPos( ScrWM(), self.dY )
	self:DrawElements()
	self.animspeed = 30
	self:SetTitle( "" )
	self:ShowCloseButton( false )
	
	self.ptype = "kick"

end
function PANEL:Paint()
	surface.SetDrawColor( AWarn.Colors.COLOR_THEME_PRIMARY )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	
	surface.SetFont( "AWarn3Label2" )
	local text = AWarn.Localization:GetTranslation( "punishaddmenu" )
	local x = 12 * screenscale
	local y = 8 * screenscale
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_TEXT )
	surface.SetTextPos( x, y )
	surface.DrawText( text )
	
	surface.SetFont( "AWarn3CardText1" )
	
	local text = AWarn.Localization:GetTranslation( "warnings" ) .. ":"
	local x = 18 * screenscale
	local y = 35 * screenscale
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_TEXT )
	surface.SetTextPos( x, y )
	surface.DrawText( text )
	
	local text = AWarn.Localization:GetTranslation( "punishtype" ) .. ":"
	local x = 115 * screenscale
	local y = 35 * screenscale
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_TEXT )
	surface.SetTextPos( x, y )
	surface.DrawText( text )
	
	if self.ptype == "ban" then
		local text = AWarn.Localization:GetTranslation( "punishlength" ) .. ":"
		local x = 250 * screenscale
		local y = 35 * screenscale
		surface.SetTextColor( AWarn.Colors.COLOR_LABEL_TEXT )
		surface.SetTextPos( x, y )
		surface.DrawText( text )
		
		surface.SetFont( "AWarn3CardText2" )
		local text = "(" .. AWarn.Localization:GetTranslation( "inminutes" ) .. ")"
		local x = 318 * screenscale
		local y = 54 * screenscale
		surface.SetTextColor( AWarn.Colors.COLOR_LABEL_VALUE_TEXT )
		surface.SetTextPos( x, y )
		surface.DrawText( text )
		
		local text = AWarn.Localization:GetTranslation( "0equalperma" )
		local x = 312 * screenscale
		local y = 65 * screenscale
		surface.SetTextColor( AWarn.Colors.COLOR_LABEL_VALUE_TEXT )
		surface.SetTextPos( x, y )
		surface.DrawText( text )
		
		
		surface.SetFont( "AWarn3CardText1" )
		
	end
	
	local text = AWarn.Localization:GetTranslation( "messagetoplayer" ) .. ":"
	local x = 18 * screenscale
	local y = 85 * screenscale
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_TEXT )
	surface.SetTextPos( x, y )
	surface.DrawText( text )
	
	local text = AWarn.Localization:GetTranslation( "messagetoserver" ) .. ":"
	local x = 18 * screenscale
	local y = 130 * screenscale
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_TEXT )
	surface.SetTextPos( x, y )
	surface.DrawText( text )
	
	surface.SetFont( "AWarn3CardText2" )
	
	local text = AWarn.Localization:GetTranslation( "use%" ) .. ":"
	local x = 20 * screenscale
	local y = 172 * screenscale
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_VALUE_TEXT )
	surface.SetTextPos( x, y )
	surface.DrawText( text )
	
	surface.SetFont( "AWarn3CardText1" )
	
end
function PANEL:Think()
	if not self.animating then return end
	if RealTime() < self.stop then
		local easingsX = easings.outCubic( RealTime() - self.start, 0, self.dX + self:GetWide(), 0.5 )
		local x, y = self:GetPos()
		self:SetPos( ScrWM() + easingsX * -1, y )
	else
		local x, y = self:GetPos()
		self:SetPos( self.dX, y )
		self.animating = false
	end
end
function PANEL:DrawElements()
	local dockmargin = 6 * screenscale
		
	local closeButton = vgui.Create( "awarn3_iconbutton", self )
	closeButton:SetTooltip( AWarn.Localization:GetTranslation( "closemenu" ) )
	closeButton:SetSize(16 * screenscale, 16 * screenscale)
	closeButton:SetPos( self:GetWide() - closeButton:GetWide() - 6 * screenscale, 6 * screenscale )
	closeButton.OnSelected = function()
		self:Remove()
	end
	
	local x = 20 * screenscale
	
	local txtWarningNum = vgui.Create( "DTextEntry", self )
	txtWarningNum:SetPos( 20 * screenscale, 55 * screenscale)
	txtWarningNum:SetSize( 50 * screenscale, 20 * screenscale )
	txtWarningNum:SetText( "1" )
	txtWarningNum:SetNumeric( true )
	
	local comboBoxPunishType = vgui.Create( "DComboBox", self )
	comboBoxPunishType:SetPos( 117 * screenscale, 55 * screenscale )
	comboBoxPunishType:SetSize( 50 * screenscale, 20 * screenscale )
	comboBoxPunishType:SetValue( "Kick" )
	comboBoxPunishType:AddChoice( "Kick" )
	comboBoxPunishType:AddChoice( "Ban" )
	
	local txtPunishLen = vgui.Create( "DTextEntry", self )
	txtPunishLen:SetPos( 252 * screenscale, 55 * screenscale)
	txtPunishLen:SetSize( 50 * screenscale, 20 * screenscale )
	txtPunishLen:SetText( "1" )
	txtPunishLen:SetNumeric( true )
	txtPunishLen:SetVisible( false )
	comboBoxPunishType.OnSelect = function( self, index, value )
		if value == "Ban" then
			txtPunishLen:SetVisible( true )
			self:GetParent().ptype = "ban"
		else
			txtPunishLen:SetVisible( false )
			self:GetParent().ptype = "kick"
		end
	end
	
	local txtPlayerMessage = vgui.Create( "DTextEntry", self )
	txtPlayerMessage:SetPos( 20 * screenscale, 105 * screenscale)
	txtPlayerMessage:SetSize( self:GetWide() - 40, 20 * screenscale )
	
	local txtServerMessage = vgui.Create( "DTextEntry", self )
	txtServerMessage:SetPos( 20 * screenscale, 150 * screenscale)
	txtServerMessage:SetSize( self:GetWide() - 40, 20 * screenscale )
	
	
	local addPunishmentButton = vgui.Create( "awarn3_button", self )
	addPunishmentButton:SetText( AWarn.Localization:GetTranslation( "addpunishment" ) )
	addPunishmentButton:Dock( BOTTOM )
	addPunishmentButton:DockMargin( dockmargin, 0, dockmargin, dockmargin )
	addPunishmentButton.OnSelected = function()
		if txtPlayerMessage:GetValue() == "" or txtServerMessage:GetValue() == "" then return end
		AWarn.Punishments[ tonumber( txtWarningNum:GetValue() ) ] = { pType = comboBoxPunishType:GetValue():lower(), warnings = tonumber( txtWarningNum:GetValue() ), pMessage = txtPlayerMessage:GetValue(), sMessage = txtServerMessage:GetValue() }
		if comboBoxPunishType:GetValue() == "Ban" then
			AWarn.Punishments[ tonumber( txtWarningNum:GetValue() ) ].pLength = tonumber( txtPunishLen:GetValue() )
		end
		self:Remove()
		AWarn:RefreshPunishments()
		AWarn:SavePunishments()
	end
	
end
vgui.Register( "awarn3_addpunishmentdialog", PANEL, "DFrame" )


local PANEL = {}
function PANEL:Init()
	self.text = ""
	self:SetHeight( 30 )
	self.font = "AWarn3Label1"
	self.align = "center"
end
function PANEL:Paint()
	surface.SetFont( self.font )
	local tW, tH = surface.GetTextSize( self.text )
	local x = self:GetWide() / 2 - tW / 2
	if self.align == "left" then
		x = 4
	end
	local y = self:GetTall() / 2 - tH / 2
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_TEXT )
	surface.SetTextPos( x, y )
	surface.DrawText( self.text )
end
function PANEL:SetFont( font )
	self.font = font
end
function PANEL:SetText( txt )
	self.text = txt
end
vgui.Register( "awarn3_configlabel", PANEL )



local PANEL = {}
function PANEL:Init()
	self:SetHeight( 10 * screenscale )
end
function PANEL:Paint()
	--Render Invisible
	surface.SetDrawColor( AWarn.Colors.COLOR_THEME_PRIMARY )
	surface.DrawRect( 3 * screenscale, self:GetTall() / 2 - 1 * screenscale, self:GetWide() - 6 * screenscale, 2 * screenscale )
end
vgui.Register( "awarn3_hdiv", PANEL )


local PANEL = {}
function PANEL:Init()
	self:SetWidth( 2 * screenscale )
end
function PANEL:Paint()
	--Render Invisible
	surface.SetDrawColor( AWarn.Colors.COLOR_THEME_PRIMARY )
	surface.DrawRect( self:GetWide() / 2 - 1 * screenscale, 2 * screenscale, 2 * screenscale, self:GetTall() - 74 * screenscale )
end
vgui.Register( "awarn3_vdiv", PANEL )



local PANEL = {}
function PANEL:Init()
	self:SetHeight( 24 * screenscale )
	self:Dock( TOP )
	self.color = Color(255,255,255,255)
	self.text = "SAMPLE TEXT"
	self.optionColor = nil
	self:DrawElements()
end
function PANEL:Paint()
	--Render Invisible
	surface.SetDrawColor( 200, 100, 100, 0 )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	
	surface.SetFont( "AWarn3CardText1" )
	local tW, tH = surface.GetTextSize( self.text )
	local x = self:GetWide() - 28 * screenscale - tW
	local y = self:GetTall() / 2 - tH / 2
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_TEXT )
	surface.SetTextPos( x, y )
	surface.DrawText( self.text )
end
function PANEL:SetColor( col )
	self.color = col
	self.DColorButton:SetColor( self.color )
end
function PANEL:SetText( txt )
	self.text = txt .. ":"
end
function PANEL:SetOptionColor( oColor )
	self.optionColor = oColor
end
function PANEL:DrawElements()
	self:InvalidateParent( true )
	self.DColorButton = vgui.Create( "DColorButton", self )
	self.DColorButton:SetSize( 18 * screenscale, 18 * screenscale )
	self.DColorButton:SetPos( self:GetWide() - self.DColorButton:GetWide() - 3 * screenscale, 3 * screenscale )
	self.DColorButton:SetColor( self.color )
	function self.DColorButton:DoClick()
		if IsValid( AWarn.menu.playerwarndialogue ) then AWarn.menu.playerwarndialogue:Remove() end
		if IsValid( AWarn.menu.playersearch ) then AWarn.menu.playersearch:Remove() end
		if IsValid( AWarn.menu.colorpicker ) then AWarn.menu.colorpicker:Remove() end
		AWarn.menu.colorpicker = vgui.Create( "awarn3_colorpicker" )
		local x, y = input.GetCursorPos()
		AWarn.menu.colorpicker:SetPos( x + 20 * screenscale, y )
		AWarn.menu.colorpicker:MakePopup()
		AWarn.menu.colorpicker:SetParent( AWarn.menu )
		AWarn.menu.colorpicker:SetOptionColor( self:GetParent().optionColor )
		AWarn.menu.colorpicker:SetParentButton( self )
	end
end
function PANEL:Think()

end
vgui.Register( "awarn3_coloroptioncard", PANEL )



local PANEL = {}
function PANEL:Init()
	self.paused = true
	self.start = RealTime()
	self.stop = RealTime() + 0.5
	self.animating = true
	self:SetWide( 250 * screenscale )
	self:SetTall( 225 * screenscale )
	self:SetTitle( "" )
	self:ShowCloseButton( false )
	self.optionColor = nil
	self:DrawElements()
	self.parentbutton = nil
end
function PANEL:Paint()
	surface.SetDrawColor( AWarn.Colors.COLOR_THEME_PRIMARY )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
		
	surface.SetFont( "AWarn3Label1" )
	local text = AWarn.Localization:GetTranslation( "colorselection" ) 
	local tW, tH = surface.GetTextSize( text )
	local x = self:GetWide() / 2 - tW / 2
	local y = 6 * screenscale
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_TEXT )
	surface.SetTextPos( x, y )
	surface.DrawText( text )
end
function PANEL:SetOptionColor( col )
	self.optionColor = col
	self.Mixer:SetColor( AWarn.Colors[ col ] )
	self.paused = false
end
function PANEL:SetParentButton( pnl )
	self.parentbutton = pnl
end
function PANEL:Think()
	self:AnimatePanel()
	self:CheckClose()
end
function PANEL:CheckClose()
    if not input.IsMouseDown( MOUSE_LEFT ) then return end

    local x, y = self:GetPos()
    local mx, my = input.GetCursorPos()
    local w, h = self:GetSize()

    local minsX = x
    local maxsX = x + w
    local minsY = y
    local maxsY = y + h
	
    if mx < minsX or mx > maxsX then
        return self:Remove()
    end

    if my < minsY or my > maxsY then
        return self:Remove()
    end
end
function PANEL:AnimatePanel()
	if not self.animating then return end
	if RealTime() < self.stop then

	else
		self.animating = false
	end
end
function PANEL:DrawElements()
	local dockmargin = 6 * screenscale
	
	self.Mixer = vgui.Create( "DColorMixer", self )
	self.Mixer:Dock( TOP )
	self.Mixer:SetTall( 160 )
	self.Mixer:SetPalette( false )
	self.Mixer:SetAlphaBar( false )
	self.Mixer:SetWangs( true )
	self.Mixer:SetColor( Color( 30, 100, 160 ) )
	function self.Mixer:ValueChanged( col )
		if self:GetParent().paused then return end
		local nC = Color( col.r, col.g, col.b, AWarn.ColorsBackup[ self:GetParent().optionColor ].a )
		self:GetParent().parentbutton:SetColor( nC )
		AWarn.Colors[ self:GetParent().optionColor ] = nC
	end
		
	local warnButton = vgui.Create( "awarn3_button", self )
	warnButton:SetText( AWarn.Localization:GetTranslation( "setdefault" ) )
	warnButton:Dock( BOTTOM )
	warnButton:DockMargin( 0, 0, 0, 0 )
	warnButton:SetEnabled( true )
	warnButton.OnSelected = function()
		self.Mixer:SetColor( AWarn.ColorsBackup[ self.optionColor ] )
	end
end
vgui.Register( "awarn3_colorpicker", PANEL, "DFrame" )





local PANEL = {}
function PANEL:Init()
	self:Dock( FILL )
	self:DrawElements()
end
function PANEL:Paint()
	--Render Invisible
	surface.SetDrawColor( 200, 100, 100, 0 )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	
	surface.SetFont( "AWarn3Label1" )
	local text = AWarn.Localization:GetTranslation( "showingownwarnings" )
	local tW, tH = surface.GetTextSize( text )
	local x = self:GetWide() / 2 - tW / 2
	local y = 10 * screenscale
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_TEXT )
	surface.SetTextPos( x, y )
	surface.DrawText( text )
end
function PANEL:DrawElements()

	self.WarningCardsPanel = vgui.Create( "DScrollPanel", self )
	self.WarningCardsPanel:SetWide( 200 * screenscale )
	self.WarningCardsPanel:Dock( FILL )
	self.WarningCardsPanel:DockMargin( 8 * screenscale, 30 * screenscale, 8 * screenscale, 72 * screenscale )
	self.WarningCardsPanel:GetCanvas():DockPadding( 0, 0, 0, 6 * screenscale )
	self.WarningCardsPanel.Paint = function()
		surface.SetDrawColor( 200, 100, 200, 0 )
		surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	end
	
	local ScrollBar = self.WarningCardsPanel:GetVBar()
	ScrollBar:SetHideButtons( true )
	ScrollBar:SetWidth( 6 * screenscale )
	function ScrollBar:Paint( w, h )
		surface.SetDrawColor( 0, 0, 0, 100 )
		surface.DrawRect( 0, 0, w, h )
	end
	function ScrollBar.btnGrip:Paint( w, h )
		surface.SetDrawColor( AWarn.Colors.COLOR_SELECTED )
		surface.DrawRect( 0, 0, w, h )
	end
	
end
vgui.Register( "awarn3_selfwarningsview", PANEL )


function AWarn:AddSelfWarningCard( tbl )
	if not IsValid( self.menu ) then return end
	if not IsValid( self.menu.selfWarningsView ) then return end
	if not IsValid( self.menu.selfWarningsView.WarningCardsPanel ) then return end

	local warningCard = vgui.Create( "awarn3_selfwarningcard" )
	self.menu.selfWarningsView.WarningCardsPanel:AddItem( warningCard )
	warningCard:Dock( TOP )
	warningCard:SetInfo( tbl )
	
end

net.Receive( "awarn3_requestownwarnings", function()
	local warningsTable = net.ReadTable()
	AWarn:PopulateOwnWarnings( warningsTable )	
end )

function AWarn:PopulateOwnWarnings( tbl )

	if not IsValid( self.menu ) then return end
	if not IsValid( self.menu.selfWarningsView ) then return end
	if not IsValid( self.menu.selfWarningsView.WarningCardsPanel ) then return end
	self.menu.selfWarningsView.WarningCardsPanel:Clear()
	
	for k, v in pairs( tbl ) do
		timer.Simple( k * 0.1, function()
			AWarn:AddSelfWarningCard( v )
		end )
	end

end

function AWarn:RequestOwnWarnings()
	net.Start("awarn3_requestownwarnings")
	net.SendToServer()
end


local PANEL = {}
function PANEL:Init()
	local dockMargin = 4 * screenscale
	self:DockMargin( dockMargin, dockMargin, dockMargin, 0 )
	self:SetHeight( 60 * screenscale )
	self:Dock( TOP )
	self.hovered = false
	self.buttonEnabled = false
	self.warninginfotbl = {}
	
	self.start = RealTime()
	self.stop = RealTime() + 0.25
	self.animating = true
	
	self.dX, self.dY = self:GetPos()
end
function PANEL:Paint()
	
	if self.hovered == true then
		surface.SetDrawColor( AWarn.Colors.COLOR_BUTTON_HOVERED )
	else
		surface.SetDrawColor( AWarn.Colors.COLOR_BUTTON )
	end
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	
	if self.buttonEnabled then
		surface.SetDrawColor( AWarn.Colors.COLOR_SELECTED )
		surface.DrawRect( self:GetWide() - 10 * screenscale, 0, 8 * screenscale, self:GetTall() )
	end
		
	surface.SetFont( "AWarn3CardText1" )
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_TEXT )
	
	local x = 110 * screenscale
	
	local text = AWarn.Localization:GetTranslation( "warnedby" ) .. ":"
	local tW, tH = surface.GetTextSize( text )
	surface.SetTextPos( x - tW, 6 * screenscale )
	surface.DrawText( text )
	
	local text = AWarn.Localization:GetTranslation( "warningserver" ) .. ":"
	local tW, tH = surface.GetTextSize( text )
	surface.SetTextPos( x - tW, 22 * screenscale )
	surface.DrawText( text )	
	
	local text = AWarn.Localization:GetTranslation( "warningreason" ) .. ":"
	local tW, tH = surface.GetTextSize( text )
	surface.SetTextPos( x - tW, 38 * screenscale )
	surface.DrawText( text )
	
	local x = 600 * screenscale
	
	local text = AWarn.Localization:GetTranslation( "warningdate" ) .. ":"
	local tW, tH = surface.GetTextSize( text )
	surface.SetTextPos( x - tW, 6 * screenscale )
	surface.DrawText( text )	
	
	
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_VALUE_TEXT )
	
	local x = 115 * screenscale
	
	local text = self.warninginfotbl.PlayerName or AWarn.Localization:GetTranslation( "nothing" )
	surface.SetTextPos( x , 6 * screenscale )
	surface.DrawText( text )	
	
	local text = self.warninginfotbl.WarningServer or AWarn.Localization:GetTranslation( "nothing" )
	surface.SetTextPos( x , 22 * screenscale )
	surface.DrawText( text )	
	
	local text = self.warninginfotbl.WarningReason or AWarn.Localization:GetTranslation( "nothing" )
	surface.SetTextPos( x , 38 * screenscale )
	surface.DrawText( text )
	
	local x = 605 * screenscale
	
	local text = os.date( "%d/%m/%Y %H:%M:%S" , self.warninginfotbl.WarningDate or 111111111 )
	surface.SetTextPos( x , 6 * screenscale )
	surface.DrawText( text )
	
	
end
function PANEL:SetEnabled( bool )
	self.buttonEnabled = bool
end
function PANEL:SetInfo( tbl )
	self.warninginfotbl = tbl
end
function PANEL:Think()
	if self:IsHovered() and not self.hovered then
		self.hovered = true
	elseif self.hovered and not self:IsHovered() then
		self.hovered = false
	end
	self:AnimateThink()
end
function PANEL:AnimateThink()
	if not self.animating then return end
	if RealTime() < self.stop then
		local easingsX = easings.outCubic( RealTime() - self.start, 0, self:GetWide(), 0.25 )
		local x, y = self:GetPos()
		local easeAmt = ( easingsX * -1 ) + self:GetWide()
		self:SetPos( easeAmt, y )
	else
		local x, y = self:GetPos()
		self.animating = false
	end
end
vgui.Register( "awarn3_selfwarningcard", PANEL )









local PANEL = {}
function PANEL:Init()
	self:Dock( FILL )
	self:DrawElements()
	self.selectedplayer = nil
	self.selectedplayerid = nil
	self.selectedplayerwarns = 0
end
function PANEL:Paint()
	--Render Invisible
	surface.SetDrawColor( 200, 100, 100, 0 )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )


	surface.SetDrawColor( AWarn.Colors.COLOR_THEME_PRIMARY )
	surface.DrawRect( self:GetWide() - 205 * screenscale, 2 * screenscale, 2, self:GetTall() - 74 * screenscale )
	
	
	surface.SetFont( "AWarn3Label2" )
	local tW, tH = surface.GetTextSize( AWarn.Localization:GetTranslation( "connectedplayers" ) )
	local x = self:GetWide() - ( 200 * screenscale / 2 ) - tW / 2
	local y = 8 * screenscale
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_TEXT )
	surface.SetTextPos( x, y )
	surface.DrawText( AWarn.Localization:GetTranslation( "connectedplayers" ) )
	
	if self.selectedplayer then
		local text = AWarn.Localization:GetTranslation( "displaywarningsfor" ) .. ":"
		local tW, tH = surface.GetTextSize( text )
		local x = tW + 10 * screenscale
		surface.SetTextPos( x - tW, y )
		surface.DrawText( text )
		
		surface.SetTextColor( AWarn.Colors.COLOR_LABEL_VALUE_TEXT )
		x = x + ( 5 * screenscale )
		local text = self.selectedplayer
		local tW, tH = surface.GetTextSize( text )
		surface.SetTextPos( x, y )
		surface.DrawText( text )
			
		surface.SetTextColor( AWarn.Colors.COLOR_LABEL_TEXT )
		local x = 660 * screenscale
		local text = AWarn.Localization:GetTranslation( "activewarnings" ) .. ":"
		local tW, tH = surface.GetTextSize( text )
		surface.SetTextPos( x - tW, y )
		surface.DrawText( text )
		
		surface.SetTextColor( AWarn.Colors.COLOR_LABEL_VALUE_TEXT )
		local x = 665 * screenscale
		local text = self.selectedplayerwarns
		local tW, tH = surface.GetTextSize( text )
		surface.SetTextPos( x, y )
		surface.DrawText( text )
		
		if AWarn.menu.adminWarningsView.WarningCardsPanel:GetCanvas():ChildCount() == 0 then
			surface.SetTextColor( AWarn.Colors.COLOR_LABEL_TEXT )
			surface.SetFont( "AWarn3Label1" )
			y = self:GetTall() / 2 - 100 * screenscale
			local text = AWarn.Localization:GetTranslation( "selectedplayernowarnings" )
			local tW, tH = surface.GetTextSize( text )
			local x = self:GetWide() / 2 - 100 * screenscale
			surface.SetTextPos( x - tW / 2, y )
			surface.DrawText( text )
		end
	else
		surface.SetTextColor( AWarn.Colors.COLOR_LABEL_TEXT )
		surface.SetFont( "AWarn3Label1" )
		y = self:GetTall() / 2 - 100 * screenscale
		local text = AWarn.Localization:GetTranslation( "selectplayerseewarnings" )
		local tW, tH = surface.GetTextSize( text )
		local x = self:GetWide() / 2 - 100 * screenscale
		surface.SetTextPos( x - tW / 2, y )
		surface.DrawText( text )
	end
	
	
end
function PANEL:DrawElements()


	local PlayerListDockPanel = vgui.Create( "DPanel", self )
	PlayerListDockPanel:SetWide( 200 * screenscale )
	PlayerListDockPanel:Dock( RIGHT )
	PlayerListDockPanel:DockMargin( 0, 30 * screenscale, 0, 72 * screenscale )
	PlayerListDockPanel.Paint = function()
		surface.SetDrawColor( 200, 100, 100, 0 )
		surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	end

	self.PlayerListPanel = vgui.Create( "DScrollPanel", PlayerListDockPanel )
	self.PlayerListPanel:Dock( FILL )
	self.PlayerListPanel:DockMargin( 0, 0, 0, 10 * screenscale )
	self.PlayerListPanel:GetCanvas():DockPadding( 0, 0, 0, 6 * screenscale )
	self.PlayerListPanel.Paint = function()
		surface.SetDrawColor( 200, 200, 200, 0 )
		surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	end
	
	local warnButton = vgui.Create( "awarn3_button", PlayerListDockPanel )
	warnButton:SetText(AWarn.Localization:GetTranslation( "warnplayer" ))
	warnButton:Dock( BOTTOM )
	warnButton.buttoncoloroverride = Color( 120, 0, 0, 200 )
	warnButton.buttoncolorhoveroverride = Color( 140, 20, 20, 200 )
	warnButton:SetEnabled( false )
	warnButton.PostThink = function()
		if not warnButton.enabled then 
			if self.selectedplayer then warnButton:SetEnabled( true ) end
		end
	end
	warnButton.OnSelected = function()
		if IsValid( AWarn.menu.playerwarndialogue ) then AWarn.menu.playerwarndialogue:Remove() end
		AWarn.menu.playerwarndialogue = vgui.Create( "awarn3_warndialogue" )
		AWarn.menu.playerwarndialogue:MakePopup()
		AWarn.menu.playerwarndialogue:SetParent( AWarn.menu )
		AWarn.menu.playerwarndialogue:SetPlayer( self.selectedplayerid )
	end
	
	timer.Simple( 0, function() AWarn:PopulatePlayers() end ) --This needs to run in the next frame.
	
	local ScrollBar = self.PlayerListPanel:GetVBar()
	ScrollBar:SetHideButtons( true )
	ScrollBar:SetWidth( 6 * screenscale )
	function ScrollBar:Paint( w, h )
		surface.SetDrawColor( 0, 0, 0, 100 )
		surface.DrawRect( 0, 0, w, h )
	end
	function ScrollBar.btnGrip:Paint( w, h )
		surface.SetDrawColor( AWarn.Colors.COLOR_SELECTED )
		surface.DrawRect( 0, 0, w, h )
	end
	
	self.WarningCardsPanel = vgui.Create( "DScrollPanel", self )
	self.WarningCardsPanel:SetWide( 200 * screenscale )
	self.WarningCardsPanel:Dock( FILL )
	self.WarningCardsPanel:DockMargin( 0, 30 * screenscale, 8 * screenscale, 72 * screenscale )
	self.WarningCardsPanel:GetCanvas():DockPadding( 0, 0, 0, 6 * screenscale )
	self.WarningCardsPanel.Paint = function()
		surface.SetDrawColor( 200, 100, 200, 0 )
		surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	end
	
	local ScrollBar = self.WarningCardsPanel:GetVBar()
	ScrollBar:SetHideButtons( true )
	ScrollBar:SetWidth( 6 * screenscale )
	function ScrollBar:Paint( w, h )
		surface.SetDrawColor( 0, 0, 0, 100 )
		surface.DrawRect( 0, 0, w, h )
	end
	function ScrollBar.btnGrip:Paint( w, h )
		surface.SetDrawColor( AWarn.Colors.COLOR_SELECTED )
		surface.DrawRect( 0, 0, w, h )
	end
		
	self.subWarningButton = vgui.Create( "awarn3_iconbutton", self )
	self.subWarningButton:SetTooltip(AWarn.Localization:GetTranslation( "reduceactiveby1" ))
	self.subWarningButton:SetSize(8 * screenscale, 8 * screenscale)
	self.subWarningButton:SetPos( 695 * screenscale, 12 * screenscale )
	self.subWarningButton:SetIcon( minusImage )
	self.subWarningButton:SetVisible( false )
	self.subWarningButton.OnSelected = function()
		if tonumber(self.selectedplayerwarns) > 0 then
			AWarn:AddActiveWarning( self.selectedplayerid, -1 )
			self.selectedplayerwarns = self.selectedplayerwarns - 1
		end
	end
		
	self.deleteWarningButton = vgui.Create( "awarn3_iconbutton", self )
	self.deleteWarningButton:SetTooltip(
		[[Delete ALL warnings for player.
		This completely deletes their entire warning history.]]
	)
	self.deleteWarningButton:SetSize(8 * screenscale, 8 * screenscale)
	self.deleteWarningButton:SetPos( 791 * screenscale, 12 * screenscale )
	self.deleteWarningButton:SetIcon( deleteImage )
	self.deleteWarningButton:SetVisible( false )
	self.deleteWarningButton.OnSelected = function()
		AWarn:DeleteAllPlayerWarnings( self.selectedplayerid )
		self.selectedplayerwarns = 0
		self.WarningCardsPanel:Clear()
	end
end
vgui.Register( "awarn3_adminwarningsview", PANEL )

function ReturnSortedPlayerTable()	
	local playerinfo = {}
	local playertable = {}
	
	for _, pl in pairs( player.GetAll() ) do
		playerinfo = { Name = pl:GetName(), Entity = pl }
		table.insert( playertable, playerinfo )
	end
	
	table.SortByMember(playertable, "Name", function(a, b) return a > b end)
	return playertable
end

function AWarn:PopulatePlayers()

	for k, v in SortedPairs( ReturnSortedPlayerTable() ) do
		AWarn:AddPlayerCard( v.Entity )
	end
end

function AWarn:AddPlayerCard( pl )
	if not IsValid( self.menu ) then return end
	if not IsValid( self.menu.adminWarningsView ) then return end
	if not IsValid( self.menu.adminWarningsView.PlayerListPanel ) then return end
	
	if not IsValid( pl ) then return end
	
	local PButton = vgui.Create( "awarn3_playerbutton" )
	self.menu.adminWarningsView.PlayerListPanel:AddItem( PButton )
	PButton:SetText( pl:GetName() )
	PButton:Dock( TOP )
	PButton:DrawElements( pl )
	PButton:SetPlayerID( AWarn:SteamID64( pl ) )
end

function AWarn:RemovePlayerCard( id )
	if not IsValid( self.menu ) then return end
	if not IsValid( self.menu.adminWarningsView ) then return end
	if not IsValid( self.menu.adminWarningsView.PlayerListPanel ) then return end
	
	for k, v in pairs( self.menu.adminWarningsView.PlayerListPanel:GetCanvas():GetChildren() ) do
		if v.playerid == id then v:Remove() end
	end
end

net.Receive( "awarn3_playerjoinandleave", function()
	local state = net.ReadString()
	
	if state == "join" then
		local pl = net.ReadEntity()
		AWarn:AddPlayerCard( pl )
	elseif state == "leave" then
		local id = net.ReadString()
		AWarn:RemovePlayerCard( id )
	end
end )

function AWarn:PopulatePlayerWarnings( tbl )

	if not IsValid( self.menu ) then return end
	if not IsValid( self.menu.adminWarningsView ) then return end
	if not IsValid( self.menu.adminWarningsView.WarningCardsPanel ) then return end
	self.menu.adminWarningsView.WarningCardsPanel:Clear()
	
	for k, v in pairs( tbl ) do
		timer.Simple( k * 0.1, function()
			AWarn:AddWarningCard( v )
		end )
	end

end

function AWarn:AddWarningCard( tbl )

	if not IsValid( self.menu ) then return end
	if not IsValid( self.menu.adminWarningsView ) then return end
	if not IsValid( self.menu.adminWarningsView.WarningCardsPanel ) then return end

	local warningCard = vgui.Create( "awarn3_adminwarningcard" )
	self.menu.adminWarningsView.WarningCardsPanel:AddItem( warningCard )
	warningCard:Dock( TOP )
	warningCard:SetInfo( tbl )
	warningCard:DrawElements()
	
end

net.Receive( "awarn3_requestplayerwarnings", function()
	local netType = net.ReadString()
	
	if netType == "warnings" then
		local warningsTable = net.ReadTable()
		AWarn:PopulatePlayerWarnings( warningsTable )
	elseif netType == "info" then
		local infoTable = net.ReadTable()
		if not IsValid( AWarn.menu ) then return end
		if not IsValid( AWarn.menu.adminWarningsView ) then return end
		if #infoTable == 1 then
			AWarn.menu.adminWarningsView.selectedplayer = infoTable[1].PlayerName
			AWarn.menu.adminWarningsView.selectedplayerwarns = infoTable[1].PlayerWarnings
			AWarn.menu.adminWarningsView.selectedplayerlastwarn = infoTable[1].LastWarning
		else
			AWarn.menu.adminWarningsView.selectedplayerwarns = 0
			AWarn.menu.adminWarningsView.selectedplayerlastwarn = "N/A"
		end
	end
	
end )


local PANEL = {}
function PANEL:Init()
	local dockMargin = 4 * screenscale
	self:DockMargin( dockMargin, dockMargin, dockMargin, 0 )
	self:SetHeight( 60 * screenscale )
	self:Dock( TOP )
	self.hovered = false
	self.buttonEnabled = false
	self.warninginfotbl = {}
	
	self:DrawElements()
	
	
	self.start = RealTime()
	self.stop = RealTime() + 0.25
	self.animating = true
	
	self.dX, self.dY = self:GetPos()
end
function PANEL:Paint()
	
	if self.hovered == true then
		surface.SetDrawColor( AWarn.Colors.COLOR_BUTTON_HOVERED )
	else
		surface.SetDrawColor( AWarn.Colors.COLOR_BUTTON )
	end
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	
	if self.buttonEnabled then
		surface.SetDrawColor( AWarn.Colors.COLOR_SELECTED )
		surface.DrawRect( self:GetWide() - 10 * screenscale, 0, 8 * screenscale, self:GetTall() )
	end
		
	surface.SetFont( "AWarn3CardText1" )
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_TEXT )
	
	
	local l, _ = surface.GetTextSize( AWarn.Localization:GetTranslation( "warnedby" ) .. ":" )
	local l2, _ = surface.GetTextSize( AWarn.Localization:GetTranslation( "warningserver" ) .. ":" )
	local l3, _ = surface.GetTextSize( AWarn.Localization:GetTranslation( "warningreason`" ) .. ":" )
	
	local x = l
	if l2 > x then x = l2 end
	if l3 > x then x = l3 end
	
	
	x = x + 15 * screenscale
	--local x = 110 * screenscale
	
	local text = AWarn.Localization:GetTranslation( "warnedby" ) .. ":"
	local tW, tH = surface.GetTextSize( text )
	surface.SetTextPos( x - tW, 6 * screenscale )
	surface.DrawText( text )
	
	local text = AWarn.Localization:GetTranslation( "warningserver" ) .. ":"
	local tW, tH = surface.GetTextSize( text )
	surface.SetTextPos( x - tW, 22 * screenscale )
	surface.DrawText( text )	
	
	local text = AWarn.Localization:GetTranslation( "warningreason" ) .. ":"
	local tW, tH = surface.GetTextSize( text )
	surface.SetTextPos( x - tW, 38 * screenscale )
	surface.DrawText( text )
	
	local x2 = 600 * screenscale
	
	local text = AWarn.Localization:GetTranslation( "warningdate" ) .. ":"
	local tW, tH = surface.GetTextSize( text )
	surface.SetTextPos( x2 - tW, 6 * screenscale )
	surface.DrawText( text )	
	
	
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_VALUE_TEXT )
	
	local x = x + 5 * screenscale
	
	local text = self.warninginfotbl.PlayerName or AWarn.Localization:GetTranslation( "nothing" )
	surface.SetTextPos( x , 6 * screenscale )
	surface.DrawText( text )	
	
	local text = self.warninginfotbl.WarningServer or AWarn.Localization:GetTranslation( "nothing" )
	surface.SetTextPos( x , 22 * screenscale )
	surface.DrawText( text )	
	
	local text = self.warninginfotbl.WarningReason or AWarn.Localization:GetTranslation( "nothing" )
	surface.SetTextPos( x , 38 * screenscale )
	surface.DrawText( text )
	
	local x = 605 * screenscale
	
	local text = os.date( "%d/%m/%Y %H:%M:%S" , self.warninginfotbl.WarningDate or 111111111 )
	surface.SetTextPos( x , 6 * screenscale )
	surface.DrawText( text )
	
	
end
function PANEL:SetEnabled( bool )
	self.buttonEnabled = bool
end
function PANEL:SetInfo( tbl )
	self.warninginfotbl = tbl
end
function PANEL:Think()
	if self:IsHovered() and not self.hovered then
		self.hovered = true
	elseif self.hovered and not self:IsHovered() then
		self.hovered = false
	end
	self:AnimateThink()
end
function PANEL:AnimateThink()
	if not self.animating then return end
	if RealTime() < self.stop then
		local easingsX = easings.outCubic( RealTime() - self.start, 0, self:GetWide(), 0.25 )
		local x, y = self:GetPos()
		local easeAmt = ( easingsX * -1 ) + self:GetWide()
		self:SetPos( easeAmt, y )
	else
		local x, y = self:GetPos()
		self.animating = false
	end
end
function PANEL:DrawElements( pl )
	local deleteButton = vgui.Create( "awarn3_iconbutton", self )
	deleteButton:SetTooltip(AWarn.Localization:GetTranslation( "deletewarning" ))
	deleteButton:SetSize(12 * screenscale, 12 * screenscale)
	deleteButton:SetPos( self:GetParent():GetWide() - deleteButton:GetWide() - 14 * screenscale, 6 * screenscale )
	deleteButton.OnSelected = function()
		AWarn:DeleteSingleWarning( self.warninginfotbl.WarningID, pl )
		self:Remove()
	end
end
function PANEL:OnMousePressed( key )
	if key == MOUSE_RIGHT then
	
	end
end
vgui.Register( "awarn3_adminwarningcard", PANEL )




function AWarn:DeleteSingleWarning( warningID, pl )
	net.Start( "awarn3_deletesinglewarning" )
	net.WriteInt( warningID, 32 )
	net.SendToServer()
end




local PANEL = {}
function PANEL:Init()
	local dockMargin = 4 * screenscale
	self:DockMargin( 0, dockMargin, dockMargin, 0 )
	self:SetHeight( 24 * screenscale )
	self:Dock( TOP )
	self.buttonLabel = AWarn.Localization:GetTranslation( "playername" )
	self.playerid = 0
	self.buttonEnabled = false
	self.hovered = false
end
function PANEL:Paint()
	
	if self.hovered == true then
		surface.SetDrawColor( AWarn.Colors.COLOR_BUTTON_HOVERED )
	else
		surface.SetDrawColor( AWarn.Colors.COLOR_BUTTON )
	end
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	
	if self.buttonEnabled then
		surface.SetDrawColor( AWarn.Colors.COLOR_SELECTED )
		surface.DrawRect( self:GetWide() - 10 * screenscale, 0, 8 * screenscale, self:GetTall() )
	end
	
	surface.SetFont( "AWarn3NavButton" )
	local tW, tH = surface.GetTextSize( self.buttonLabel or "" )
	
	surface.SetTextColor( AWarn.Colors.COLOR_BUTTON_TEXT )
	surface.SetTextPos( 30 * screenscale, ( self:GetTall() / 2 ) - tH / 2 )
	surface.DrawText( self.buttonLabel )
end
function PANEL:SetText( txt )
	self.buttonLabel = txt
end
function PANEL:SetPlayerID( id )
	self.playerid = id
end
function PANEL:SetEnabled( bool )
	self.buttonEnabled = bool
end
function PANEL:Think()
	if self:IsHovered() and not self.hovered then
		self.hovered = true
	elseif self.hovered and not self:IsHovered() then
		self.hovered = false
	end
end
function PANEL:DrawElements( pl )
	self.Avatar = vgui.Create( "AvatarImage", self )
	self.Avatar:SetSize( 20 * screenscale, 20 * screenscale )
	self.Avatar:SetPos( 2 * screenscale, 2 * screenscale )
	self.Avatar:SetPlayer( pl, 16 * screenscale )
end
function PANEL:OnMousePressed( key )
	if key == MOUSE_LEFT then
		if IsValid( AWarn.lastSelectedPlayerButton ) then AWarn.lastSelectedPlayerButton:SetEnabled( false ) end
		self:SetEnabled( true )
		AWarn.lastSelectedPlayerButton = self
		AWarn:RequestWarningsForPlayer( self.playerid )
		AWarn.menu.adminWarningsView.selectedplayerid = self.playerid
		AWarn.menu.adminWarningsView.subWarningButton:SetVisible( true )
		AWarn.menu.adminWarningsView.deleteWarningButton:SetVisible( true )
	end
end
vgui.Register( "awarn3_playerbutton", PANEL )

function AWarn:RequestWarningsForPlayer( PlayerID )
	net.Start( "awarn3_requestplayerwarnings" )
	net.WriteString( PlayerID or "BOT" )
	net.SendToServer()
end

function AWarn:UnselectPlayer()

	AWarn.menu.adminWarningsView.selectedplayer = nil
	AWarn.menu.adminWarningsView.selectedplayerwarns = 0
	AWarn.menu.adminWarningsView.selectedplayerid = nil
	AWarn.menu.adminWarningsView.subWarningButton:SetVisible( false )
	AWarn.menu.adminWarningsView.deleteWarningButton:SetVisible( false )
	if IsValid( AWarn.lastSelectedPlayerButton ) then AWarn.lastSelectedPlayerButton:SetEnabled( false ) end
	AWarn.lastSelectedPlayerButton = nil
	AWarn.menu.adminWarningsView.WarningCardsPanel:Clear()
end





local PANEL = {}
function PANEL:Init()
	local dockMargin = 4 * screenscale
	self:DockMargin( 0, dockMargin, dockMargin, dockMargin )
	self:SetHeight( 24 * screenscale )
	self.buttonLabel = "DEFAULT"
	self.hovered = false
	self.buttoncoloroverride = nil
	self.buttoncolorhoveroverride = nil
	self.buttoncolordisabledoverride = nil
	self.enabled = true
end
function PANEL:Paint()
	if self.enabled then
		if self.hovered == true then
			surface.SetDrawColor( self.buttoncolorhoveroverride or AWarn.Colors.COLOR_BUTTON_HOVERED )
		else
			surface.SetDrawColor( self.buttoncoloroverride or AWarn.Colors.COLOR_BUTTON )
		end
	else
		surface.SetDrawColor( self.buttoncolordisabledoverride or AWarn.Colors.COLOR_BUTTON_DISABLED )
	end
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	
	surface.SetFont( "AWarn3NavButton" )
	local tW, tH = surface.GetTextSize( self.buttonLabel or "" )
	
	surface.SetTextColor( AWarn.Colors.COLOR_BUTTON_TEXT )
	surface.SetTextPos( ( self:GetWide() / 2 ) - tW / 2, ( self:GetTall() / 2 ) - tH / 2 )
	surface.DrawText( self.buttonLabel )
end
function PANEL:SetText( txt )
	self.buttonLabel = txt
end
function PANEL:Think()
	if self:IsHovered() and not self.hovered then
		self.hovered = true
	elseif self.hovered and not self:IsHovered() then
		self.hovered = false
	end
	self:PostThink()
end
function PANEL:PostThink()

end
function PANEL:SetEnabled( enabled )
	self.enabled = enabled
end
function PANEL:OnSelected()
end
function PANEL:OnMousePressed( key )
	if key == MOUSE_LEFT then
		if not self.enabled then return end
		self:OnSelected()
	end
end
vgui.Register( "awarn3_button", PANEL )


local PANEL = {}
function PANEL:Init()
	local dockMarginX = 5 * screenscale
	local dockMarginY = 3 * screenscale
	self:SetHeight( 36 * screenscale )
	self:DockMargin( dockMarginX, 0, dockMarginX, dockMarginY * 2 )
	self:Dock( TOP )
	self:DrawElements()
	self.buttonLabel = "This is a test"
	self.buttonEnabled = false
	self.hovered = false
end
function PANEL:Paint()
	if self.hovered == true then
		surface.SetDrawColor( AWarn.Colors.COLOR_BUTTON_HOVERED )
	else
		surface.SetDrawColor( AWarn.Colors.COLOR_BUTTON )
	end
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	
	if self.buttonEnabled then
		surface.SetDrawColor( AWarn.Colors.COLOR_SELECTED )
		surface.DrawRect( self:GetWide() - 10 * screenscale, 0, 8 * screenscale, self:GetTall() )
	end
	
	
		
	surface.SetDrawColor( AWarn.Colors.COLOR_BUTTON_TEXT )
	surface.SetMaterial( self.icon )
	surface.DrawTexturedRect( 12 * screenscale, 6 * screenscale, 24 * screenscale, 24 * screenscale )
		
	surface.SetFont( "AWarn3NavButton" )
	local tW, tH = surface.GetTextSize( self.buttonLabel or "" )
	
	surface.SetTextColor( AWarn.Colors.COLOR_BUTTON_TEXT )
	surface.SetTextPos( 46 * screenscale, ( self:GetTall() / 2 ) - tH / 2 )
	surface.DrawText( self.buttonLabel )
end
function PANEL:SetText( txt )
	self.buttonLabel = txt
end
function PANEL:SetIcon( icon )
	self.icon = icon
end
function PANEL:SetEnabled( bool )
	self.buttonEnabled = bool
end
function PANEL:DrawElements()
	
end
function PANEL:Think()
	if self:IsHovered() and not self.hovered then
		self.hovered = true
	elseif self.hovered and not self:IsHovered() then
		self.hovered = false
	end
end
function PANEL:OnSelected()
end
function PANEL:OnMousePressed( key )
	if key == MOUSE_LEFT then
		if IsValid( AWarn.lastSelectedNavButton ) then AWarn.lastSelectedNavButton:SetEnabled( false ) end
		self:SetEnabled( true )
		AWarn.lastSelectedNavButton = self
		self:OnSelected()
	end
end
vgui.Register( "awarn3_navbutton", PANEL )


local PANEL = {}
function PANEL:Init()
	local dockMarginX = 5 * screenscale
	local dockMarginY = 3 * screenscale
	self:SetHeight( 36 * screenscale )
	self:DockMargin( dockMarginX, 0, dockMarginX, dockMarginY * 2 )
	self:Dock( BOTTOM )
	self:DrawElements()
	self.buttonLabel = "This is a test"
	self.hovered = false
end
function PANEL:Paint()
	if self.hovered == true then
		surface.SetDrawColor( AWarn.Colors.COLOR_BUTTON_HOVERED )
	else
		surface.SetDrawColor( AWarn.Colors.COLOR_BUTTON )
	end
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	
		
	surface.SetDrawColor( AWarn.Colors.COLOR_BUTTON_TEXT )
	surface.SetMaterial( self.icon )
	surface.DrawTexturedRect( 12 * screenscale, 6 * screenscale, 24 * screenscale, 24 * screenscale )
		
	surface.SetFont( "AWarn3NavButton" )
	local tW, tH = surface.GetTextSize( self.buttonLabel or "" )
	
	surface.SetTextColor( AWarn.Colors.COLOR_BUTTON_TEXT )
	surface.SetTextPos( 46 * screenscale, ( self:GetTall() / 2 ) - tH / 2 )
	surface.DrawText( self.buttonLabel )
end
function PANEL:SetText( txt )
	self.buttonLabel = txt
end
function PANEL:SetIcon( icon )
	self.icon = icon
end
function PANEL:DrawElements()
	
end
function PANEL:Think()
	if self:IsHovered() and not self.hovered then
		self.hovered = true
	elseif self.hovered and not self:IsHovered() then
		self.hovered = false
	end
end
function PANEL:OnSelected()
end
function PANEL:OnMousePressed( key )
	if key == MOUSE_LEFT then
		self:OnSelected()
	end
end
vgui.Register( "awarn3_navbutton2", PANEL )



local PANEL = {}
function PANEL:Init()
	self.hovered = false
	self.icon = deleteImage
	self.iconcolor = Color(255,0,0)
	self.iconcolorhovered = Color(255,120,120)
end
function PANEL:Paint()
	if self.hovered then
		surface.SetDrawColor( self.iconcolorhovered )
	else
		surface.SetDrawColor( self.iconcolor )
	end
	
	surface.SetMaterial( self.icon )
	surface.DrawTexturedRect( 0, 0, self:GetWide(), self:GetTall() )
end
function PANEL:SetIcon( icon )
	self.icon = icon
end
function PANEL:SetIconColor( color, color2 )
	if color then self.iconcolor = color end
	if color2 then self.iconcolorhovered = color2 end
end
function PANEL:Think()
	if self:IsHovered() and not self.hovered then
		self.hovered = true
	elseif self.hovered and not self:IsHovered() then
		self.hovered = false
	end
end
function PANEL:OnSelected()

end
function PANEL:OnMousePressed( key )
	if key == MOUSE_LEFT then
		self:OnSelected()
	end
end
vgui.Register( "awarn3_iconbutton", PANEL )


local PANEL = {}
function PANEL:Init()
	self.start = RealTime()
	self.stop = RealTime() + 0.5
	self.animating = true
	self:SetWide( ScrWM() * 0.25 )
	self:SetTall( ScrHM() * 0.25 )
	self.dX = ScrWM() / 2 - self:GetWide() / 2
	self.dY = ScrHM() / 2 - self:GetTall() / 2
	self:SetPos( ScrWM(), self.dY )
	self:DrawElements()
	self.animspeed = 30
	self.playerid = nil
	self:SetTitle( "" )
	self:ShowCloseButton( false )

end
function PANEL:Paint()
	surface.SetDrawColor( AWarn.Colors.COLOR_THEME_PRIMARY )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	
	surface.SetFont( "AWarn3Label2" )
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_TEXT )
	
	local x = 12 * screenscale
	local text = AWarn.Localization:GetTranslation( "playerwarningmenu" )
	local tW, tH = surface.GetTextSize( text )
	surface.SetTextPos( x , 8 * screenscale )
	surface.DrawText( text )
	
	
	
	local text = AWarn.Localization:GetTranslation( "warningplayer" ) .. ":"
	local tW, tH = surface.GetTextSize( text )
	local x = tW + 12 * screenscale
	surface.SetTextPos( x - tW , 60 * screenscale )
	surface.DrawText( text )
	
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_VALUE_TEXT )
	local text = self.playerName  or "AAA"
	local tW, tH = surface.GetTextSize( text )
	surface.SetTextPos( x + 5 * screenscale, 60 * screenscale )
	surface.DrawText( text )
	
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_TEXT )
	local text = AWarn.Localization:GetTranslation( "warningreason" ) .. ":"
	local tW, tH = surface.GetTextSize( text )
	local x = tW + 12 * screenscale
	surface.SetTextPos( x - tW , 80 * screenscale )
	surface.DrawText( text )
	
end
function PANEL:SetPlayer( id )
	self.playerid = id
	self.playerName = id
	local pl = AWarn:GetPlayerFromID64( id )
	if IsValid( pl ) then self.playerName = pl:GetName() end
end
function PANEL:Think()
	if not self.animating then return end
	if RealTime() < self.stop then
		local easingsX = easings.outCubic( RealTime() - self.start, 0, self.dX + self:GetWide(), 0.5 )
		local x, y = self:GetPos()
		self:SetPos( ScrWM() + easingsX * -1, y )
	else
		local x, y = self:GetPos()
		self:SetPos( self.dX, y )
		self.animating = false
	end
end
function PANEL:DrawElements()
	local dockmargin = 6 * screenscale
	
	
	local closeButton = vgui.Create( "awarn3_iconbutton", self )
	closeButton:SetTooltip(AWarn.Localization:GetTranslation( "closemenu" ))
	closeButton:SetSize(16 * screenscale, 16 * screenscale)
	closeButton:SetPos( self:GetWide() - closeButton:GetWide() - 6 * screenscale, 6 * screenscale )
	closeButton.OnSelected = function()
		self:Remove()
	end
	
	local warnButton = vgui.Create( "awarn3_button", self )
	warnButton:SetText(AWarn.Localization:GetTranslation( "submit" ))
	warnButton:Dock( BOTTOM )
	warnButton:DockMargin( dockmargin, 0, dockmargin, dockmargin )
	
	local textReason = vgui.Create( "DTextEntry", self )
	textReason:SetHeight( 70 * screenscale )
	textReason:SetMultiline( true )
	textReason:DockMargin( dockmargin, dockmargin, dockmargin, dockmargin )
	textReason:Dock( BOTTOM )
	textReason:SetFont( "AWarn3CardText1" )
	
	warnButton.OnSelected = function()
		AWarn:CreateWarningID( self.playerid, LocalPlayer():SteamID64(), textReason:GetValue() or "" )
		if self.playerid == AWarn.menu.adminWarningsView.selectedplayerid then
			AWarn:RequestWarningsForPlayer( self.playerid )
		end
		self:Remove()
	end
	
end
vgui.Register( "awarn3_warndialogue", PANEL, "DFrame" )




local PANEL = {}
function PANEL:Init()
	self.start = RealTime()
	self.stop = RealTime() + 0.5
	self.animating = true
	self:SetWide( ScrWM() * 0.5 )
	self:SetTall( ScrHM() * 0.5 )
	self.dX = ScrWM() / 2 - self:GetWide() / 2
	self.dY = ScrHM() / 2 - self:GetTall() / 2
	self:SetPos( ScrWM(), self.dY )
	self:DrawElements()
	self:SetTitle( "" )
	self:ShowCloseButton( false )
	
	
	
	self.panelQueue = {}
	self.nextProcessTime = RealTime()
end
function PANEL:Paint()
	surface.SetDrawColor( AWarn.Colors.COLOR_THEME_PRIMARY )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	
	surface.SetFont( "AWarn3Label2" )
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_TEXT )
	
	local x = 12 * screenscale
	local text = AWarn.Localization:GetTranslation( "playersearchmenu" )
	local tW, tH = surface.GetTextSize( text )
	surface.SetTextPos( x , 8 * screenscale )
	surface.DrawText( text )

	local x = 320 * screenscale
	local text = AWarn.Localization:GetTranslation( "excludeplayers" )
	local tW, tH = surface.GetTextSize( text )
	surface.SetTextPos( x , 42 * screenscale )
	surface.DrawText( text )
	
	if #self.PlayerCardsPanel:GetCanvas():GetChildren() == 0 then
		surface.SetTextColor( AWarn.Colors.COLOR_LABEL_TEXT )
		surface.SetFont( "AWarn3Label1" )
		y = self:GetTall() / 2 - 40 * screenscale
		local text = AWarn.Localization:GetTranslation( "searchforplayers" )
		local tW, tH = surface.GetTextSize( text )
		local x = self:GetWide()
		surface.SetTextPos( x / 2 - tW / 2, y )
		surface.DrawText( text )
	end
	
end
function PANEL:Think()
	self:ProcessPanelQueue()
	self:AnimatePanel()
end
function PANEL:AnimatePanel()
	if not self.animating then return end
	if RealTime() < self.stop then
		local easingsX = easings.outCubic( RealTime() - self.start, 0, self.dX + self:GetWide(), 0.5 )
		local x, y = self:GetPos()
		self:SetPos( ScrWM() + easingsX * -1, y )
	else
		local x, y = self:GetPos()
		self:SetPos( self.dX, y )
		self.animating = false
	end
end
function PANEL:ProcessPanelQueue()
	if self.nextProcessTime > RealTime() then return end
	self.nextProcessTime = RealTime() + 0.02
	if #self.panelQueue <= 0 then return end
	AWarn:AddSearchPlayerCard( self.panelQueue[1] )
	table.remove( self.panelQueue, 1 )
end
function PANEL:DrawElements()
	local dockmargin = 6 * screenscale
	
	
	local closeButton = vgui.Create( "awarn3_iconbutton", self )
	closeButton:SetTooltip(AWarn.Localization:GetTranslation( "closemenu" ))
	closeButton:SetSize(16 * screenscale, 16 * screenscale)
	closeButton:SetPos( self:GetWide() - closeButton:GetWide() - 6 * screenscale, 6 * screenscale )
	closeButton.OnSelected = function()
		self:Remove()
	end	
	
	local chkBox = vgui.Create( "DCheckBox", self )// Create the checkbox
	chkBox:SetPos( 300 * screenscale, 42 * screenscale )// Set the position
	chkBox:SetValue( 0 )
	
	local playerSearchText = vgui.Create( "DTextEntry", self )
	playerSearchText:SetSize( 200 * screenscale, 20 * screenscale )
	playerSearchText:SetMultiline( false )
	playerSearchText:SetFont( "AWarn3CardText1" )
	playerSearchText:SetPos( 10 * screenscale, 40 * screenscale )	
	playerSearchText:SetEnterAllowed( true )
	playerSearchText.OnEnter = function()
		if not ( playerSearchText:GetValue() == "" ) then
			AWarn:SendSearchString( playerSearchText:GetValue(), chkBox:GetChecked() )
		else
			return false
		end
	end
	
	local searchButton = vgui.Create( "awarn3_iconbutton", self )
	searchButton:SetTooltip(AWarn.Localization:GetTranslation( "searchforplayers" ))
	searchButton:SetIcon( searchImage )
	searchButton:SetIconColor( Color( 255, 255, 255, 255 ) )
	searchButton:SetSize( 16 * screenscale, 16 * screenscale )
	searchButton:SetPos( 215 * screenscale, 42 * screenscale )
	searchButton.OnSelected = function()
		AWarn:SendSearchString( playerSearchText:GetValue(), chkBox:GetChecked() )
	end
	
	self.PlayerCardsPanel = vgui.Create( "DScrollPanel", self )
	self.PlayerCardsPanel:SetHeight( self:GetTall() - 75 * screenscale )
	self.PlayerCardsPanel:Dock( BOTTOM )
	self.PlayerCardsPanel:DockMargin( 0, 30 * screenscale, 0, 0 )
	self.PlayerCardsPanel:GetCanvas():DockPadding( 0, 0, 0, 6 * screenscale )
	self.PlayerCardsPanel.Paint = function()
		surface.SetDrawColor( 200, 100, 200, 0 )
		surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	end
	
	local ScrollBar = self.PlayerCardsPanel:GetVBar()
	ScrollBar:SetHideButtons( true )
	ScrollBar:SetWidth( 6 * screenscale )
	function ScrollBar:Paint( w, h )
		surface.SetDrawColor( 0, 0, 0, 100 )
		surface.DrawRect( 0, 0, w, h )
	end
	function ScrollBar.btnGrip:Paint( w, h )
		surface.SetDrawColor( AWarn.Colors.COLOR_SELECTED )
		surface.DrawRect( 0, 0, w, h )
	end
	
end
vgui.Register( "awarn3_playersearch", PANEL, "DFrame" )





local PANEL = {}
function PANEL:Init()
	local dockMargin = 4 * screenscale
	self:DockMargin( dockMargin, dockMargin, dockMargin, 0 )
	self:SetHeight( 36 * screenscale )
	self:Dock( TOP )
	
	self.lastclicked = RealTime()
	
	self.hovered = false
	
	self.warninginfotbl = {}
		
	self.start = RealTime()
	self.stop = RealTime() + 0.1
	self.animating = true
	
	self.dX, self.dY = self:GetPos()
	
	timer.Simple( 0.5, function() if IsValid(self) then self:DrawElements() end end )
	
end
function PANEL:Paint()
	
	if self.hovered == true then
		surface.SetDrawColor( AWarn.Colors.COLOR_BUTTON_HOVERED )
	else
		surface.SetDrawColor( AWarn.Colors.COLOR_BUTTON )
	end
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	
	surface.SetFont( "AWarn3CardText1" )
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_TEXT )
	
	
		
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_TEXT )
	local text = AWarn.Localization:GetTranslation( "name" ) .. ":"
	local tW, tH = surface.GetTextSize( text )
	local x = tW + 5 * screenscale
	surface.SetTextPos( x - tW, 5 * screenscale )
	surface.DrawText( text )
	
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_VALUE_TEXT )
	local text = self.warninginfotbl.PlayerName or "ERROR"
	local tW, tH = surface.GetTextSize( text )
	surface.SetTextPos( x + 4 * screenscale, 5 * screenscale )
	surface.DrawText( text )
	
	
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_TEXT )
	local text = AWarn.Localization:GetTranslation( "activewarnings" ) .. ":"
	local tW, tH = surface.GetTextSize( text )
	local x = tW + 5 * screenscale
	surface.SetTextPos( x - tW, 18 * screenscale)
	surface.DrawText( text )
	
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_VALUE_TEXT )
	local text = self.warninginfotbl.PlayerWarnings or "ERROR"
	local tW, tH = surface.GetTextSize( text )
	surface.SetTextPos( x + 4 * screenscale, 18 * screenscale )
	surface.DrawText( text )
	
	
	
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_TEXT )
	local text = AWarn.Localization:GetTranslation( "lastplayed" ) .. ":"
	local tW, tH = surface.GetTextSize( text )
	local x = tW + 450 * screenscale
	surface.SetTextPos( x - tW, 5 * screenscale )
	surface.DrawText( text )
	
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_VALUE_TEXT )
	local text = AWarn.Localization:GetTranslation( "never" )
	if self.warninginfotbl.LastPlayed and not ( self.warninginfotbl.LastPlayed == "NULL" ) then
		text = os.date( "%m/%d/%Y" , self.warninginfotbl.LastPlayed or 111111111 )
	end
	local tW, tH = surface.GetTextSize( text )
	surface.SetTextPos( x + 4 * screenscale, 5 * screenscale )
	surface.DrawText( text )
	
	
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_TEXT )
	local text = AWarn.Localization:GetTranslation( "lastwarned" ) .. ":"
	local tW, tH = surface.GetTextSize( text )
	local x = tW + 450 * screenscale
	surface.SetTextPos( x - tW, 18 * screenscale )
	surface.DrawText( text )
	
	surface.SetTextColor( AWarn.Colors.COLOR_LABEL_VALUE_TEXT )
	local text = AWarn.Localization:GetTranslation( "never" )
	if self.warninginfotbl.LastWarning and not ( self.warninginfotbl.LastWarning == "NULL" ) then
		text = os.date( "%m/%d/%Y %H:%M" , self.warninginfotbl.LastWarning or 111111111 )
	end
	local tW, tH = surface.GetTextSize( text )
	surface.SetTextPos( x + 4 * screenscale, 18 * screenscale )
	surface.DrawText( text )


end
function PANEL:SetInfo( tbl )
	self.warninginfotbl = tbl
	self:SetTooltip( AWarn.Localization:GetTranslation( "playerid" ) .. ": " .. tbl.PlayerID )
end
function PANEL:Think()
	if self:IsHovered() and not self.hovered then
		self.hovered = true
	elseif self.hovered and not self:IsHovered() then
		self.hovered = false
	end
	self:AnimateThink()
end
function PANEL:AnimateThink()
	if not self.animating then return end
	if RealTime() < self.stop then
		local easingsX = easings.outCubic( RealTime() - self.start, 0, self:GetWide(), 0.1 )
		local x, y = self:GetPos()
		local easeAmt = ( easingsX * -1 ) + self:GetWide()
		self:SetPos( easeAmt, y )
	else
		local x, y = self:GetPos()
		self.animating = false
	end
end
function PANEL:DrawElements( pl )
	local searchButton = vgui.Create( "awarn3_iconbutton", self )
	searchButton:SetTooltip( AWarn.Localization:GetTranslation( "lookupplayerwarnings" ) )
	searchButton:SetIcon( searchImage )
	searchButton:SetIconColor( Color( 255, 255, 255, 255 ) )
	searchButton:SetSize( 10 * screenscale, 10 * screenscale )
	searchButton:SetPos( self:GetWide() - 20, 4 * screenscale )
	searchButton.OnSelected = function()
		self:DoSelect()
	end
end
function PANEL:DoSelect()
	AWarn:UnselectPlayer()
	AWarn:RequestWarningsForPlayer( self.warninginfotbl.PlayerID )
	AWarn.menu.adminWarningsView.selectedplayerid = self.warninginfotbl.PlayerID
	AWarn.menu.adminWarningsView.subWarningButton:SetVisible( true )
	AWarn.menu.adminWarningsView.deleteWarningButton:SetVisible( true )
	AWarn.menu.playersearch:Remove()
end
function PANEL:OnMousePressed( key )
	if key == MOUSE_LEFT then
		if RealTime() - self.lastclicked <= 0.3 then
			self:DoSelect()
		end
		self.lastclicked = RealTime()
	end
end
vgui.Register( "awarn3_searchplayercard", PANEL )

function AWarn:PopulateSearchPlayerWarnings( tbl, clear )
	if not IsValid( self.menu ) then return end
	if not IsValid( self.menu.playersearch ) then return end
	
	if clear then
		self.menu.playersearch.panelQueue = {}
		self.menu.playersearch.PlayerCardsPanel:Clear()
	end
	

	if #tbl > 0 then
		table.Add( self.menu.playersearch.panelQueue, tbl )
	end
end

function AWarn:AddSearchPlayerCard( tbl )

	local searchPlayerCard = vgui.Create( "awarn3_searchplayercard" )
	self.menu.playersearch.PlayerCardsPanel:AddItem( searchPlayerCard )
	searchPlayerCard:Dock( TOP )
	searchPlayerCard:SetInfo( tbl )
	
end

function AWarn:SendSearchString( str, excludePlayers )
	net.Start( "awarn3_requestplayersearchdata" )
	net.WriteString( str )
	net.WriteBool( excludePlayers )
	net.SendToServer()
end

net.Receive( "awarn3_requestplayersearchdata", function()
	local page = net.ReadInt(8)
	local data = net.ReadTable()
	local toClear = false
	if page == 1 then toClear = true end
	AWarn:PopulateSearchPlayerWarnings( data, toClear )
end )