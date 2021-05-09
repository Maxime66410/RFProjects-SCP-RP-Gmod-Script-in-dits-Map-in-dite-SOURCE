local i18n = XeninDS.i18n
local matTick = Material("xenin/tick.png", "smooth")

local PANEL = {}

function PANEL:PostInit(data)
  self:SetData(data)
end

function PANEL:SetData(cards)
  self.Cards = cards

  self:Build()
end

vgui.Register("XeninDS.Shop.Category.Cards", PANEL, "XeninDS.Shop.Category")

local PANEL = {}

function PANEL:Init()
  self.Controller = LocalPlayer():XeninDeathscreen()
end

function PANEL:HandleData(tbl)
  local id = tbl.id
  local currency = XeninDS.Currencies
  if tbl.currency then
    currency = currency.currencies[tbl.currency]
  end

  print(currency, tbl.currency, tbl.price)

  local panel = self:Add("DButton")
  panel:Dock(FILL)
  panel:SetText("")
  panel.Price = currency:format(tbl.price)
  panel.Outline = ColorAlpha(tbl.rarityColor or XeninUI.Theme.Accent, 0)
  panel.PriceColor = Color(172, 172, 172)
  panel.DownloadIcon = function(pnl)
    if tbl.src:find(".png") then
      pnl.Icon = Material(tbl.src, "smooth")
    else
      XeninUI:DownloadIcon(pnl, tbl.src)
    end
  end
  panel.Paint = function(pnl, w, h)
    XeninUI:DrawRoundedBox(6, 0, 0, w, h, Color(53, 53, 53))

    surface.SetFont("XeninDS.Shop.Category.Card")
    local tw = surface.GetTextSize(tbl.name)
    XeninUI:DrawShadowText(tbl.name, "XeninDS.Shop.Category.Card", 8, 32 / 2 - 1, Color(203, 203, 203), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, 150)

    local level = tbl.levelRequirement
    if level then
      local str = i18n:get("shop.card.level", {
      level = level }, "(lvl: :level:)")
      local isLevel = XeninDS.LevelSystem:getLevel(LocalPlayer()) >= level

      XeninUI:DrawShadowText(str, "XeninDS.Shop.Category.Level", 8 + tw + 4, 32 / 2, isLevel and XeninUI.Theme.Green or XeninUI.Theme.Red, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, 150)
    end

    local offset = 0
    if self.Controller:getCard(id) then
      local size = 32 / 2

      XeninUI:DrawCircle(w - size, size, size / 2, 30, XeninUI.Theme.Green)
      surface.SetMaterial(matTick)
      surface.SetDrawColor(color_black)
      surface.DrawTexturedRect(w - size - 4, size / 1.5 + size / 3 - 4, size / 1.5, size / 1.5)

      offset = offset + (size + 8)
    end

    local priceStr = pnl.Price
    if tbl.unpurchasable then
      priceStr = i18n:get("shop.card.unpurchasable", nil, "Unpurchasable")
    end
    if (self.Controller:getCard(id) and XeninDS.Config:get("hide_price_if_owned")) then
      priceStr = i18n:get("shop.card.owned", nil, "Owned")
    end
    XeninUI:DrawShadowText(priceStr, "XeninDS.Shop.Category.Price", w - 8 - offset, 32 / 2, pnl.PriceColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 1, 150)

    XeninUI:Mask(function()
      XeninUI:DrawRoundedBoxEx(6, 0, 32, w, h - 32, color_white, false, false, true, true)
    end, function()

      if pnl.Icon then
        local x = 0
        local y = 32
        local width = w
        local height = h - 32

        if (type(pnl.Icon) == "IMaterial") then
          local aspectRatio = pnl.Icon:Width() / pnl.Icon:Height()
          local target = math.abs(517 / 129)

          if (aspectRatio != target) then
            local diff = math.abs(target - aspectRatio)
            local frac = diff / target

            x = x - (frac * pnl.Icon:Width())
            y = y - (frac * pnl.Icon:Height())
            width = width + ((frac * pnl.Icon:Width()) * 2)
            height = height + ((frac * pnl.Icon:Height()) * 2)
          end
        end
        XeninUI:DrawIcon(x, y, width, height, pnl)
      elseif (!tbl.animated) then
        pnl:DownloadIcon()
      end
    end)
  end
  panel.PaintOver = function(pnl, w, h)
    XeninUI:MaskInverse(function()
      XeninUI:DrawRoundedBox(6, 1, 1, w - 2, h - 2, pnl.Outline)
    end, function()
      XeninUI:DrawRoundedBox(6, 0, 0, w, h, pnl.Outline)
    end)

    if (self.Controller:getEquipped() == id) then
      surface.SetFont("XeninDS.Shop.Category.Equipped")
      local str = i18n:get("shop.equipped", nil, "EQUIPPED")
      local tw, th = surface.GetTextSize(str)
      tw = tw + 16
      th = th + 8

      XeninUI:DrawRoundedBox(6, w / 2 - tw / 2, h / 2 + 32 / 2 - th / 2, tw, th, Color(0, 0, 0, 235))
      XeninUI:DrawShadowText(str, "XeninDS.Shop.Category.Equipped", w / 2, h / 2 + 32 / 2 - 1, XeninUI.Theme.Green, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, 125)
    end
  end
  panel.DoClick = function(pnl)
    if self.Controller:getCard(id) then return self.Controller:equipCard(id, true)end
    local ply = LocalPlayer()

    if tbl.unpurchasable then
      return XeninUI:SimpleQuerySingle(i18n:get("shop.card.popup.title", nil, "Unpurchasable"), i18n:get("shop.card.popup.desc", nil, "This card is unpurchasable"), i18n:get("shop.card.popup.btn", nil, "Understood"))
    end
    if (tbl.steamids and !tbl.steamids[ply:SteamID64()]) then
      return XeninUI:SimpleQuerySingle(i18n:get("shop.card.steamids.title", nil, "SteamID requirements"), i18n:get("shop.card.steamids.desc", nil, "You aren't whitelisted by SteamID for this card."), i18n:get("shop.card.steamids.btn", nil, "Understood"))
    end
    if (tbl.usergroupRestriction and !tbl.usergroupRestriction[ply:GetUserGroup()]) then
      return XeninUI:SimpleQuerySingle(i18n:get("shop.card.dontMeetRequirements.title", nil, "Rank requirements"), i18n:get("shop.card.dontMeetRequirements.desc", nil, "You don't meet the usergroup requirements for this card."), i18n:get("shop.card.dontMeetRequirements.btn", nil, "Understood"))
    end
    if (tbl.levelRequirement and XeninDS.LevelSystem:getLevel(ply) < tbl.levelRequirement) then
      return XeninUI:SimpleQuerySingle(i18n:get("shop.card.dontMeetLevel.title", nil, "Level requirement"), i18n:get("shop.card.dontMeetLevel.desc", {
      level = tbl.levelRequirement }, "You need to be level :level: to purchase this."), i18n:get("shop.card.dontMeetLevel.btn", nil, "Understood"))
    end
    if (!currency:canAfford(ply, tbl.price)) then
      return XeninUI:SimpleQuerySingle(i18n:get("shop.purchase.cantAfford.title", {
      name = tbl.name }, "Purchase " .. tostring(tbl.name)), i18n:get("shop.purchase.cantAfford.desc", {
        name = tbl.name,
        price = pnl.Price
      }, "You cannot afford " .. tostring(tbl.name) .. ". It costs " .. tostring(pnl.Price)), i18n:get("shop.purchase.cantAfford.btn", nil, "Understood"))
    end

    XeninUI:SimpleQuery(i18n:get("shop.purchase.canAfford.title", {
    name = tbl.name }, "Purchase " .. tostring(tbl.name)), i18n:get("shop.purchase.canAfford.desc", {
      name = tbl.name,
      price = pnl.Price
    }, "Are you sure you want to buy " .. tostring(tbl.name) .. " for " .. tostring(pnl.Price) .. "?"), i18n:get("shop.purchase.canAfford.yes", nil, "Yes"), function()
      currency:add(ply, -tbl.price)
      self.Controller:addCard(id, true)
    end, i18n:get("shop.purchase.canAfford.no", nil, "No"))
  end
  panel.OnRemove = function(pnl)
    if IsValid(pnl.Preview) then pnl.Preview:Remove()end
  end
  panel.CreatePreview = function(pnl)
    if IsValid(pnl.Preview) then pnl.Preview:Remove()end

    local aX, aY = pnl:LocalToScreen()
    aY = aY + pnl:GetTall()

    local wep = LocalPlayer():GetActiveWeapon()
    if (!IsValid(wep)) then
      wep = nil
    end
    local data = {
      tag = XENINDS_TAG_PLAYER,
      ply = {
        object = LocalPlayer(),
        name = LocalPlayer():Nick(),
        team = XeninDS.Gamemodes:getSubtitle(LocalPlayer())
      },
      hp = {
        current = 100,
        max = 100
      },
      ap = {
        current = 50,
        max = 100
      },
      wep = wep,
      card = id,
      animated = tbl.animated,
      preview = true
    }

    local w, h = 517, 129
    aX = math.Clamp(aX, 0, ScrW() - w)
    aY = math.Clamp(aY, 0, ScrH() - h)

    pnl.Preview = vgui.Create("XeninDS.Card")
    pnl.Preview:SetPos(aX, aY)
    pnl.Preview:SetSize(w, h)
    pnl.Preview:SetData(data)
    pnl.Preview:SetDrawOnTop(true)
    pnl.Preview:SetZPos(100)
    pnl.Preview.IsPreview = true
    pnl.Preview.CardParent = pnl
  end
  panel.Think = function(pnl)
    if (!IsValid(pnl.Preview)) then return end

    local aX, aY = pnl:LocalToScreen()
    aY = aY + pnl:GetTall()
    local w, h = 517, 129
    aX = math.Clamp(aX, 0, ScrW() - w)
    aY = math.Clamp(aY, 0, ScrH() - h)

    pnl.Preview:SetPos(aX, aY)
  end
  panel.OnCursorEntered = function(pnl)
    pnl:CreatePreview()

    pnl:LerpColor("Outline", tbl.rarityColor or XeninUI.Theme.Accent)
    if (self.Controller:getCard(id) and XeninDS.Config:get("hide_price_if_owned")) then return end
    local col = currency:canAfford(LocalPlayer(), tbl.price) and XeninUI.Theme.Green or XeninUI.Theme.Red
    pnl:LerpColor("PriceColor", col)
  end
  panel.OnCursorExited = function(pnl)
    if IsValid(pnl.Preview) then
      pnl.Preview:Remove()
    end

    pnl:LerpColor("Outline", ColorAlpha(tbl.rarityColor or XeninUI.Theme.Accent, 0))
    if (self.Controller:getCard(id) and XeninDS.Config:get("hide_price_if_owned")) then return end
    pnl:LerpColor("PriceColor", Color(172, 172, 172))
  end

  if tbl.animated then
    panel.Animated = panel:Add("XeninUI.AnimatedTexture")
    panel.Animated:SetMouseInputEnabled(false)
    panel.Animated:SetImages(tbl.animatedSrc)
    panel.Animated:SetTimes(tbl.times.normal, tbl.times.idle)
    panel.Animated:PostInit()
    local oldPaint = panel.Animated.Paint
    panel.Animated.Paint = function(pnl, w, h)
      XeninUI:Mask(function()
        XeninUI:DrawRoundedBoxEx(6, 0, 0, w, h, color_white, false, false, true, true)
      end, function()
        oldPaint(pnl, w, h)
      end)
    end

    panel.PerformLayout = function(pnl, w, h)
      panel.Animated:SetPos(0, 32)
      panel.Animated:SetSize(w, h - 32)
    end
  end
end

vgui.Register("XeninDS.Shop.Category.Card", PANEL, "Panel")
