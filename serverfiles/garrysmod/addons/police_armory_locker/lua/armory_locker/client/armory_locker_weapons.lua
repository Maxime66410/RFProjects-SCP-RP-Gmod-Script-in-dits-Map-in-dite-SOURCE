local mat_col_spec = 76561198217402428
local mat_armory = Material( "craphead_scripts/armory_robbery_ui/police_armory_ui.png" )

local col_dgray = Color( 26, 26, 26, 255 )
local col_lgray = Color( 19, 19, 19, 255 )

local col_green = Color( 0, 75, 0, 255 )
local col_light_green = Color( 0, 125, 0, 255 )

local col_red = Color( 75, 0, 0, 255 )
local col_light_red = Color( 125, 0, 0, 255 )

local col_restricted = Color( 30, 30, 30, 255 )
local col_restricted_hover = Color( 25, 25, 25, 255 )

net.Receive( "ARMORY_Weapon_Menu", function( len, ply )
	local GUI_Armory_Frame = vgui.Create( "DFrame" )
	GUI_Armory_Frame:SetTitle( "" )
	GUI_Armory_Frame:SetSize( ScrW() * 0.5, ScrH() * 0.5 )
	GUI_Armory_Frame:SetPos( ScrW() * 0.5, ScrH() * 0.5 )
	GUI_Armory_Frame:SetMouseInputEnabled( true ) 
	GUI_Armory_Frame:Center()
	GUI_Armory_Frame.Paint = function( self )
		surface.SetDrawColor( color_white )
		surface.SetMaterial( mat_armory )
		surface.DrawTexturedRect( 0, 0, ScrW() * 0.48, ScrH() * 0.495 )
		
		-- Draw the top title.
		draw.SimpleText( "Police Armory", "ARMORY_UIFontTitle", ScrW() * 0.064, ScrH() * 0.051, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	GUI_Armory_Frame:MakePopup()
	GUI_Armory_Frame:SetDraggable( false )
	GUI_Armory_Frame:ShowCloseButton( false )
	
	local GUI_Armory_Exit = vgui.Create( "DButton", GUI_Armory_Frame )
	GUI_Armory_Exit:SetSize( ScreenScale( 6.5 ), ScreenScale( 6.5 ) )
	GUI_Armory_Exit:SetPos( ScrW() * 0.465, ScrH() * 0.04 )
	GUI_Armory_Exit:SetText( "" )
	GUI_Armory_Exit.Paint = function()
	end
	GUI_Armory_Exit.DoClick = function()
		GUI_Armory_Frame:Remove()
		
		net.Start("ARM_LOCKER_CloseDoorAnim")
		net.SendToServer()
	end
	
	local GUI_Item_Panel = vgui.Create( "DPanelList", GUI_Armory_Frame )
	GUI_Item_Panel:SetSize( ScrW() * 0.466, ScrH() * 0.4125 )
	GUI_Item_Panel:SetPos( ScrW() * 0.01, ScrH() * 0.073 )
	GUI_Item_Panel:EnableVerticalScrollbar( true )
	GUI_Item_Panel:EnableHorizontal( true )
	GUI_Item_Panel.Paint = function()
		draw.RoundedBox( 2, 0, 2, GUI_Item_Panel:GetWide(), GUI_Item_Panel:GetTall(), color_transparent )
	end
	if ( GUI_Item_Panel.VBar ) then
		GUI_Item_Panel.VBar.Paint = function(self, w, h)
			draw.RoundedBoxEx( 0, 0, 0, w, h, color_transparent ) -- BG
		end
		
		GUI_Item_Panel.VBar.btnUp.Paint = function(self, w, h)
			draw.RoundedBox( 4, 0, 2, w, h, color_transparent )
		end
		
		GUI_Item_Panel.VBar.btnGrip.Paint = function(self, w, h)
			draw.RoundedBoxEx( 16, -5, 3, w, h, color_white, false, false, false, false )
		end
		
		GUI_Item_Panel.VBar.btnDown.Paint = function(self, w, h)
			draw.RoundedBox( 0, 0, 0, w, h, color_transparent )
		end
	end
	
	for k, v in pairs( CH_Armory_Locker.Weapons ) do
		if v.Name then
			if CH_Armory_Locker.Config.HideRestrictedItems and table.HasValue( CH_Armory_Locker.TeamCategories[ v.Weapon ], team.GetName( LocalPlayer():Team() ) ) then
				local GUI_ItemPanel = vgui.Create("DPanelList")
				GUI_ItemPanel:SetSize( ScrW() * 0.455, ScrH() * 0.155 )
				GUI_ItemPanel:SetPos( ScreenScale( 3.3 ), ScreenScale( 10 ) )
				GUI_ItemPanel:SetSpacing( 10 )
				GUI_ItemPanel.Paint = function()
					-- Outer
					draw.RoundedBox( 2, ScrW() * 0.008, ScrH() * 0.015, GUI_ItemPanel:GetWide(),GUI_ItemPanel:GetTall(), col_dgray )
					
					-- Weapon model frame
					draw.RoundedBox( 2, ScrW() * 0.011, ScrH() * 0.019, ScrW() * 0.125, ScrH() * 0.13, col_lgray )
					
					-- Weapon text frame
					draw.RoundedBox( 2, ScrW() * 0.138, ScrH() * 0.019, ScrW() * 0.313, ScrH() * 0.13, col_lgray )
				end
				
				surface.SetFont( "ARMORY_UIFontText" )
				local x, y = surface.GetTextSize( v.Name )
			
			--if CH_Armory_Locker.Config.HideRestrictedItems and table.HasValue( CH_Armory_Locker.TeamCategories[ v.Weapon ], team.GetName( LocalPlayer():Team() ) ) then
				local GUI_Item_Name = vgui.Create( "DLabel", GUI_ItemPanel )
				GUI_Item_Name:SetPos( ( GUI_ItemPanel:GetWide() / 6.25 ) - ( x / 2 ), ScrH() * 0.025 )
				GUI_Item_Name:SetFont( "ARMORY_UIFontText" )
				GUI_Item_Name:SetColor( color_white )
				GUI_Item_Name:SetText( v.Name )
				GUI_Item_Name:SizeToContents()
				
				local GUI_Item_Icon = vgui.Create( "DModelPanel", GUI_ItemPanel )
				GUI_Item_Icon:SetPos( ScrW() * 0.005, ScrH() * 0.055 )
				GUI_Item_Icon:SetSize( ScreenScale( 90 ), ScreenScale( 35 ) )
				GUI_Item_Icon:SetModel( v.Model )
				GUI_Item_Icon:GetEntity():SetAngles( Angle( -10, 0, 15 ) )
				local mn, mx = GUI_Item_Icon.Entity:GetRenderBounds()
				local size = 0
				size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
				size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
				size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
				GUI_Item_Icon:SetFOV( 45 )
				GUI_Item_Icon:SetCamPos( Vector( size, size, size ) )
				GUI_Item_Icon:SetLookAt( (mn + mx) * 0.5 )
				function GUI_Item_Icon:LayoutEntity( Entity ) return end
				
				-- Weapon Description
				local GUI_Item_Desc = vgui.Create( "DLabel", GUI_ItemPanel )
				GUI_Item_Desc:SetPos( ScrW() * 0.145, ScrH() * 0.025 )
				GUI_Item_Desc:SetFont( "ARMORY_UIFontText" )
				GUI_Item_Desc:SetColor( Color( 100, 100, 100, 230 ) )
				GUI_Item_Desc:SetText( "Description" )
				GUI_Item_Desc:SizeToContents()
				
				local x, y = surface.GetTextSize( v.Desc )

				local GUI_Item_DescText = vgui.Create( "DLabel", GUI_ItemPanel )
				if x <= 500 then
					GUI_Item_DescText:SetPos( ScrW() * 0.145, ScrH() * 0.03 )
				elseif x <= 1000 then
					GUI_Item_DescText:SetPos( ScrW() * 0.145, ScrH() * 0.04 )
				else
					GUI_Item_DescText:SetPos( ScrW() * 0.145, ScrH() * 0.05 )
				end
				
				GUI_Item_DescText:SetSize( ScrW() * 0.27, ScrH() * 0.055 )
				GUI_Item_DescText:SetFont( "ARMORY_UIFontText" )
				GUI_Item_DescText:SetColor( Color( 230, 230, 230, 230 ) )
				GUI_Item_DescText:SetWrap( true )
				GUI_Item_DescText:SetText( v.Desc )

				-- Retrieve/Deposit Button
				local GUI_Retrieve_Item = vgui.Create("DButton", GUI_ItemPanel)
				GUI_Retrieve_Item:SetPos( ScrW() * 0.372, ScrH() * 0.11 )
				GUI_Retrieve_Item:SetSize( ScrW() * 0.075, ScrH() * 0.031 )
				GUI_Retrieve_Item:SetText("")
				GUI_Retrieve_Item.Paint = function( self )
					if CH_Armory_Locker.Config.UseJobRestrictions and CH_Armory_Locker.TeamCategories[ v.Weapon ] and not table.HasValue( CH_Armory_Locker.TeamCategories[ v.Weapon ], team.GetName( LocalPlayer():Team() ) ) then
						self:SetToolTip( "Only the following jobs can retrieve this item: ".. table.concat( CH_Armory_Locker.TeamCategories[ v.Weapon ], ", " ) )
						if self:IsHovered() then
							draw.RoundedBoxEx( 8, 0, 0, self:GetWide(), self:GetTall(), col_restricted_hover, false, false, false, false )
						else
							draw.RoundedBoxEx( 8, 0, 0, self:GetWide(), self:GetTall(), col_restricted, false, false, false, false )
						end
					elseif not LocalPlayer():HasWeapon( v.Weapon ) then
						if self:IsHovered() then
							draw.RoundedBoxEx( 8, 0, 0, self:GetWide(), self:GetTall(), col_light_green, false, false, false, false )
						else
							draw.RoundedBoxEx( 8, 0, 0, self:GetWide(), self:GetTall(), col_green, false, false, false, false )
						end
					else
						if self:IsHovered() then
							draw.RoundedBoxEx( 8, 0, 0, self:GetWide(), self:GetTall(), col_light_red, false, false, false, false )
						else
							draw.RoundedBoxEx( 8, 0, 0, self:GetWide(), self:GetTall(), col_red, false, false, false, false )
						end
					end
					
					local btn_text = "N/A"
					
					if CH_Armory_Locker.Config.UseJobRestrictions and CH_Armory_Locker.TeamCategories[ v.Weapon ] and not table.HasValue( CH_Armory_Locker.TeamCategories[ v.Weapon ], team.GetName( LocalPlayer():Team() ) ) then
						btn_text = "Item Restricted"
					elseif v.Category == "pistol" or v.Category == "smg" or v.Category == "rifle" or v.Category == "shotgun" or v.Category == "sniper" then
						if LocalPlayer():HasWeapon( v.Weapon ) then
							btn_text = "Deposit Weapon"
						else
							btn_text = "Retrieve Weapon"
						end
					elseif v.Category == "ammo" then
						btn_text = "Retrieve Ammo"
					elseif v.Category == "armor" then
						btn_text = "Retrieve Armor"
					elseif v.Category == "health" then
						btn_text = "Retrieve Health"
					end
					
					draw.SimpleText( btn_text, "ARMORY_UIFontTextButton", self:GetWide() / 2, self:GetTall() / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				end
				GUI_Retrieve_Item.DoClick = function()
					GUI_Armory_Frame:Remove()
							
					if v.Category == "pistol" or v.Category == "smg" or v.Category == "rifle" or v.Category == "shotgun" or v.Category == "sniper" then
						if LocalPlayer():HasWeapon( v.Weapon ) then
							net.Start( "ARMORY_DepositItem" )
								net.WriteDouble( k )
							net.SendToServer()
						else
							net.Start( "ARMORY_RetrieveItem" )
								net.WriteDouble( k )
							net.SendToServer()
						end
					else
						net.Start( "ARMORY_RetrieveItem" )
							net.WriteDouble( k )
						net.SendToServer()
					end
							
					net.Start("ARM_LOCKER_CloseDoorAnim")
					net.SendToServer()
				end
						
				GUI_Item_Panel:AddItem( GUI_ItemPanel )
			elseif not CH_Armory_Locker.Config.HideRestrictedItems then
				local GUI_ItemPanel = vgui.Create("DPanelList")
				GUI_ItemPanel:SetSize( ScrW() * 0.455, ScrH() * 0.155 )
				GUI_ItemPanel:SetPos( ScreenScale( 3.3 ), ScreenScale( 10 ) )
				GUI_ItemPanel:SetSpacing( 10 )
				GUI_ItemPanel.Paint = function()
					-- Outer
					draw.RoundedBox( 2, ScrW() * 0.008, ScrH() * 0.015, GUI_ItemPanel:GetWide(),GUI_ItemPanel:GetTall(), col_dgray )
					
					-- Weapon model frame
					draw.RoundedBox( 2, ScrW() * 0.011, ScrH() * 0.019, ScrW() * 0.125, ScrH() * 0.13, col_lgray )
					
					-- Weapon text frame
					draw.RoundedBox( 2, ScrW() * 0.138, ScrH() * 0.019, ScrW() * 0.313, ScrH() * 0.13, col_lgray )
				end
				
				surface.SetFont( "ARMORY_UIFontText" )
				local x, y = surface.GetTextSize( v.Name )
				
				local GUI_Item_Name = vgui.Create( "DLabel", GUI_ItemPanel )
				GUI_Item_Name:SetPos( ( GUI_ItemPanel:GetWide() / 6.25 ) - ( x / 2 ), ScrH() * 0.025 )
				GUI_Item_Name:SetFont( "ARMORY_UIFontText" )
				GUI_Item_Name:SetColor( color_white )
				GUI_Item_Name:SetText( v.Name )
				GUI_Item_Name:SizeToContents()
				
				local GUI_Item_Icon = vgui.Create( "DModelPanel", GUI_ItemPanel )
				GUI_Item_Icon:SetPos( ScrW() * 0.005, ScrH() * 0.055 )
				GUI_Item_Icon:SetSize( ScreenScale( 90 ), ScreenScale( 35 ) )
				GUI_Item_Icon:SetModel( v.Model )
				GUI_Item_Icon:GetEntity():SetAngles( Angle( -10, 0, 15 ) )
				local mn, mx = GUI_Item_Icon.Entity:GetRenderBounds()
				local size = 0
				size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
				size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
				size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
				GUI_Item_Icon:SetFOV( 45 )
				GUI_Item_Icon:SetCamPos( Vector( size, size, size ) )
				GUI_Item_Icon:SetLookAt( (mn + mx) * 0.5 )
				function GUI_Item_Icon:LayoutEntity( Entity ) return end
				
				-- Vehicle Description
				local GUI_Item_Desc = vgui.Create( "DLabel", GUI_ItemPanel )
				GUI_Item_Desc:SetPos( ScrW() * 0.145, ScrH() * 0.025 )
				GUI_Item_Desc:SetFont( "ARMORY_UIFontText" )
				GUI_Item_Desc:SetColor( Color( 100, 100, 100, 230 ) )
				GUI_Item_Desc:SetText( "Description" )
				GUI_Item_Desc:SizeToContents()
				
				local x, y = surface.GetTextSize( v.Desc )

				local GUI_Item_DescText = vgui.Create( "DLabel", GUI_ItemPanel )
				if x <= 500 then
					GUI_Item_DescText:SetPos( ScrW() * 0.145, ScrH() * 0.03 )
				elseif x <= 1000 then
					GUI_Item_DescText:SetPos( ScrW() * 0.145, ScrH() * 0.04 )
				else
					GUI_Item_DescText:SetPos( ScrW() * 0.145, ScrH() * 0.05 )
				end
				
				GUI_Item_DescText:SetSize( ScrW() * 0.27, ScrH() * 0.055 )
				GUI_Item_DescText:SetFont( "ARMORY_UIFontText" )
				GUI_Item_DescText:SetColor( Color( 230, 230, 230, 230 ) )
				GUI_Item_DescText:SetWrap( true )
				GUI_Item_DescText:SetText( v.Desc )
				
				-- Retrieve/Deposit Button
				local GUI_Retrieve_Item = vgui.Create("DButton", GUI_ItemPanel)
				GUI_Retrieve_Item:SetPos( ScrW() * 0.372, ScrH() * 0.11 )
				GUI_Retrieve_Item:SetSize( ScrW() * 0.075, ScrH() * 0.031 )
				GUI_Retrieve_Item:SetText("")
				GUI_Retrieve_Item.Paint = function( self )
					if CH_Armory_Locker.Config.UseJobRestrictions and CH_Armory_Locker.TeamCategories[ v.Weapon ] and not table.HasValue( CH_Armory_Locker.TeamCategories[ v.Weapon ], team.GetName( LocalPlayer():Team() ) ) then
						self:SetToolTip( "Only the following jobs can retrieve this item: ".. table.concat( CH_Armory_Locker.TeamCategories[ v.Weapon ], ", " ) )
						if self:IsHovered() then
							draw.RoundedBoxEx( 8, 0, 0, self:GetWide(), self:GetTall(), col_restricted_hover, false, false, false, false )
						else
							draw.RoundedBoxEx( 8, 0, 0, self:GetWide(), self:GetTall(), col_restricted, false, false, false, false )
						end
					elseif not LocalPlayer():HasWeapon( v.Weapon ) then
						if self:IsHovered() then
							draw.RoundedBoxEx( 8, 0, 0, self:GetWide(), self:GetTall(), col_light_green, false, false, false, false )
						else
							draw.RoundedBoxEx( 8, 0, 0, self:GetWide(), self:GetTall(), col_green, false, false, false, false )
						end
					else
						if self:IsHovered() then
							draw.RoundedBoxEx( 8, 0, 0, self:GetWide(), self:GetTall(), col_light_red, false, false, false, false )
						else
							draw.RoundedBoxEx( 8, 0, 0, self:GetWide(), self:GetTall(), col_red, false, false, false, false )
						end
					end
					
					local btn_text = "N/A" 
					
					if CH_Armory_Locker.Config.UseJobRestrictions and CH_Armory_Locker.TeamCategories[ v.Weapon ] and not table.HasValue( CH_Armory_Locker.TeamCategories[ v.Weapon ], team.GetName( LocalPlayer():Team() ) ) then
						btn_text = "Item Restricted"
					elseif v.Category == "pistol" or v.Category == "smg" or v.Category == "rifle" or v.Category == "shotgun" or v.Category == "sniper" then
						if LocalPlayer():HasWeapon( v.Weapon ) then
							btn_text = "Deposit Weapon"
						else
							btn_text = "Retrieve Weapon"
						end
					elseif v.Category == "ammo" then
						btn_text = "Retrieve Ammo"
					elseif v.Category == "armor" then
						btn_text = "Retrieve Armor"
					elseif v.Category == "health" then
						btn_text = "Retrieve Health"
					end

					draw.SimpleText( btn_text, "ARMORY_UIFontTextButton", self:GetWide() / 2, self:GetTall() / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				end
				GUI_Retrieve_Item.DoClick = function()
					if CH_Armory_Locker.Config.UseJobRestrictions and CH_Armory_Locker.TeamCategories[ v.Weapon ] and not table.HasValue( CH_Armory_Locker.TeamCategories[ v.Weapon ], team.GetName( LocalPlayer():Team() ) ) then
						return
					end
					
					GUI_Armory_Frame:Remove()
					
					if v.Category == "pistol" or v.Category == "smg" or v.Category == "rifle" or v.Category == "shotgun" or v.Category == "sniper" then
						if LocalPlayer():HasWeapon( v.Weapon ) then
							net.Start( "ARMORY_DepositItem" )
								net.WriteDouble( k )
							net.SendToServer()
						else
							net.Start( "ARMORY_RetrieveItem" )
								net.WriteDouble( k )
							net.SendToServer()
						end
					else
						net.Start( "ARMORY_RetrieveItem" )
							net.WriteDouble( k )
						net.SendToServer()
					end
					
					net.Start("ARM_LOCKER_CloseDoorAnim")
					net.SendToServer()
				end
				
				GUI_Item_Panel:AddItem( GUI_ItemPanel )
			end
		end
	end
end )