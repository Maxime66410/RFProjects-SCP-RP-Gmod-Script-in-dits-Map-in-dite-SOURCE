local Gamemodes
do
  local _class_0
  local _base_0 = {
    __name = "Gamemodes",
    set = function(self, id, tbl)
      self.gamemodes[id] = tbl
    end,
    setActive = function(self, id)
      assert(istable(self.gamemodes[id]) == true, "The gamemode you're trying to set to active does not exist")

      self.active = id

      return self
    end,
    getActive = function(self)
      return self.active or "base"
    end,
    getGamemode = function(self)
      return self.gamemodes[self:getActive()]
    end,
    getSubtitle = function(self, ply)
      if XeninDS.Config:get("card_usergroup_enabled") then
        return XeninDS.Config:getUsergroup(ply)
      end

      local details = hook.Run("XeninDS.SubtitleDetails", ply, self:getActive())
      if details then
        return details
      end

      return self:getGamemode().getTeamDetails(ply)
    end,
    __type = function(self)
      return "XeninDS.Gamemodes"end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      self.gamemodes = {}
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
  Gamemodes = _class_0
end

XeninDS.Gamemodes = Gamemodes()
