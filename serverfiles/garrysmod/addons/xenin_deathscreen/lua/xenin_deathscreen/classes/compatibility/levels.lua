local LevelSystem
do
  local _class_0
  local _base_0 = {
    __name = "LevelSystem",
    set = function(self, id, tbl)
      self.systems[id] = tbl

      return self
    end,
    setActive = function(self, id)
      assert(istable(self.systems[id]), "The level system you're trying to set doesn't exist")

      self.active = id

      return self
    end,
    get = function(self, system)
      return self.systems[system]
    end,
    getActive = function(self)
      return self.active
    end,
    getSystem = function(self)
      return self:get(self:getActive())
    end,
    getLevel = function(self, ply)
      return self:getSystem() and self:getSystem().getLevel(ply) or 0
    end,
    getString = function(self, ply, level)
      return self:getSystem() and self:getSystem().getString and self:getSystem().getString(ply, level) or XeninDS.i18n:get("card.level", {
      level = level }, "Lvl. :level:")
    end,
    __type = function(self)
      return "XeninDS.LevelSystem"end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      self.systems = {}
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
  LevelSystem = _class_0
end

XeninDS.LevelSystem = LevelSystem()
