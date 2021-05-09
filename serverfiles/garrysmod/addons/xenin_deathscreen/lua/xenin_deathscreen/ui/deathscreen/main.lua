local PANEL = {}

local i18n = XeninDS.i18n

XeninUI:CreateFont("XeninDS.Deathscreen.Respawn", 16)
XeninUI:CreateFont("XeninDS.Deathscreen.Message", 20)

PANEL.Hide = {
  ["DarkRP_HUD"] = true,
  ["DarkRP_EntityDisplay"] = true,
  ["DarkRP_LocalPlayerHUD"] = true,
  ["DarkRP_Hungermod"] = true,
  ["DarkRP_Agenda"] = true,
  ["DarkRP_LockdownHUD"] = true,
  ["DarkRP_ArrestedHUD"] = true,
  ["DarkRP_ChatReceivers"] = true,
  ["CHudHealth"] = true,
  ["CHudBattery"] = true,
  ["CHudAmmo"] = true,
  ["CHudSecondaryAmmo"] = true,
  ["CHudDamageIndicator"] = true
}

function PANEL:Init()
  XeninDS.Frame = self

  self:SetSize(ScrW(), ScrH())

  self.Colour = 0
  self.ScreenspaceEffects = {
    ["$pp_colour_addr"] = 0,
    ["$pp_colour_addg"] = 0,
    ["$pp_colour_addb"] = 0,
    ["$pp_colour_brightness"] = 0,
    ["$pp_colour_contrast"] = 1,
    ["$pp_colour_colour"] = self.Colour,
    ["$pp_colour_mulr"] = 0,
    ["$pp_colour_mulg"] = 0,
    ["$pp_colour_mulb"] = 0
  }

  self.BlackAlpha = 255
  self:Lerp("BlackAlpha", 0, 1, nil, XeninUI.Ease2)

  if XeninDS.Config:get("grey_filter") then
    self:AddHook("RenderScreenspaceEffects", "XeninDS", function(self)
      DrawColorModify(self.ScreenspaceEffects)
    end)
  end

  self:AddHook("HUDShouldDraw", "XeninDS", function(self, name)
    if self.Hide[name] then return false end
  end)

  self.Created = CurTime()

  if (!XeninDS.Config:get("respawn_timer_enabled")) then return end

  self.CloseAt = CurTime() + XeninDS.Config:getRespawnTime(LocalPlayer())
end

function PANEL:DoRemove()
  if (self.IsRemoving) then return end
  self.IsRemoving = true

  local smoothCam = XeninDS.Config:get("smooth_respawn_cam") and self.Card.Data.tag == XENINDS_TAG_PLAYER
  local time = smoothCam and 2 or 0.8

  self:Lerp("Colour", 1, time)
  self.Think = function()
    self.ScreenspaceEffects["$pp_colour_colour"] = self.Colour end
  self.Alpha = 255
  self:LerpAlpha(0, time, function()
    self:Remove()
  end)

  local hooks = self.Card.hooks or {}
  for i, v in pairs(hooks) do
    if (v.name != "CalcView") then continue end

    hook.Remove(v.name, i)
  end

  if (self.Card.Data.tag != XENINDS_TAG_PLAYER) then return end
  if (!XeninDS.Config:get("smooth_respawn_cam")) then return end
  if (!istable(self.Card.cw)) then return end

  self.pos = self.Card.cw.lastPos
  self.fov = self.Card.cw.lastFov
  self.ang = self.Card.cw.lastAng

  self:AddHook("CalcView", "XeninDS.Transition", function(self, ply, pos, angles, fov)
    if (!self.InitialLerp) then
      self:Lerp("fov", fov, time)
      self:LerpVector("pos", pos, time)
      self:LerpAngle("ang", angles, time)

      self.InitialLerp = true
    end

    local view = {}
    view.origin = self.pos
    view.angles = self.ang
    view.fov = self.fov

    return view
  end)
end

function PANEL:Think()
  if (self.CloseAt and self.CloseAt < CurTime()) then
    self:DoRemove()
  end

  if (self.Created + 1 < CurTime()) then
    if LocalPlayer():Alive() then
      if ((MedConfig and MedConfig.XeninDS) and LocalPlayer().IsKnocked and LocalPlayer():IsKnocked()) then return end

      self:DoRemove()
    end
  end
end

function PANEL:SetData(data)
  self.Start = CurTime()
  self.End = self.Start + data.respawnTime
  self.Container = self:Add("Panel")

  self.Message = self.Container:Add("DPanel")
  self.Message:Dock(TOP)
  self.Message:DockMargin(0, 0, 0, 8)
  self.Message.Paint = function(pnl, w, h)
    XeninUI:DrawShadowText(data.msg, "XeninDS.Deathscreen.Message", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, 180)
  end

  self.Card = self.Container:Add("XeninDS.Card")
  self.Card:Dock(TOP)
  self.Card:DockMargin(0, 0, 0, 8)
  self.Card:SetData(data)

  local dmg = data.damage
  if dmg then
    dmg.victim.dmg = dmg.victim.dmg or 0
    dmg.victim.hits = dmg.victim.hits or 0

    dmg.attacker.dmg = dmg.attacker.dmg or 0
    dmg.attacker.hits = dmg.attacker.hits or 0

    self.Damage = self.Container:Add("DPanel")
    self.Damage:Dock(TOP)
    self.Damage:DockMargin(0, 0, 0, 8)
    local g, w, e = "<color=182, 182, 182>", "<color=255,255,255>", "</color>"
    local dealtPlural = dmg.victim.hits != 1 and i18n:get("card.hits.plural", nil, "hits") or i18n:get("card.hits.singular", nil, "hit")
    local receivedPlural = dmg.attacker.hits != 1 and i18n:get("card.hits.plural", nil, "hits") or i18n:get("card.hits.singular", nil, "hit")
    local phrase = i18n:get("card.dmg", {
      dealtDmg = tostring(e) .. tostring(w) .. tostring(dmg.victim.dmg) .. tostring(e) .. tostring(g),
      dealtHits = tostring(e) .. tostring(w) .. tostring(dmg.victim.hits) .. tostring(e) .. tostring(g) .. " " .. tostring(dealtPlural) .. tostring(e) .. tostring(g),
      receivedDmg = tostring(e) .. tostring(w) .. tostring(dmg.attacker.dmg) .. tostring(e) .. tostring(g),
      receivedHits = tostring(e) .. tostring(w) .. tostring(dmg.attacker.hits) .. tostring(e) .. tostring(g) .. " " .. tostring(receivedPlural)
    }, "You dealt :dealtDmg: damage in :dealtHits: and received :receivedDmg: damage in :receivedHits:.")
    self.Damage.Parse = markup.Parse("<font=XeninDS.Deathscreen.Respawn>" .. tostring(g) .. tostring(phrase) .. tostring(e) .. "</font>")
    self.Damage.Paint = function(pnl, w, h)
      XeninUI:DrawRoundedBox(6, 0, 0, w, h, XeninUI.Theme.Primary)

      pnl.Parse:Draw(w / 2, h / 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
  end

  if (!XeninDS.Config:get("respawn_ui_enabled") or XeninDS.Config:get("respawn_timer_enabled")) then return end

  self.Respawn = self.Container:Add("DPanel")
  self.Respawn:Dock(BOTTOM)
  self.Respawn.Parse = function(pnl)
    local g, w, e = "<color=182, 182, 182>", "<color=255,255,255>", "</color>"
    local seconds = math.Round(self.End - CurTime())
    if (seconds == 0) then
      local key = i18n:get("card.respawn.skip.key", nil, "SPACE")
      local skip = i18n:get("card.respawn.skip.msg", {
      key = tostring(e) .. tostring(w) .. tostring(key) .. tostring(e) .. tostring(g)
      }, "Press :key: to respawn")

      pnl.Parsed = markup.Parse("<font=XeninDS.Deathscreen.Respawn>" .. tostring(g) .. tostring(skip) .. tostring(e) .. "</font>")

      return
    end

    local secondType = seconds != 1 and "plural" or "singular"
    local secondsStr = i18n:get("card.respawn." .. tostring(secondType), nil, "second(s)")
    local str = i18n:get("card.respawn.msg", {
    time = tostring(e) .. tostring(w) .. tostring(seconds) .. " " .. tostring(secondsStr) .. tostring(e)
    }, "Respawning in :time:")
    pnl.Parsed = markup.Parse("<font=XeninDS.Deathscreen.Respawn>" .. tostring(g) .. tostring(str) .. tostring(e) .. "</font>")
  end
  if (data.respawnTime > 0) then
    self.Respawn:AddTimer("Deathscreen.Parse", 1, data.respawnTime, function(self)
      self:Parse()
    end)
  end
  self.Respawn:Parse()
  self.Respawn.Paint = function(pnl, w, h)
    XeninUI:DrawRoundedBox(6, 0, 0, w, h, XeninUI.Theme.Primary)

    local barHeight = 6
    XeninUI:DrawRoundedBoxEx(6, 0, h - barHeight, w, barHeight, XeninUI.Theme.Background, false, false, true, true)
    local frac = math.TimeFraction(self.Start, self.End, CurTime())
    local width = frac * w
    if (data.respawnTime <= 0) then
      width = w
    end
    local aX, aY = pnl:LocalToScreen()
    render.SetScissorRect(aX, aY, aX + width, aY + h, true)
    XeninUI:DrawRoundedBoxEx(6, 0, h - barHeight, w, barHeight, XeninUI.Theme.Green, false, false, true, true)
    render.SetScissorRect(0, 0, ScrW(), ScrH(), false)

    pnl.Parsed:Draw(w / 2, h / 2 - barHeight / 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
  end
end

function PANEL:PaintOver(w, h)
  surface.SetDrawColor(0, 0, 0, self.BlackAlpha)
  surface.DrawRect(0, 0, w, h)
end

function PANEL:PerformLayout(w, h)
  self.Container:SetWide(517)

  self.Message:SetTall(24)
  self.Card:SetTall(129)
  if IsValid(self.Damage) then
    self.Damage:SetTall(32)
  end
  if IsValid(self.Respawn) then
    self.Respawn:SetTall(32)
  end

  local height = 0
  for i, v in ipairs(self.Container:GetChildren()) do
    height = height + v:GetTall()
    local l, t, r, b = v:GetDockMargin()

    height = height + (t + b)
  end

  local pos = XeninDS.Config:get("card_position", "bottom")
  local margin = XeninDS.Config:get("card_margin", 32)

  self.Container:SetTall(height)
  self.Container:CenterHorizontal()
  if (pos == "top") then
    self.Container:AlignTop(margin)
  elseif (pos == "middle") then
    self.Container:CenterVertical()
  else
    self.Container:AlignBottom(margin)
  end
end

vgui.Register("XeninDS.Frame", PANEL)

function XeninDS:Deathscreen(tbl)
  if (!tbl) then return end
  if IsValid(XeninDS.Frame) then
    XeninDS.Frame:Remove()
  end

  vgui.Create("XeninDS.Frame"):SetData(tbl)
end
