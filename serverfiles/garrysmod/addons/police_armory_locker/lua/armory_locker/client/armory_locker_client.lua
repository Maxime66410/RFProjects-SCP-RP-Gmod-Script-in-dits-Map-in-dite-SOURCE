local wa_ui = Material( "craphead_scripts/armory_robbery_ui/armory_ui.png" )

local col_green = Color( 0, 75, 0, 150 )
local col_light_green = Color( 0, 125, 0, 150 )
local col_red = Color( 125, 0, 0, 210 )

net.Receive( "ARM_LOCKER_Weapon_Menu", function( len, ply )
	local locker_ent = net.ReadEntity()
	local locker_num = net.ReadInt( 8 )
	
	local item_1 = net.ReadTable()
	local item_2 = net.ReadTable()
	local item_3 = net.ReadTable()
	
	local wep1taken = false
	local wep2taken = false
	local wep3taken = false

	local LOCKER_GUI_Frame = vgui.Create("DFrame")
	LOCKER_GUI_Frame:SetTitle("")
	LOCKER_GUI_Frame:SetSize( ScrW() * 0.5432, ScrH() * 0.47226 )
	LOCKER_GUI_Frame:Center()
	LOCKER_GUI_Frame.Paint = function(CHPaint)
		surface.SetDrawColor( color_white )
		surface.SetMaterial( wa_ui )

		surface.DrawTexturedRect( 0, 0, ScrW() * 0.5432, ScrH() * 0.47226 )
		-- Draw the top title.
		draw.SimpleText("Weapon Locker", "ARMORY_UIFontTitle", ScrW() * 0.09, ScrH() * 0.02, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		
		if wep1taken then
			draw.SimpleText("Item Taken", "ARMORY_UIFontButton", ScrW() * 0.115, ScrH() * 0.338, col_red, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		if wep2taken then
			draw.SimpleText("Item Taken", "ARMORY_UIFontButton", ScrW() * 0.272, ScrH() * 0.338, col_red, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		if wep3taken then
			draw.SimpleText("Item Taken", "ARMORY_UIFontButton", ScrW() * 0.428, ScrH() * 0.338, col_red, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
	LOCKER_GUI_Frame:MakePopup()
	LOCKER_GUI_Frame:SetDraggable( false )
	LOCKER_GUI_Frame:ShowCloseButton( false )

	local GUI_Armory_Exit = vgui.Create( "DButton", LOCKER_GUI_Frame )
	GUI_Armory_Exit:SetSize( ScrW() * 0.015, ScrW() * 0.015 )
	GUI_Armory_Exit:SetPos( ScrW() * 0.498, ScrH() * 0.0075 )
	GUI_Armory_Exit:SetText( "" )
	GUI_Armory_Exit.Paint = function()
		draw.RoundedBox( 8, 1, 1, GUI_Armory_Exit:GetWide(), GUI_Armory_Exit:GetTall(), color_transparent )
	end
	GUI_Armory_Exit.DoClick = function()
		LOCKER_GUI_Frame:Remove()
		
		net.Start( "ARM_LOCKER_FinishLockpicking" )
			net.WriteEntity( locker_ent )
			net.WriteInt( locker_num, 8 )
		net.SendToServer()
	end
	
	-- Panel 1
	surface.SetFont( "ARMORY_UIFontButton" )
	local x, y = surface.GetTextSize( item_1.Name )
	if item_1.Category == "ammo" then
		x, y = surface.GetTextSize( item_1.AmmoAmt .." x ".. item_1.Name )
	end
	
	local ItemName = vgui.Create( "DLabel", LOCKER_GUI_Frame )
	ItemName:SetPos( ( LOCKER_GUI_Frame:GetWide() / 4.7 ) - ( x / 2 ), ScrH() * 0.0925 )
	ItemName:SetFont( "ARMORY_UIFontButton" )
	ItemName:SetColor( color_white )
	if item_1.Category == "ammo" then
		ItemName:SetText( item_1.AmmoAmt .." x ".. item_1.Name )
	else
		ItemName:SetText( item_1.Name )
	end
	ItemName:SizeToContents()
	
	local Weapon1Panel = vgui.Create( "DPanel", LOCKER_GUI_Frame )
	Weapon1Panel:SetSize( ScrW() * 0.13, ScrH() * 0.3 )
	Weapon1Panel:SetPos( ScrW() * 0.05, ScrH() * 0.08 )
	Weapon1Panel.Paint = function()
		draw.RoundedBox( 8, 1, 1, Weapon1Panel:GetWide(), Weapon1Panel:GetTall(), color_transparent )	
	end

	local Weapon1Icon = vgui.Create( "DModelPanel", Weapon1Panel )
	Weapon1Icon:SetPos( ScrW() * 0.13 * - 1, ScrH() * 0.343 * - 1 )
	Weapon1Icon:SetSize( ScreenScale( 250 ), ScreenScale( 250 ) )
	Weapon1Icon:SetModel( item_1.Model )
	Weapon1Icon:SetFOV( 90 )
	Weapon1Icon:SetCamPos( Vector( 90, 0, 0 ) )
	
	local GUI_Weapon1Take = vgui.Create( "DButton", Weapon1Panel )	
	GUI_Weapon1Take:SetSize( ScrW() * 0.0886, ScrH() * 0.039 )
	GUI_Weapon1Take:SetPos( ScrW() * 0.022, ScrH() * 0.24 )
	GUI_Weapon1Take:SetText( "" )
	GUI_Weapon1Take.Paint = function( self )
		if GUI_Weapon1Take:IsHovered() then
			draw.RoundedBoxEx( 8, 0, 0, self:GetWide(), self:GetTall(), col_light_green, false, false, false, false )
		else
			draw.RoundedBoxEx( 8, 0, 0, self:GetWide(), self:GetTall(), col_green, false, false, false, false )
		end

		draw.SimpleText( "Retrieve Item", "ARMORY_UIFontButton", self:GetWide() / 2, self:GetTall() / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	GUI_Weapon1Take.DoClick = function()
		wep1taken = true
		
		net.Start( "ARM_LOCKER_StealItem" )
			net.WriteEntity( locker_ent )
			net.WriteTable( item_1 )
		net.SendToServer()
		
		GUI_Weapon1Take:Remove()
	end
	
	-- Panel 2
	local x, y = surface.GetTextSize( item_2.Name )
	if item_2.Category == "ammo" then
		x, y = surface.GetTextSize( item_2.AmmoAmt .." x ".. item_2.Name )
	end
	
	local ItemName = vgui.Create( "DLabel", LOCKER_GUI_Frame )
	ItemName:SetPos( ( LOCKER_GUI_Frame:GetWide() / 2 ) - ( x / 2 ), ScrH() * 0.0925 )
	ItemName:SetFont( "ARMORY_UIFontButton" )
	ItemName:SetColor( color_white )
	if item_2.Category == "ammo" then
		ItemName:SetText( item_2.AmmoAmt .." x ".. item_2.Name )
	else
		ItemName:SetText( item_2.Name )
	end
	ItemName:SizeToContents()
	
	local Weapon2Panel = vgui.Create( "DPanel", LOCKER_GUI_Frame )
	Weapon2Panel:SetSize( ScrW() * 0.13, ScrH() * 0.3 )
	Weapon2Panel:SetPos( ScrW() * 0.207, ScrH() * 0.08 )
	Weapon2Panel.Paint = function()
		draw.RoundedBox( 8, 1, 1, Weapon2Panel:GetWide(), Weapon2Panel:GetTall(), color_transparent )	
	end
	
	local Weapon2Icon = vgui.Create( "DModelPanel", Weapon2Panel )
	Weapon2Icon:SetPos( ScrW() * 0.13 * - 1, ScrH() * 0.343 * - 1 )
	Weapon2Icon:SetSize( ScreenScale( 250 ), ScreenScale( 250 ) )
	Weapon2Icon:SetModel( item_2.Model )
	Weapon2Icon:SetFOV( 90 )
	Weapon2Icon:SetCamPos( Vector( 90, 0, 0 ) )
	
	local GUI_Weapon2Take = vgui.Create("DButton", Weapon2Panel)	
	GUI_Weapon2Take:SetSize( ScrW() * 0.0886, ScrH() * 0.039 )
	GUI_Weapon2Take:SetPos( ScrW() * 0.021, ScrH() * 0.24 )
	GUI_Weapon2Take:SetText( "" )
	GUI_Weapon2Take.Paint = function( self )
		if GUI_Weapon2Take:IsHovered() then
			draw.RoundedBoxEx( 8, 0, 0, self:GetWide(), self:GetTall(), col_light_green, false, false, false, false )
		else
			draw.RoundedBoxEx( 8, 0, 0, self:GetWide(), self:GetTall(), col_green, false, false, false, false )
		end

		draw.SimpleText( "Retrieve Item", "ARMORY_UIFontButton", self:GetWide() / 2, self:GetTall() / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	GUI_Weapon2Take.DoClick = function()
		wep2taken = true
		
		net.Start( "ARM_LOCKER_StealItem" )
			net.WriteEntity( locker_ent )
			net.WriteTable( item_2 )
		net.SendToServer()
		
		GUI_Weapon2Take:Remove()
	end
	
	-- Panel 3
	local x, y = surface.GetTextSize( item_3.Name )
	if item_3.Category == "ammo" then
		x, y = surface.GetTextSize( item_3.AmmoAmt .." x ".. item_3.Name )
	end
	
	local ItemName = vgui.Create( "DLabel", LOCKER_GUI_Frame )
	ItemName:SetPos( ( LOCKER_GUI_Frame:GetWide() / 1.27 ) - ( x / 2 ), ScrH() * 0.0925 )
	ItemName:SetFont( "ARMORY_UIFontButton" )
	ItemName:SetColor( color_white )
	if item_3.Category == "ammo" then
		ItemName:SetText( item_3.AmmoAmt .." x ".. item_3.Name )
	else
		ItemName:SetText( item_3.Name )
	end
	ItemName:SizeToContents()
	
	local Weapon3Panel = vgui.Create( "DPanel", LOCKER_GUI_Frame )
	Weapon3Panel:SetSize( ScrW() * 0.13, ScrH() * 0.3 )
	Weapon3Panel:SetPos( ScrW() * 0.364, ScrH() * 0.08 )
	Weapon3Panel.Paint = function()
		draw.RoundedBox( 8, 1, 1, Weapon3Panel:GetWide(), Weapon3Panel:GetTall(), color_transparent )	
	end
	
	local Weapon3Icon = vgui.Create( "DModelPanel", Weapon3Panel )
	Weapon3Icon:SetPos( ScrW() * 0.13 * - 1, ScrH() * 0.343 * - 1 )
	Weapon3Icon:SetSize( ScreenScale( 250 ), ScreenScale( 250 ) )
	Weapon3Icon:SetModel( item_3.Model )
	Weapon3Icon:SetFOV( 90 )
	Weapon3Icon:SetCamPos( Vector( 90, 0, 0 ) )
	
	local GUI_Weapon3Take = vgui.Create("DButton", Weapon3Panel)	
	GUI_Weapon3Take:SetSize( ScrW() * 0.0886, ScrH() * 0.039 )
	GUI_Weapon3Take:SetPos( ScrW() * 0.02, ScrH() * 0.24 )
	GUI_Weapon3Take:SetText("")
	GUI_Weapon3Take.Paint = function( self )
		if GUI_Weapon3Take:IsHovered() then
			draw.RoundedBoxEx( 8, 0, 0, self:GetWide(), self:GetTall(), col_light_green, false, false, false, false )
		else
			draw.RoundedBoxEx( 8, 0, 0, self:GetWide(), self:GetTall(), col_green, false, false, false, false )
		end

		draw.SimpleText( "Retrieve Item", "ARMORY_UIFontButton", self:GetWide() / 2, self:GetTall() / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	GUI_Weapon3Take.DoClick = function()
		wep3taken = true
		
		net.Start( "ARM_LOCKER_StealItem" )
			net.WriteEntity( locker_ent )
			net.WriteTable( item_3 )
		net.SendToServer()
		
		GUI_Weapon3Take:Remove()
	end
end )