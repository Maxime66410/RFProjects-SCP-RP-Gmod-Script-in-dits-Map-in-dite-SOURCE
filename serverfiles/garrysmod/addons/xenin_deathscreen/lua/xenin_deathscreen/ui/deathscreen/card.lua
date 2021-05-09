local PANEL = {}

local i18n = XeninDS.i18n

XeninUI:CreateFont("XeninDS.Card.Name", 20)
XeninUI:CreateFont("XeninDS.Card.Info", 16)
XeninUI:CreateFont("XeninDS.Card.Suicide", 24)

function PANEL:SetData(data)
  self.Config = XeninDS.Config

  self.Data = data
  if (IsValid(data.wep) and data.wep != NULL) then
    local entClass = data.wep:GetClass()
    local tbl = weapons.Get(entClass)
    if tbl then
      local col = Color(242, 242, 242)
      if XeninInventory then
        col = XeninInventory.Config.Categories[XeninInventory:GetRarity(entClass)].color

        col = XeninUI:GetContrastColor(XeninUI.Theme.Primary, col, color_white)


        if (col.r == 125 and col.g == 125 and col.b == 125) then
          col = Color(242, 242, 242)
        end
      end
      self.Data.wep = {
        name = tbl.PrintName or (data.wep.GetPrintName and data.wep:GetPrintName()) or tbl.Name or tbl.WeaponName,
        entClass = entClass,
        col = col
      }
      if LANG then
        self.Data.wep.name = LANG.TryTranslation(self.Data.wep.name)
      end
    end
  end

  if data.ply then
    self.Avatar = self:Add("XeninUI.Avatar")
    self.Avatar:SetPlayer(data.ply.object, 128)
    self.Avatar:SetVertices(90)
    self.Avatar:SetZPos(2)
    local oldPaint = self.Avatar.Paint
    self.Avatar.Paint = function(pnl, w, h)
      DisableClipping(true)
      for i = 1, 2 do
        XeninUI:DrawCircle(8 + h / 2, h / 2, h / 2 + i, 90, Color(0, 0, 0, i * 125))
      end
      DisableClipping(false)

      oldPaint(pnl, w, h)
    end

    self.Usergroup = XeninDS.Config:getUsergroup(data.ply.object)
  end

  if (!self.Data.card) then
    local id = table.Random(XeninDS.Config:get("suicide_src", {
    "OaHa1fJ" }))
    self:DownloadIcon(id)
  else
    if self.Data.animated then
      local card = XeninDS.Config:getCard(self.Data.card)
      if (!card) then
        self:DownloadIcon(table.Random(XeninDS.Config:get("world_src", {
        "OaHa1fJ" })))
      else
        self.Animated = self:Add("XeninUI.AnimatedTexture")
        self.Animated:SetMouseInputEnabled(false)
        self.Animated:SetImages(card.animatedSrc)
        self.Animated:SetTimes(card.times.normal, card.times.idle)
        self.Animated:PostInit()
        local oldPaint = self.Animated.Paint
        self.Animated.Paint = function(pnl, w, h)
          XeninUI:Mask(function()
            XeninUI:DrawRoundedBox(6, 0, 0, w, h, color_white)
          end, function()
            oldPaint(pnl, w, h)
          end)
        end
      end
    else
      local card = XeninDS.Config:getCard(self.Data.card)
      if (!card) then
        if (self.Data.tag == XENINDS_TAG_SUICIDE) then
          self:DownloadIcon(table.Random(XeninDS.Config:get("suicide_src", {
          "OaHa1fJ" })))
        elseif (self.Data.tag == XENINDS_TAG_WORLD) then
          self:DownloadIcon(table.Random(XeninDS.Config:get("world_src", {
          "OaHa1fJ" })))
        else
          self:DownloadIcon(self.Data.card)
        end
      else
        self:DownloadIcon(card.src)
      end
    end
  end

  self:AddSpectateHooks()
end

function PANEL:DownloadIcon(src)
  if src:find(".png") then
    self.Icon = Material(src)
  else
    XeninUI:DownloadIcon(self, src)
  end
end

function PANEL:Think()
  if (self.IsPreview and ((IsValid(self.CardParent) and !self.CardParent:IsHovered()) or !IsValid(self.CardParent))) then
    self:Remove()
  end
end

function PANEL:AddSpectateHooks()
  if self.Data.preview then return end
  if (self.Data.tag != XENINDS_TAG_KILLFEED) then
    self:AddHook("HUDPaint", "XeninDS.HideHUD", function()
      return false end)
  end
  if (self.Data.tag != XENINDS_TAG_PLAYER) then return end
  if (!self.Config:get("follow_killer")) then return end

  self:AddHook("CalcView", "XeninDS.Spectate", function(self, p, pos, angles, fov)
    self.cw = self.cw or {
      lastPos = pos,
      endPos = pos + Vector(0, 0, 30),
      lastAng = angles,
      lastFov = fov
    }

    self.cw.lastPos = LerpVector(2 * FrameTime(), self.cw.lastPos, self.cw.endPos)

    local ply = self.Data.ply.object
    if IsValid(ply) then
      if ply:Alive() then
        local _pos = ply:LocalToWorld(ply:OBBCenter())
        local _ang = (_pos - self.cw.lastPos):Angle()

        self.cw.lastAng = LerpAngle(3 * FrameTime(), self.cw.lastAng, _ang)
      else
        local ent = ply:GetRagdollEntity()

        if IsValid(ent) then
          local _pos = ent:LocalToWorld(ent:OBBCenter())
          local _ang = (_pos - self.cw.lastPos):Angle()

          self.cw.lastAng = LerpAngle(3 * FrameTime(), self.cw.lastAng, _ang)
        end
      end

      local fov = {
        max = fov,
        min = 5
      }
      local dis = {
        curr = self.cw.lastPos:DistToSqr(ply:LocalToWorld(ply:OBBCenter())),
        min = 5000,
        max = 50000
      }
      fov.curr = math.Clamp(dis.curr, dis.max, dis.curr) / dis.max
      fov.curr = math.Clamp(fov.max - fov.curr, fov.min, fov.max)

      self.cw.lastFov = Lerp(2 * FrameTime(), self.cw.lastFov, fov.curr)
    end

    local view = {}
    view.origin = self.cw.lastPos
    view.angles = self.cw.lastAng
    view.fov = self.cw.lastFov

    return view
  end)

  self:AddHook("PreDrawHalos", "XeninDS.Player", function(self)
    local ply = self.Data.ply.object
    if (!IsValid(ply)) then return end
    if (!ply:IsPlayer()) then return end

    ply = ply:Alive() and ply or ply:GetRagdollEntity() or NULL

    local col = self.Config:get("player_outline_color")
    if (col == "inventory") then
      local entClass = ((self.Data and self.Data.wep) and self.Data.wep.entClass)
      if (XeninInventory and entClass != NULL and entClass != nil and entClass != "NULL") then
        local rarity = XeninInventory:GetRarity(self.Data.wep.entClass) or 1
        local tbl = XeninInventory.Config.Categories[rarity]
        col = tbl and tbl.color or XeninUI.Theme.Red
      else
        col = XeninUI.Theme.Red
      end
    elseif (!IsColor(col)) then
      col = XeninUI.Theme.Red
    end

    halo.Add({
    ply }, col, 2, 2, 2, true, true)
  end)





end

function PANEL:PerformLayout(w, h)
  if IsValid(self.Animated) then
    self.Animated:SetPos(0, 0)
    self.Animated:SetSize(w, h)
  end

  if (!IsValid(self.Avatar)) then return end

  local level = self.Data.level and (self.Data.level != 0 and self.Data.tag != XENINDS_TAG_KILLFEED)
  local width = level and h - 48 or h - 16
  local height = level and h - 64 or h - 32
  self.Avatar:SetSize(width, height)
  self.Avatar:SetPos(6, 16)
end

function PANEL:PaintBar(x, y, w, h, data)
  local frac = data.current / data.max

  XeninUI:DrawRoundedBox(6, x, y, w, h, XeninUI.Theme.Primary)

  local aX, aY = self:LocalToScreen()
  render.SetScissorRect(aX + x + 1, aY + y + 1, aX + (x + 1) + ((w - 2) * frac), aY + (y + 1) + h - 2, true)
  XeninUI:DrawRoundedBox(6, x + 1, y + 1, w - 2, h - 2, data.col)
  render.SetScissorRect(0, 0, ScrW(), ScrH(), false)

  local margin = 5
  local size = h - (margin * 2)
  if (!self["PaintBarIcon_" .. data.id]) then
    XeninUI:DownloadIcon(self, data.icon, "PaintBarIcon_" .. data.id)
  else
    XeninUI:DrawIcon(x + w - 2 - size - margin, y + margin, size, size, self, color_white, XeninUI.Theme.Green, "PaintBarIcon_" .. data.id)
  end

  XeninUI:DrawShadowText(data.current, "XeninDS.Card.Info", x + w - 2 - size - margin - 5, y + h / 2, Color(238, 238, 238), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 1, 150)
end

function PANEL:Paint(w, h)
  XeninUI:DrawRoundedBox(6, 0, 0, w, h, XeninUI.Theme.Primary)

  local x = 0
  local y = 0
  local width = w
  local height = h

  if (type(self.Icon) == "IMaterial") then
    local aspectRatio = self.Icon:Width() / self.Icon:Height()
    local target = math.abs(517 / 129)

    if (aspectRatio != target) then
      local diff = target - aspectRatio
      local frac = diff / target

      x = x - (frac * self.Icon:Width())
      y = y - (frac * self.Icon:Height())
      width = width + ((frac * self.Icon:Width()) * 2)
      height = height + ((frac * self.Icon:Height()) * 2)
    end
  end

  XeninUI:Mask(function()
    XeninUI:DrawRoundedBox(6, 0, 0, w, h, color_white)
  end, function()
    XeninUI:DrawIcon(x, y, width, height, self)
  end)
end

function PANEL:PaintOver(w, h)
  local outline = self.Config:get("outline")
  for i = outline, 1, -1 do
    XeninUI:MaskInverse(function()
      XeninUI:DrawRoundedBox(6, i, i, w - (i * 2), h - (i * 2), color_white)
    end, function()
      XeninUI:DrawRoundedBox(6, 0, 0, w, h, Color(0, 0, 0, i * (250 / outline)))
    end)
  end

  local bg = XeninUI.Theme.Primary

  if (self.Data.tag == XENINDS_TAG_PLAYER or self.Data.tag == XENINDS_TAG_KILLFEED) then
    local isKillfeed = self.Data.tag == XENINDS_TAG_KILLFEED
    local __lauxi0 = self.Data
    assert(__lauxi0 ~= nil, "cannot destructure nil value")
    local level, wep = __lauxi0.level, __lauxi0.wep
    if (level and level != 0) then
      local str
      if (self.Data.tag == XENINDS_TAG_KILLFEED) then
        str = i18n:get("killfeed.level", {
        level = level }, "Level")
      else
        str = XeninDS.LevelSystem:getString(ply, level)
      end

      surface.SetFont("XeninDS.Card.Info")
      local tw, th = surface.GetTextSize(str)
      tw = math.max(self.Avatar:GetWide() / 3, tw + 16)

      if (self.Data.tag == XENINDS_TAG_PLAYER) then
        local x = self.Avatar:GetWide() / 2 - tw / 2 + self.Avatar:GetPos()
        local y = h - 16 - (th + 6)
        XeninUI:DrawRoundedBox(6, x, y, tw, th + 6, XeninUI.Theme.Primary)
        XeninUI:DrawShadowText(str, "XeninDS.Card.Info", x + tw / 2, y + (th + 6) / 2, Color(225, 225, 225), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, 150)
      else
        local x = w - tw - 10
        local y = h / 2 - (th * 2 + 12) / 2
        XeninUI:DrawRoundedBox(6, x, y, tw, th * 2 + 12, XeninUI.Theme.Primary)
        XeninUI:DrawShadowText(str, "XeninDS.Card.Info", x + tw / 2, y + (th + 6) / 2, Color(204, 204, 204), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, 150)
        XeninUI:DrawShadowText(level, "XeninDS.Card.Info", x + tw / 2, y + (th + 12) / 2 + draw.GetFontHeight("XeninDS.Card.Info"), XeninUI.Theme.Green, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, 150)
      end
    end

    local job = self.Data.ply
    local y = isKillfeed and 19 or 16
    local x = self.Avatar:GetWide() + 2 + self.Avatar:GetPos()

    surface.SetFont("XeninDS.Card.Name")
    local tw, th = surface.GetTextSize(job.name)
    tw = tw + 16
    th = th + 8

    XeninUI:DrawRoundedBox(6, x, y, tw, th, bg)
    XeninUI:DrawShadowText(job.name, "XeninDS.Card.Name", x + tw / 2, y + th / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, 150)

    y = y + (th + 8)

    surface.SetFont("XeninDS.Card.Info")
    local teamName = "Unknown"
    local teamCol = Color(255, 255, 255)
    if (self.Config:get("card_usergroup_enabled") and self.Usergroup) then
      teamName = self.Usergroup.text or self.Usergroup.name
      teamCol = self.Usergroup.color
    else
      teamName = job.team.text
      teamCol = job.team.color
    end

    local tw, th = surface.GetTextSize(teamName)
    tw = tw + 16
    th = th + 8

    XeninUI:DrawRoundedBox(6, x, y, tw, th, bg)
    XeninUI:DrawShadowText(teamName, "XeninDS.Card.Info", x + tw / 2, y + th / 2, teamCol, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, 150)

    local armorEnabled = self.Config:get("armor_enabled") and (((self.Data and self.Data.ap) and self.Data.ap.current) or 0) < 0
    local width = w - self.Avatar:GetWide()
    width = width / 2
    width = width - (10 + self.Avatar:GetPos())

    if (level and level != 0) then
      surface.SetFont("XeninDS.Card.Info")
      local tw, th = surface.GetTextSize(level)
      th = th + 6
    end

    if (self.Data.tag != XENINDS_TAG_PLAYER) then return end

    self:PaintBar(x, h - th - 16, width, th, {
      col = XeninUI.Theme.Red,
      max = self.Data.hp.max,
      current = self.Data.hp.current,
      icon = "VMXjoLD",
      id = "health"
    })

    if armorEnabled then
      self:PaintBar(x + width + 10 + self.Avatar:GetPos() - 4, h - th - 16, width, th, {
        col = XeninUI.Theme.Blue,
        max = self.Data.ap.max,
        current = self.Data.ap.current,
        icon = "uussjLV",
        id = "armor"
      })
    end

    if (istable(wep) and wep.name) then
      surface.SetFont("XeninDS.Card.Info")
      local tw, th = surface.GetTextSize(wep.name)
      tw = tw + 16
      th = th + 8

      XeninUI:DrawRoundedBox(6, w - 12 - tw, 16, tw, th, bg)
      XeninUI:DrawShadowText(wep.name, "XeninDS.Card.Info", w - 12 - tw / 2, 16 + th / 2, wep.col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, 150)
    end
  elseif (self.Data.tag == XENINDS_TAG_SUICIDE) then
    XeninUI:DrawShadowText(i18n:get("card.suicide", nil, "Suicide"), "XeninDS.Card.Suicide", w / 2, 5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, 200)
  elseif (self.Data.tag == XENINDS_TAG_WORLD) then
    XeninUI:DrawShadowText(i18n:get("card.world", nil, "World"), "XeninDS.Card.Suicide", w / 2, 5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, 200)
  end
end

vgui.Register("XeninDS.Card", PANEL)
