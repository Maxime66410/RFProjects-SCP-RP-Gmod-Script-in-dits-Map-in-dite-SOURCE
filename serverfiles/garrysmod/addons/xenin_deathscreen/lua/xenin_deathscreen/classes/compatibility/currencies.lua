local Currencies
do
  local _class_0
  local _base_0 = {
    __name = "Currencies",
    set = function(self, id, tbl)
      self.currencies[id] = tbl
    end,
    setActive = function(self, id)
      assert(istable(self.currencies[id]) == true, "The currency you're trying to set to active does not exist")

      self.active = id

      return self
    end,
    getActive = function(self)
      return self.active
    end,
    getCurrency = function(self)
      return self.currencies[self:getActive()]
    end,
    format = function(self, money)
      return self:getCurrency():format(money)
    end,
    get = function(self, ply)
      return self:getCurrency():get(ply)
    end,
    add = function(self, ply, money)
      self:getCurrency():add(ply, money)
    end,
    canAfford = function(self, ply, amount)
      return self:getCurrency():canAfford(ply, amount)
    end,
    __type = function(self)
      return "XeninDS.Currencies"end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      self.currencies = {}
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
  Currencies = _class_0
end

XeninDS.Currencies = Currencies()
