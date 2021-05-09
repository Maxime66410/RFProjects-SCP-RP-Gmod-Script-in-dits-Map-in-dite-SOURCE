if !CLIENT then return end

function WasiedAdminSystem.AddInfo()
    local update = net.ReadBool()
    local nooby = net.ReadEntity()
    if !IsValid(nooby) then return end

    if update then
        local tbl = net.ReadTable()
        nooby.refundInformations = tbl
    else
        nooby.refundInformations = nil
    end
end
net.Receive("AdminSystem:RefundMenu:SendToAdmins", WasiedAdminSystem.AddInfo)

function WasiedAdminSystem.OpenRefundMenu()
    
    if !WasiedAdminSystem.Config.RefundMenuEnabled then return end
    if !IsValid(LocalPlayer()) then return end
	if !LocalPlayer():Alive() then return end
    if !WasiedAdminSystem.CheckStaff(LocalPlayer()) then return end
    
    local selectedPlayer
    local rightPanel

    local basicFrame = vgui.Create("WASIED_DFrame")
	basicFrame:SetRSize(1400, 800)
	basicFrame:Center()
	basicFrame:CloseButton(true)
	basicFrame:SetLibTitle(WasiedAdminSystem.Language.RefundMenuTitle.." de "..WasiedAdminSystem.Config.ServerName)
    basicFrame.PaintOver = function(self, w, h)
        draw.SimpleText("Liste des remboursements disponibles", "Righteous30", WasiedLib.RespX(362), WasiedLib.RespY(75), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
        draw.SimpleText("Informations de remboursement", "Righteous30", WasiedLib.RespX(1051), WasiedLib.RespY(75), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    end

    --[[ Left panel ]]--
    local leftPanel = vgui.Create("DPanel", basicFrame)
    leftPanel:SetSize(WasiedLib.RespX(675), WasiedLib.RespY(670))
    leftPanel:SetPos(WasiedLib.RespX(25), WasiedLib.RespY(110))
    function leftPanel:Paint(w, h)
        surface.SetDrawColor(Color(0, 0, 0, 250))
        surface.DrawRect(0, 0, w, h)
    end

    local scrollPanel = vgui.Create("DScrollPanel", leftPanel)
    scrollPanel:Dock(FILL)
    local sbar = scrollPanel:GetVBar()
    function sbar:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(20, 20, 20))
    end
    function sbar.btnUp:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(40, 40, 40))
    end
    function sbar.btnDown:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(40, 40, 40))
    end
    function sbar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(40, 40, 40))
    end

    scrollPanel:Clear()
    local posy = -1
    for k,v in pairs(player.GetAll()) do
        if !IsValid(v) then continue end 
        if !v:Alive() then continue end
        if !v.refundInformations then continue end
        posy = posy + 1

        local plyButton = vgui.Create("WASIED_DButton", scrollPanel)
        plyButton:SetRSize(leftPanel:GetWide()-1, 50)
        plyButton:SetRPos(0, 55*posy)
        plyButton:SetLibText(v:Nick(), color_white)
        plyButton.DoClick = function(self)
            selectedPlayer = v

            if IsValid(rightPanel) then rightPanel:Remove() end

            --[[ Right panel ]]--
            rightPanel = vgui.Create("DPanel", basicFrame)
            rightPanel:SetSize(WasiedLib.RespX(650), WasiedLib.RespY(670))
            rightPanel:SetPos(WasiedLib.RespX(725), WasiedLib.RespY(110))
            function rightPanel:Paint(w, h)
                surface.SetDrawColor(Color(0, 0, 0, 250))
                surface.DrawRect(0, 0, w, h)

                if IsValid(selectedPlayer) && selectedPlayer.refundInformations then

                    draw.SimpleText("Modèle précédent :", "Righteous25", WasiedLib.RespX(20), WasiedLib.RespY(100), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                    draw.SimpleText(selectedPlayer:Nick(), "Righteous35", w/2, WasiedLib.RespY(20), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
                    draw.SimpleText("Argent perdu : "..selectedPlayer.refundInformations.money.."€", "Righteous25", WasiedLib.RespX(20), WasiedLib.RespY(400), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                    draw.SimpleText("Armes perdues :", "Righteous25", WasiedLib.RespX(20), WasiedLib.RespY(430), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                    draw.SimpleText("Job précédent : "..team.GetName(selectedPlayer.refundInformations.job), "Righteous25", WasiedLib.RespX(20), WasiedLib.RespY(510), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

                    draw.SimpleText("Veuillez choisir ce que vous souhaitez rembourser", "Righteous15", WasiedLib.RespX(10), WasiedLib.RespY(550), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

                end
            end

            local pmpanel = vgui.Create("DModelPanel", rightPanel)
            pmpanel:SetSize(rightPanel:GetWide()/2, rightPanel:GetWide()/2)
            pmpanel:SetPos(rightPanel:GetWide()/2-pmpanel:GetWide()/2, WasiedLib.RespX(40))
            if WasiedAdminSystem.Config.RefundPM then pmpanel:SetModel(selectedPlayer.refundInformations.pm) else pmpanel:SetModel(selectedPlayer:GetModel()) end

            local weap = "Fonction actuellement désactivée sur ce serveur."
            if selectedPlayer.refundInformations.weapons then 
                weap = table.concat(selectedPlayer.refundInformations.weapons, ", ")
            end

            local richText = vgui.Create("RichText", rightPanel)
            richText:SetSize(WasiedLib.RespX(580), WasiedLib.RespY(50))
            richText:SetPos(WasiedLib.RespX(20), WasiedLib.RespY(455))
            richText:SetFontInternal("Righteous25")
            richText:AppendText(weap)

            local toRefund = {}
            toRefund.weapons = nil 
            toRefund.money = nil 
            toRefund.job = nil 
            toRefund.PM = nil

            local refundWeap = vgui.Create("WASIED_DButton", rightPanel)
            refundWeap:SetSize(WasiedLib.RespX(150), WasiedLib.RespY(50))
            refundWeap:SetPos(WasiedLib.RespX(10), WasiedLib.RespY(575))
            refundWeap:SetLibText("Armes", color_white)
            refundWeap.clicked = false
            refundWeap.PaintOver = function(self, w, h)
                if self.clicked then
                    surface.SetDrawColor(Color(255, 255, 255, 50))
                    surface.DrawRect(0, 0, w, h)
                end
            end
            refundWeap.DoClick = function(self)
                if !self.clicked then
                    self.clicked = true
                    toRefund.weapons = selectedPlayer.refundInformations.weapons
                else
                    self.clicked = false 
                    toRefund.weapons = nil
                end
            end

            local refundMoney = vgui.Create("WASIED_DButton", rightPanel)
            refundMoney:SetSize(WasiedLib.RespX(150), WasiedLib.RespY(50))
            refundMoney:SetPos(WasiedLib.RespX(165), WasiedLib.RespY(575))
            refundMoney:SetLibText("Argent", color_white)
            refundMoney.clicked = false
            refundMoney.PaintOver = function(self, w, h)
                if self.clicked then
                    surface.SetDrawColor(Color(255, 255, 255, 50))
                    surface.DrawRect(0, 0, w, h)
                end
            end
            refundMoney.DoClick = function(self)
                if !self.clicked then
                    self.clicked = true
                    toRefund.money = selectedPlayer.refundInformations.money
                else
                    self.clicked = false
                    toRefund.money = nil
                end
            end

            local refundJob = vgui.Create("WASIED_DButton", rightPanel)
            refundJob:SetSize(WasiedLib.RespX(150), WasiedLib.RespY(50))
            refundJob:SetPos(WasiedLib.RespX(320), WasiedLib.RespY(575))
            refundJob:SetLibText("Métier", color_white)
            refundJob.clicked = false
            refundJob.PaintOver = function(self, w, h)
                if self.clicked then
                    surface.SetDrawColor(Color(255, 255, 255, 50))
                    surface.DrawRect(0, 0, w, h)
                end
            end
            refundJob.DoClick = function(self)
                if !self.clicked then
                    self.clicked = true
                    toRefund.job = selectedPlayer.refundInformations.job
                else
                    self.clicked = false 
                    toRefund.job = nil
                end
            end

            local refundPM = vgui.Create("WASIED_DButton", rightPanel)
            refundPM:SetSize(WasiedLib.RespX(150), WasiedLib.RespY(50))
            refundPM:SetPos(WasiedLib.RespX(475), WasiedLib.RespY(575))
            refundPM:SetLibText("Modèle", color_white)
            refundPM.clicked = false
            refundPM.PaintOver = function(self, w, h)
                if self.clicked then
                    surface.SetDrawColor(Color(255, 255, 255, 50))
                    surface.DrawRect(0, 0, w, h)
                end
            end
            refundPM.DoClick = function(self)  
                if !self.clicked then
                    self.clicked = true
                    toRefund.PM = selectedPlayer.refundInformations.pm
                else
                    self.clicked = false 
                    toRefund.PM = nil
                end
            end

            local send = vgui.Create("DButton", rightPanel)
            send:SetSize(WasiedLib.RespX(400), WasiedLib.RespY(35))
            send:SetPos(rightPanel:GetWide()/2-send:GetWide()/2, rightPanel:GetTall()-send:GetTall()-WasiedLib.RespY(5))
            send:SetText("")
            send.Paint = function(self, w, h)
                if self:IsHovered() then
                    draw.SimpleText("Cliquez ici pour valider votre sélection", "Righteous20", w/2, h/2, Color(40, 255, 40), 1, 1)
                else
                    draw.SimpleText("Cliquez ici pour valider votre sélection", "Righteous20", w/2, h/2, color_white, 1, 1)
                end
            end
            send.DoClick = function(self)
                if istable(toRefund) && toRefund then
                    net.Start("AdminSystem:RefundMenu:RefundThings")
                        net.WriteEntity(selectedPlayer)
                        net.WriteTable(toRefund)
                    net.SendToServer()
                    if IsValid(basicFrame) then basicFrame:Remove() end
                end
            end

        end

        local delete = vgui.Create("DImageButton", plyButton)
        delete:SetSize(WasiedLib.RespX(15), WasiedLib.RespY(15))
        delete:SetPos(WasiedLib.RespX(10), plyButton:GetTall()/2-delete:GetTall()/2)
        delete:SetImage("icon16/cross.png")
        delete.DoClick = function()
            if IsValid(basicFrame) then basicFrame:Remove() end
            if IsValid(selectedPlayer) then selectedPlayer.refundInformations = nil end
        end

    end
    
end
net.Receive("AdminSystem:RefundMenu:Open", WasiedAdminSystem.OpenRefundMenu)