do
  local _class_0
  local _parent_0 = XeninDS.Models.Card
  local _base_0 = {
    __name = "XeninDS.Models.AnimatedCard",
    __base = XeninDS.Models.Card.__base,
    setSpeed = function(self, speed)
      self.speed = speed

      return self
    end,
    getSpeed = function(self)
      return self.speed or 0.08 end,
    setColor = function(self, color)
      self.color = color

      return self
    end,
    getColor = function(self)
      return self.color or color_white end,
    __type = function(self)
      return self.__name
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__index)
  _class_0 = setmetatable({
    __init = function(self, id)
      self.isAnimated = true
      XeninDS.Models.AnimatedCard.__parent.__init(self, id)
    end,
    __base = _base_0,
    __parent = _parent_0
  }, {
    __index = function(cls, parent)
      local val = rawget(_base_0, parent)
      if val == nil then local _parent = rawget(cls, "__parent")
        if _parent then return _parent[parent]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  if _parent_0.__inherited then _parent_0.__inherited(_parent_0, _class_0)
  end
  XeninDS.Models.AnimatedCard = _class_0
end
