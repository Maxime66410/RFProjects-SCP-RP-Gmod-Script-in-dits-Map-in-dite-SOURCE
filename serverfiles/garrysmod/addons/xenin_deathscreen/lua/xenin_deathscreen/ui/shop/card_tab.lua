local PANEL = {}

XeninUI:CreateFont("XeninDS.Shop.Category.Card", 18)
XeninUI:CreateFont("XeninDS.Shop.Category.Level", 14)
XeninUI:CreateFont("XeninDS.Shop.Category.Price", 16)
XeninUI:CreateFont("XeninDS.Shop.Category.Equipped", 22)
XeninUI:CreateFont("XeninDS.Shop.Category.Sort", 18)

local i18n = XeninDS.i18n

PANEL.SortsDefault = {
  priceAscending = "Price up",
  priceDescending = "Price down",
  alphabetical = "Alphabetical"
}

function PANEL:Init()
  self.Controller = LocalPlayer():XeninDeathscreen()
  self.SortOrder = XeninDS.Config:get("sort_order")

  self.Panels = {}

  self:DockMargin(16, 16, 16, 16)

  self.Top = self:Add("DPanel")
  self.Top:Dock(TOP)
  self.Top:DockPadding(8, 8, 8, 8)
  self.Top:DockMargin(0, 0, 0, 8)
  self.Top:SetTall(52)
  self.Top.Paint = function(pnl, w, h)
    XeninUI:DrawRoundedBox(6, 0, 0, w, h, XeninUI.Theme.Primary)
  end

  self.Top.Search = self.Top:Add("XeninUI.TextEntry")
  self.Top.Search:Dock(LEFT)
  self.Top.Search:SetPlaceholder(i18n:get("shop.search", nil, "Name"))
  self.Top.Search:SetIcon(XeninUI.Materials.Search, true)
  self.Top.Search.textentry:SetUpdateOnType(true)
  self.Top.Search.textentry.OnValueChange = function(pnl, text)
    XeninUI:Debounce("XeninDS.Rebuild", 0.25, function()
      if (!IsValid(self)) then return end

      self:Build()
    end)
  end

  self.Top.Unowned = self.Top:Add("XeninUI.CheckboxV2")
  self.Top.Unowned:Dock(RIGHT)
  self.Top.Unowned:DockMargin(8, 8, 8, 8)
  self.Top.Unowned.TextColor = Color(225, 225, 225)
  self.Top.Unowned.Text = i18n:get("shop.unowned", nil, "Show unowned")
  self.Top.Unowned:SetState(true, true)
  self.Top.Unowned.OnStateChanged = function()
    self:Build()end

  self.Top.Unpurchasable = self.Top:Add("XeninUI.CheckboxV2")
  self.Top.Unpurchasable:Dock(RIGHT)
  self.Top.Unpurchasable:DockMargin(8, 8, 8, 8)
  self.Top.Unpurchasable.TextColor = Color(225, 225, 225)
  self.Top.Unpurchasable.Text = i18n:get("shop.unpurchasable", nil, "Show unpurchasable")
  self.Top.Unpurchasable:SetState(false, true)
  self.Top.Unpurchasable.OnStateChanged = function()
    self:Build()end

  self.Top.Sort = self.Top:Add("DButton")
  self.Top.Sort:Dock(LEFT)
  self.Top.Sort:DockMargin(8, 0, 0, 0)
  self.Top.Sort:SetText(i18n:get("shop.sort." .. self.SortOrder[1], nil, self.SortsDefault[self.SortOrder[1]]))
  self.Top.Sort:SetFont("XeninDS.Shop.Category.Sort")
  self.Top.Sort:SetTextColor(Color(190, 190, 190))
  self.Top.Sort:SetContentAlignment(5)
  self.Top.Sort.Paint = function(pnl, w, h)
    draw.RoundedBox(6, 0, 0, w, h, XeninUI.Theme.Navbar)
  end
  self.Top.Sort.SortChanged = function(pnl, text)
    pnl:SetText(text)

    self:Build()
    self.Top:InvalidateLayout()
  end
  self.Top.Sort.DoClick = function(pnl)
    local func = function(btn)
      pnl:SortChanged(btn:GetText())
    end
    local hoverColor = Color(75, 75, 75)

    local panel = XeninUI:DropdownPopup(pnl:LocalToScreen(-12, -12 + pnl:GetTall()))
    panel:SetBackgroundColor(XeninUI.Theme.Navbar)
    panel:SetTextColor(Color(185, 185, 185))
    for i, v in ipairs(self.SortOrder) do
      panel:AddChoice(i18n:get("shop.sort." .. tostring(v), nil, self.SortsDefault[v]), func, nil, hoverColor)
    end
  end

  self.Top.PerformLayout = function(pnl, w, h)
    pnl.Search:SetWide(180)
    pnl.Unowned:SizeToContentsX()
    pnl.Unpurchasable:SizeToContentsX()
    pnl.Sort:SizeToContentsX(24)
  end

  self.Scroll = self:Add("XeninUI.Scrollpanel.Wyvern")
  self.Scroll:Dock(FILL)
end

function PANEL:Build()
  for i, v in ipairs(self.Panels) do
    v:Remove()
  end
  self.Panels = {}

  local cards = {}
  local tbl = {}

  local search = self.Top.Search:GetText():lower()
  if (search != "") then
    for i, v in pairs(self.Cards) do
      local id = i:lower()

      if id:find(search) then
        v.id = i

        table.insert(cards, v)

        continue
      end

      if (!v.name) then continue end
      local name = v.name:lower()

      if name:find(search) then
        v.id = i

        table.insert(cards, v)

        continue
      end
    end
  else
    for i, v in pairs(self.Cards) do
      v.id = i

      table.insert(cards, v)
    end
  end

  local showUnpurchasable = self.Top.Unpurchasable.State
  local showUnowned = self.Top.Unowned.State
  for i, v in ipairs(cards) do
    if (!showUnowned) then
      if (!self.Controller:getCard(v.id)) then continue end
    end
    if (!showUnpurchasable) then
      if (v.unpurchasable and !self.Controller:getCard(v.id)) then continue end
    end

    table.insert(tbl, v)
  end

  local cats = {}
  for i, v in ipairs(tbl) do
    if (v.id == "colors") then continue end

    local cat = v.category or "Others"
    cats[cat] = cats[cat] or {}

    table.insert(cats[cat], v)
  end

  local sort = self.Top.Sort:GetText()
  for i, tbl in pairs(cats) do
    if (sort == i18n:get("shop.sort.priceAscending", nil, "Price up")) then
      table.SortByMember(tbl, "price", true)
    elseif (sort == i18n:get("shop.sort.priceDescending", nil, "Price down")) then
      table.SortByMember(tbl, "price")
    elseif (sort == i18n:get("shop.sort.alphabetical", nil, "Alphabetical")) then
      table.SortByMember(tbl, "name", true)
    end
  end

  for i, v in SortedPairs(cats) do
    self:CreateCategory(i, v)
  end

  self:InvalidateLayout()
end

XeninUI:CreateFont("XeninDS.Category.Title", 24)

function PANEL:CreateCategory(name, cards)
  local cat = self.Scroll:Add("XeninUI.Category")
  cat:Dock(TOP)
  cat:DockMargin(0, 0, 8, 8)
  cat:SetTopColor(XeninUI.Theme.Navbar)
  cat:SetTopColorHover(XeninUI.Theme.Primary)
  cat:SetTopColorActive(Color(58, 58, 58))
  cat:SetLayoutType(XENINUI_LAYOUT_GRID)
  cat:SetColumns(3)
  cat:SetFont("XeninDS.Category.Title")
  cat:SetLayoutPanel("XeninDS.Shop.Category.Card")
  cat.Top.background = cat:GetTopColor()
  cat:SetName(name)
  cat.Layout.PerformLayout = function(pnl, w, h)
    local children = pnl:GetChildren()
    local count = 3
    local amount = math.max(1, math.floor(#children / count)) * 276
    local width = w / math.min(count, #children)

    local x = 0
    local y = 0

    local spacingX = pnl:GetSpaceX()
    local spacingY = pnl:GetSpaceY()
    local border = pnl:GetBorder()
    local innerWidth = w - border * 2 - spacingX * (count - 1)

    for i, child in ipairs(children) do
      if (!IsValid(child)) then continue end

      child:SetPos(border + x * innerWidth / count + spacingX * x, border + y * child:GetTall() + spacingY * y)
      child:SetSize(innerWidth / count, 32 + (innerWidth / count) / 4)

      x = x + 1
      if (x >= count) then
        x = 0
        y = y + 1
      end
    end

    pnl:SizeToChildren(false, true)
  end
  local w
  if (F4Menu and IsValid(F4Menu.Frame) and F4Menu.Frame:IsVisible()) then
    local frame = F4Menu.Frame

    local sw = 0
    for i, v in ipairs(frame.Player.Text.Rows) do
      surface.SetFont(v.font)
      local tw = surface.GetTextSize(v.text)

      sw = math.max(sw, 68 + tw + 68 / 2 + 8)
    end
    for i, v in ipairs(frame.Sidebar.Sidebar) do
      surface.SetFont("XeninUI.SidebarV2.Name")
      local nameTw = surface.GetTextSize(v.Name or "")
      surface.SetFont(v.DescFont)
      local descTw = surface.GetTextSize(v.Desc or "")

      local tw = math.max(nameTw, descTw) + 8
      if v.Icon then
        tw = tw + 68
      end

      sw = math.max(sw, tw)
    end

    local res = F4Menu.Config.Resolution
    local fW, fH
    if isfunction(res) then
      fW, fH = res()

      fW = math.max(960, fW * ScrW())
      fH = math.max(600, fH * ScrH())
    else
      fW = res[1]
      fH = res[2]
    end
    local width = math.min(ScrW(), fW)
    local height = math.min(ScrH(), fH)

    w = ((fW - sw) / 3) + 12
  else
    w = (97 + 16) * 3
  end

  cat:SetInstantExpandWidth(w)
  cat:FeedData(cards, 1, true)

  table.insert(self.Panels, cat)
end

vgui.Register("XeninDS.Shop.Category", PANEL)
