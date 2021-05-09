do
  local _class_0
  local _base_0 = {
    __name = "XeninDS.Models.Card",
    setId = function(self, id)
      self.id = id

      return self
    end,
    getId = function(self)
      return self.id
    end,
    __type = function(self)
      return self.__name
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, id)
      self:setId(id)
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
  XeninDS.Models.Card = _class_0
end
