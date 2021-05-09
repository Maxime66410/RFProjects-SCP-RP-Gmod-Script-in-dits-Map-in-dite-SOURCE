local PANEL = {}
local i18n = XeninDS.i18n

function PANEL:Init()
  XeninDS.Killfeed = self

  self:SetSize(ScrW(), ScrH())

  self.Alpha = 0
  self:LerpAlpha(255, 0.5)

  timer.Simple(XeninDS.Config:get("killfeed_time", 3), function()
    if (!IsValid(self)) then return end

    self:LerpAlpha(0, 0.5, function()
      self:Remove()

      LocalPlayer():XeninDeathscreen():getKillfeed():next()
    end)
  end)
end

function PANEL:SetData(data)
  self.Container = self:Add("Panel")

  self.Message = self.Container:Add("DPanel")
  self.Message:Dock(TOP)
  self.Message:DockMargin(0, 0, 0, 8)
  self.Message.Paint = function(pnl, w, h)
    XeninUI:DrawShadowText(i18n:get("killfeed.killed", nil, "You killed"), "XeninDS.Deathscreen.Message", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, 180)
  end

  self.Card = self.Container:Add("XeninDS.Card")
  self.Card:Dock(TOP)
  self.Card:DockMargin(0, 0, 0, 8)
  self.Card:SetData(data)

  local dmg = data.damage
  if dmg then
    dmg.dmg = dmg.dmg or 0
    dmg.hits = dmg.hits or 0

    self.Damage = self.Container:Add("DPanel")
    self.Damage:Dock(TOP)
    self.Damage:DockMargin(0, 0, 0, 8)
    local g, w, e = "<color=182, 182, 182>", "<color=255,255,255>", "</color>"
    local dealtPlural = dmg.hits != 1 and i18n:get("card.hits.plural", nil, "hits") or i18n:get("card.hits.singular", nil, "hit")
    local phrase = i18n:get("killfeed.dmg", {
      dealtDmg = tostring(e) .. tostring(w) .. tostring(dmg.dmg) .. tostring(e) .. tostring(g),
      dealtHits = tostring(e) .. tostring(w) .. tostring(dmg.hits) .. tostring(e) .. tostring(g) .. " " .. tostring(dealtPlural) .. tostring(e) .. tostring(g)
    }, "You dealt :dealtDmg: damage in :dealtHits:.")
    self.Damage.Parse = markup.Parse("<font=XeninDS.Deathscreen.Respawn>" .. tostring(g) .. tostring(phrase) .. tostring(e) .. "</font>")
    self.Damage.Paint = function(pnl, w, h)
      XeninUI:DrawRoundedBox(6, 0, 0, w, h, XeninUI.Theme.Primary)

      pnl.Parse:Draw(w / 2, h / 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
  end
end

function PANEL:PerformLayout(w, h)
  self.Container:SetWide(414)

  self.Message:SetTall(24)
  self.Card:SetTall(103)
  if IsValid(self.Damage) then
    self.Damage:SetTall(32)
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

vgui.Register("XeninDS.Killfeed", PANEL)

function XeninDS:QueueKillfeed(tbl)
  if IsValid(XeninDS.Killfeed) then
    XeninDS.Killfeed:Remove()
  end

  vgui.Create("XeninDS.Killfeed"):SetData(tbl)
end
