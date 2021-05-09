if !CLIENT then return end

--[[
La configuration des boutons, c'est par ici !
Tu peux descendre un peu et créer tes propres boutons en faisant bien attention.

ATTENTION : Aucun support n'est fourni pour des erreurs suite à une de vos modifications !

Si vous souhaitez ajouter des fonctions au script, vous pouvez venir me trouver sur Discord et je ferai ça en échange d'une petite rémunération.
]]--


local function TranslateDate(val, toTranslate)

    if !isnumber(val) then return "0" end

    if toTranslate == "Année(s)" then
        return val * 365 * 24 * 60
    elseif toTranslate == "Mois" then
        return val * 30 * 24 * 60
    elseif toTranslate == "Semaine(s)" then
        return val * 7 * 24 * 60
    elseif toTranslate == "Jour(s)" then
        return val * 24 * 60
    elseif toTranslate == "Heure(s)" then
        return val * 60
    end
    return val

end

local basicFrame
local banFrame
local infoFrame

local function ClosePanels()
    if IsValid(basicFrame) then basicFrame:Remove() end
    if IsValid(banFrame) then banFrame:Remove() end
    if IsValid(infoFrame) then infoFrame:Remove() end
end

-- Vous pouvez configurer ici les boutons qui seront affichés dans le menu de gestion ainsi que leur fonction
-- N'hésitez pas à me les envoyer pour faire profiter tout le monde, merci :D
WasiedAdminSystem.Config.Buttons = {
    [0] = {
        title = "Bannir du serveur",
        onClick = function(self)
            local ply = basicFrame.selectedPlayer

            --if ply == LocalPlayer() then return end
            if IsValid(banFrame) then banFrame:Remove() end

            banFrame = vgui.Create("WASIED_DFrame")
            banFrame:SetRSize(500, 515)
            banFrame:SetRPos(50, 115)
            banFrame:CloseButton(false)
            banFrame:SetLibTitle("Détails du bannissement")
            banFrame.PaintOver = function(self, w, h)
                draw.SimpleText("Raison du bannissement", "Righteous25", WasiedLib.RespX(25), WasiedLib.RespY(98), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
                draw.SimpleText("Durée du bannissement", "Righteous25", WasiedLib.RespX(25), WasiedLib.RespY(340), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
                draw.SimpleText("(0 pour permanent)", "Righteous18", WasiedLib.RespX(25), WasiedLib.RespY(357), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
            end

            local reasonEntry = vgui.Create("DTextEntry", banFrame)
            reasonEntry:SetSize(WasiedLib.RespX(450), WasiedLib.RespY(200))
            reasonEntry:SetPos(WasiedLib.RespX(25), WasiedLib.RespY(100))
            reasonEntry:SetMultiline(true)
            reasonEntry:SetFont("Righteous20")
            reasonEntry:SetValue("Non-respect des règles")
            reasonEntry.IsSendable = true
            function reasonEntry:OnChange()
                local reason = self:GetValue()
                if string.len(reason) > 2 && string.len(reason) < WasiedAdminSystem.Config.PlayerManagMaxLen then
                    self.IsSendable = true
                else
                    self.IsSendable = false
                end
            end

            local banTime_maxCharact = 17
            local timeEntry = vgui.Create("DTextEntry", banFrame)
            timeEntry:SetSize(WasiedLib.RespX(350), WasiedLib.RespY(60))
            timeEntry:SetPos(WasiedLib.RespX(15), WasiedLib.RespY(362))
            timeEntry:SetMultiline(true)
            timeEntry:SetNumeric(true)
            timeEntry:SetFont("Righteous50")
            timeEntry:SetValue(0)
            timeEntry.IsSendable = true
            function timeEntry:OnChange()
                local time = tostring(self:GetValue())
                if string.len(time) > 0 && string.len(time) < banTime_maxCharact then
                    self.IsSendable = true
                else
                    self.IsSendable = false
                end
            end

            local timeOption = vgui.Create("WASIED_DComboBox", banFrame)
            timeOption:SetRSize(110, 60)
            timeOption:SetRPos(375, 362)
            timeOption:SetValue("Minute(s)")
            timeOption:AddChoice("Année(s)")
            timeOption:AddChoice("Mois")
            timeOption:AddChoice("Semaine(s)")
            timeOption:AddChoice("Jour(s)")
            timeOption:AddChoice("Heure(s)")
            timeOption:AddChoice("Minute(s)")
            timeOption:SetFont("Righteous21")
            timeOption:SetTextColor(color_white)

            local sendButton = vgui.Create("WASIED_DButton", banFrame)
            sendButton:SetRSize(450, 50)
            sendButton:SetRPos(25, 440)
            sendButton:SetLibText("Sanctionner", color_white)
            sendButton.DoClick = function(self)

                if !IsValid(ply) then return end
                
                local time = TranslateDate(tonumber(timeEntry:GetValue()), timeOption:GetSelected())

                if timeEntry.IsSendable && reasonEntry.IsSendable then
                    local reason = reasonEntry:GetValue()
                    if IsValid(ply) && isnumber(time) && isstring(reason) && WasiedAdminSystem.ULXorFAdmin() then
                        LocalPlayer():ConCommand("ulx banid "..ply:SteamID().." "..tostring(time).." "..reason)
                    else
                        time = tostring(time)
                        LocalPlayer():ConCommand('FAdmin ban "'..ply:Nick()..'" '..time..' '..reason)
                    end
                    WasiedAdminSystem.AdminLogging(LocalPlayer(), "a banni "..ply:Nick().." pour "..reason.." pendant "..time.." minutes !")
                    ClosePanels()
                else
                    chat.AddText(Color(255, 40, 40), "[Admin System] Le temps indiqué et/ou la raison du bannissement est invalide !")
                end


            end

        end,
    },
    [1] = {
        title = "Exclure du serveur",
        onClick = function(self)
            local ply = basicFrame.selectedPlayer

            --if ply == LocalPlayer() then return end
            if IsValid(banFrame) then banFrame:Remove() end

            banFrame = vgui.Create("WASIED_DFrame")
            banFrame:SetRSize(500, 400)
            banFrame:SetRPos(50, 115)
            banFrame:CloseButton(false)
            banFrame:SetLibTitle("Détails du kick")
            banFrame.PaintOver = function(self, w, h)
                draw.SimpleText("Raison du kick", "Righteous25", WasiedLib.RespX(25), WasiedLib.RespY(108), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
            end

            local reasonEntry = vgui.Create("DTextEntry", banFrame)
            reasonEntry:SetSize(WasiedLib.RespX(450), WasiedLib.RespY(200))
            reasonEntry:SetPos(WasiedLib.RespX(25), WasiedLib.RespY(110))
            reasonEntry:SetMultiline(true)
            reasonEntry:SetFont("Righteous20")
            reasonEntry:SetValue("Non-respect des règles")
            reasonEntry.IsSendable = true
            function reasonEntry:OnChange()
                local reason = self:GetValue()
                if string.len(reason) > 2 && string.len(reason) < WasiedAdminSystem.Config.PlayerManagMaxLen then
                    self.IsSendable = true
                else
                    self.IsSendable = false
                end
            end

            local sendButton = vgui.Create("WASIED_DButton", banFrame)
            sendButton:SetRSize(450, 50)
            sendButton:SetRPos(25, 325)
            sendButton:SetLibText("Sanctionner", color_white)
            sendButton.DoClick = function(s)

                if !IsValid(ply) then return end

                if reasonEntry.IsSendable then
                    local reason = reasonEntry:GetValue()
                    if IsValid(ply) && isnumber(time) && isstring(reason) && WasiedAdminSystem.ULXorFAdmin() then
                        LocalPlayer():ConCommand('ulx kick "'..ply:Nick()..'" '..reason)
                    else
                        LocalPlayer():ConCommand('FAdmin kick "'..ply:Nick()..'" '..reason)
                    end
                    WasiedAdminSystem.AdminLogging(LocalPlayer(), "a exclu "..ply:Nick().." pour "..reason.." !")
                    ClosePanels()
                else
                    chat.AddText(Color(255, 40, 40), "[Admin System] Le temps indiqué et/ou la raison du kick est invalide !")
                end


            end

        end,
    },
    [2] = {
        title = "Rejoindre le joueur",
        onClick = function(self)
            local ply = basicFrame.selectedPlayer

            if IsValid(ply) then
                if WasiedAdminSystem.ULXorFAdmin() then
                    LocalPlayer():ConCommand("ulx goto $"..ply:SteamID())
                else
                    LocalPlayer():ConCommand("FAdmin goto "..ply:Nick())
                end
            end

        end,
    },
    [3] = {
        title = "Téléporter le joueur",
        onClick = function(self)
            local ply = basicFrame.selectedPlayer

            if IsValid(ply) then
                if WasiedAdminSystem.ULXorFAdmin() then
                    LocalPlayer():ConCommand("ulx teleport $"..ply:SteamID())
                else
                    LocalPlayer():ConCommand("FAdmin teleport "..ply:Nick())
                end
            end

        end,
    },
    [4] = {
        title = "Rendre invincible",
        onClick = function(self)
            local ply = basicFrame.selectedPlayer

            if IsValid(ply) then
                if WasiedAdminSystem.ULXorFAdmin() then
                    LocalPlayer():ConCommand("ulx god $"..ply:SteamID())
                else
                    LocalPlayer():ConCommand("FAdmin god "..ply:Nick())
                end
            end

        end,
    },
    [5] = {
        title = "Rendre vulnérable",
        onClick = function(self)
            local ply = basicFrame.selectedPlayer

            if IsValid(ply) then
                if WasiedAdminSystem.ULXorFAdmin() then
                    LocalPlayer():ConCommand("ulx ungod $"..ply:SteamID())
                else
                    LocalPlayer():ConCommand("FAdmin ungod "..ply:Nick())
                end
            end

        end,
    },
    [6] = {
        title = "Geler",
        onClick = function(self)
            local ply = basicFrame.selectedPlayer

            if IsValid(ply) then
                if WasiedAdminSystem.ULXorFAdmin() then
                    LocalPlayer():ConCommand("ulx freeze $"..ply:SteamID())
                else
                    LocalPlayer():ConCommand("FAdmin freeze "..ply:Nick())
                end
            end

        end,
    },
    [7] = {
        title = "Dégeler",
        onClick = function(self)
            local ply = basicFrame.selectedPlayer

            if IsValid(ply) then
                if WasiedAdminSystem.ULXorFAdmin() then
                    LocalPlayer():ConCommand("ulx unfreeze $"..ply:SteamID())
                else
                    LocalPlayer():ConCommand("FAdmin unfreeze "..ply:Nick())
                end
            end

        end,
    },
    [8] = {
        title = "Copier SteamID",
        onClick = function(self)
            local ply = basicFrame.selectedPlayer

            if IsValid(ply) then
                SetClipboardText(ply:SteamID())
            end

        end,
    },
    [9] = {
        title = "Profil Steam",
        onClick = function(self)
            local ply = basicFrame.selectedPlayer

            if IsValid(ply) then
                local steamprofile = ""..ply:SteamID64().."/"
                gui.OpenURL(steamprofile)
            end

        end,
    },
}

function WasiedAdminSystem.OpenManagmentMenu()

    if !WasiedAdminSystem.Config.PlayerManagmentEnabled then return end
    if !IsValid(LocalPlayer()) then return end
	if !LocalPlayer():Alive() then return end
    if !WasiedAdminSystem.CheckStaff(LocalPlayer()) then return end

    basicFrame = vgui.Create("WASIED_DFrame")
	basicFrame:SetRSize(800, 850)
	basicFrame:Center()
	basicFrame:CloseButton(true)
    basicFrame.selectedPlayer = nil
	basicFrame:SetLibTitle(WasiedAdminSystem.Language.PlayerManagTitle.." de "..WasiedAdminSystem.Config.ServerName)

    local closeButton = vgui.Create("DImageButton", basicFrame)
    closeButton:SetSize(WasiedLib.RespX(20), WasiedLib.RespY(20))
    closeButton:SetPos(basicFrame:GetWide()-closeButton:GetWide()-WasiedLib.RespX(5), WasiedLib.RespY(5))
    closeButton:SetText("")
    closeButton:SetImage("icon16/cross.png")
    closeButton.DoClick = function(self)
        ClosePanels()
    end

    --[[ Right panel ]]--
    local leftPanel = vgui.Create("DPanel", basicFrame)
    leftPanel:SetSize(WasiedLib.RespX(375), WasiedLib.RespY(700))
    leftPanel:SetPos(WasiedLib.RespX(400), WasiedLib.RespY(100))
    function leftPanel:Paint(w, h)
        surface.SetDrawColor(Color(0, 0, 0, 250))
        surface.DrawRect(0, 0, w, h)
    
        surface.SetDrawColor(color_white)
        surface.DrawOutlinedRect(0, 0, w, h)
    end

    --[[ Left panel (je sais que je me suis trompé dans les noms)]]--
    local rightPanel = vgui.Create("DPanel", basicFrame)
    rightPanel:SetSize(WasiedLib.RespX(350), WasiedLib.RespY(700))
    rightPanel:SetPos(WasiedLib.RespX(25), WasiedLib.RespY(100))
    function rightPanel:Paint(w, h)
        surface.SetDrawColor(Color(0, 0, 0, 250))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(color_white)
        surface.DrawOutlinedRect(0, 0, w, h)
    end

    local scrollPanel = vgui.Create("DScrollPanel", rightPanel)
    scrollPanel:Dock(FILL)

    local sbar = scrollPanel:GetVBar()
    function sbar:Paint(w, h)
        surface.SetDrawColor(Color(0, 0, 0))
        surface.DrawRect(0, 0, w, h)
    end
    function sbar.btnUp:Paint(w, h)
        surface.SetDrawColor(Color(30, 30, 30))
        surface.DrawRect(0, 0, w, h)
    end
    function sbar.btnDown:Paint(w, h)
        surface.SetDrawColor(Color(30, 30, 30))
        surface.DrawRect(0, 0, w, h)
    end
    function sbar.btnGrip:Paint(w, h)
        surface.SetDrawColor(Color(30, 30, 30))
        surface.DrawRect(0, 0, w, h)
    end

    for k,v in pairs(player.GetAll()) do
        if !IsValid(v) then continue end
        --if basicFrame.selectedPlayer == v then continue end
        
        local plyButton = vgui.Create("DButton", scrollPanel)
        plyButton:SetSize(WasiedLib.RespX(350), WasiedLib.RespY(45))
        if k > 1 then plyButton:SetPos(0, WasiedLib.RespX(45)*(k-1)) end
        plyButton:SetText("")
        function plyButton:Paint(w, h)
            if self:IsHovered() or basicFrame.selectedPlayer == v then
                surface.SetDrawColor(Color(50, 50, 50))
            else
                surface.SetDrawColor(Color(40, 40, 40))
            end

            surface.DrawRect(1, 1, w-2, h-2)

            surface.SetDrawColor(color_white)
            surface.DrawLine(0, h-1, w, h-1)
            
            if IsValid(v) then draw.SimpleText(v:Nick(), "Righteous22", w/2, h/2, color_white, 1, 1) end
        end
        
        local bscrollPanel 
        plyButton.DoClick = function(self)

            if !IsValid(v) then return end

            if v == basicFrame.selectedPlayer then

                if IsValid(infoFrame) then
                    infoFrame:Remove()
                end

                if IsValid(bscrollPanel) then 
                    bscrollPanel:Clear() 
                end

                basicFrame.selectedPlayer = nil
            
            else
            
                basicFrame.selectedPlayer = v

                local selectedPlayer = basicFrame.selectedPlayer
                if !IsValid(selectedPlayer) then return end

                local job = team.GetName(selectedPlayer:Team()) or "Aucun"
                local rank = selectedPlayer:GetUserGroup() or "user"
                local money = selectedPlayer:getDarkRPVar("money") or 0

                if IsValid(infoFrame) then infoFrame:Remove() end

                infoFrame = vgui.Create("WASIED_DFrame")
                infoFrame:SetRSize(500, 850)
                infoFrame:SetRPos(1370, 115)
                infoFrame:CloseButton(false)
                infoFrame:SetLibTitle(selectedPlayer:Nick())
                infoFrame.PaintOver = function(self, w, h)

                    draw.SimpleText("Rang : "..rank, "Righteous30", w/2, WasiedLib.RespY(560), color_white, 1, 1)
                    draw.SimpleText("Métier : "..job, "Righteous30", w/2, WasiedLib.RespY(600), color_white, 1, 1)
                    draw.SimpleText("Argent : "..money.."€", "Righteous30", w/2, WasiedLib.RespY(640), color_white, 1, 1)
                end

                if !IsValid(selectedPlayer) then return end
                local plyMdl = LocalPlayer():GetModel() or LocalPlayer():GetModel()

                local playermodel = vgui.Create("DModelPanel", infoFrame)
                playermodel:SetSize(infoFrame:GetWide(), infoFrame:GetWide())
                playermodel:SetPos(0, WasiedLib.RespY(50))
                playermodel:SetModel(plyMdl)

                --[[ Right panel ]]--
                if IsValid(bscrollPanel) then bscrollPanel:Clear() end
                bscrollPanel = vgui.Create("DScrollPanel", leftPanel)
                bscrollPanel:Dock(FILL)

                local sbar = bscrollPanel:GetVBar()
                function sbar:Paint(w, h)
                end
                function sbar.btnUp:Paint(w, h)
                end
                function sbar.btnDown:Paint(w, h)
                end
                function sbar.btnGrip:Paint(w, h)
                end

                for key,butt in pairs(WasiedAdminSystem.Config.Buttons) do

                    local commandButton = vgui.Create("WASIED_DButton", bscrollPanel)
                    commandButton:SetRSize(325, 45)
                    commandButton:SetRPos(25, 55*key+25)
                    commandButton:SetLibText(butt.title, color_white)
                    commandButton.DoClick = butt.onClick

                end

            end

        end

    end
    
end
net.Receive("AdminSystem:PlayerManag:Open", WasiedAdminSystem.OpenManagmentMenu)