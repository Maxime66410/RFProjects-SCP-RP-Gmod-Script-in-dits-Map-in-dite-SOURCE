local Config
do
  local _class_0
  local _base_0 = {
    __name = "Config",
    get = function(self, id, default)
      return self.settings[id] or default
    end,
    set = function(self, id, val)
      self.settings[id] = val

      return self
    end,
    setHidePriceIfOwned = function(self, bool)
      return self:set("hide_price_if_owned", bool)
    end,
    setSortOrder = function(self, tbl)
      return self:set("sort_order", tbl)
    end,
    setSmoothRespawnCam = function(self, bool)
      return self:set("smooth_respawn_cam", bool)
    end,
    setPlayerOutlineColor = function(self, col)
      return self:set("player_outline_color", col)
    end,
    setKillfeedEnabled = function(self, bool)
      return self:set("killfeed_enabled", bool)
    end,
    setKillfeedTime = function(self, time)
      return self:set("killfeed_time", time)
    end,
    setRespawnTimeUsergroups = function(self, tbl)
      return self:set("respawn_time_usergroups", tbl)
    end,
    getRespawnTime = function(self, ply)
      local usergroups = self:get("respawn_time_usergroups")
      local usergroup = ply:GetUserGroup()
      local tbl = usergroups[usergroup]
      if tbl then return tbl end

      return self:get("respawn_time", 30)
    end,
    setRespawnTimerEnabled = function(self, bool)
      return self:set("respawn_timer_enabled", bool)
    end,
    setRespawnUIEnabled = function(self, bool)
      return self:set("respawn_ui_enabled", bool)
    end,
    setGreyFilterOn = function(self, bool)
      return self:set("grey_filter", bool)
    end,
    setMenuTitle = function(self, title)
      return self:set("menu_title", title)
    end,
    setNPCTitle = function(self, title)
      return self:set("npc_title", title)
    end,
    setNPCModel = function(self, mdl)
      return self:set("npc_model", mdl)
    end,
    setNPCColor = function(self, color)
      return self:set("npc_color", color)
    end,
    setCurrency = function(self, id)
      XeninDS.Currencies:setActive(id)

      return self
    end,
    setLanguage = function(self, lang, tbl)
      XeninDS.i18n:setLanguage(lang, tbl)

      return self
    end,
    setLevelSystem = function(self, id)
      XeninDS.LevelSystem:setActive(id)

      return self
    end,
    setOutline = function(self, thickness)
      if thickness == nil then thickness = 1
      end
      return self:set("outline", thickness)
    end,
    setArmorEnabled = function(self, bool)
      return self:set("armor_enabled", bool)
    end,
    setRespawnTime = function(self, time)
      if time == nil then time = 30
      end
      return self:set("respawn_time", time)
    end,
    setFollowKiller = function(self, bool)
      return self:set("follow_killer", bool)
    end,
    setPosition = function(self, pos)
      return self:set("card_position", pos)
    end,
    setMargin = function(self, margin)
      if margin == nil then margin = 32
      end
      return self:set("card_margin", margin)
    end,
    setDefaultCard = function(self, card)
      return self:set("card_default", card)
    end,
    setUsergroupEnabled = function(self, bool)
      return self:set("card_usergroup_enabled", bool)
    end,
    addUsergroup = function(self, id, name, color)
      self.usergroups[id] = {
        name = name,
        color = color
      }
    end,
    getUsergroup = function(self, ply)
      local usergroup = ply:GetUserGroup()
      local tbl = self.usergroups[usergroup]
      if tbl then return tbl end

      return {
        text = usergroup:sub(1, 1):upper() .. usergroup:sub(2),
        color = Color(203, 203, 203)
      }
    end,
    addChatCommand = function(self, cmd)
      cmd = cmd:lower()

      self.chatcommands[cmd] = function(ply)
        XeninDS.Network:openMenu(ply)end
    end,
    addSuicideCard = function(self, src)
      self.settings.suicide_src = self.settings.suicide_src or {}

      table.insert(self.settings.suicide_src, src)
    end,
    addWorldCard = function(self, src)
      self.settings.world_src = self.settings.world_src or {}

      table.insert(self.settings.world_src, src)
    end,
    addCard = function(self, id, tbl)
      if tbl.unpurchasable then tbl.price = math.huge end

      assert(tbl.price, tostring(id) .. " needs a price!")
      assert(tbl.name, tostring(id) .. " needs a name!")
      assert(tbl.src, tostring(id) .. " needs a src!")

      self.cards[id] = tbl

      return self
    end,
    getCard = function(self, id)
      return self.cards[id]
    end,
    addAnimatedCard = function(self, id, tbl)
      tbl.animated = true
      tbl.animatedSrc = {}
      tbl.times = tbl.times or {}
      tbl.times.normal = tbl.times[1] or 0.05
      tbl.times.idle = tbl.times[2] or 0.05

      local files = file.Find("materials/xenin/deathcards/" .. tbl.src .. "/*", "GAME") or {}
      for i, v in ipairs(files) do
        files[i] = tonumber(string.StripExtension(v))
      end
      table.sort(files, function(a, b)
        return b > a end)

      for i, v in ipairs(files) do
        tbl.animatedSrc[i] = Material("xenin/deathcards/" .. tbl.src .. "/" .. v .. ".png", "smooth")
      end

      self:addCard(id, tbl)

      return self
    end,
    __type = function(self)
      return "XeninDS.ConfigWrapper"end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      self.chatcommands = {}
      self.usergroups = {}
      self.settings = {}
      self.cards = {}
      XeninDS.Config = self

      self:setOutline(1)
      self:setArmorEnabled(true)
      self:setRespawnTime(30)
      self:setFollowKiller(true)
      self:setPosition("bottom")
      self:setMargin(32)
      self:setDefaultCard("test")
      self:setRespawnUIEnabled(true)


      self:setRespawnTimerEnabled(false)
      self:setRespawnTimeUsergroups({})
      self:setKillfeedEnabled(true)
      self:setKillfeedTime(3)


      self:setPlayerOutlineColor(XeninUI.Theme.Red)
      self:setSmoothRespawnCam(true)


      self:setSortOrder({
        "priceAscending",
        "priceDescending",
        "alphabetical"
      })


      self:setHidePriceIfOwned(true)
    end,
    __base = _base_0
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  Config = _class_0
end

XeninDS.ConfigWrapper = Config
