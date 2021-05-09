do
  local _class_0
  local _base_0 = {
    __name = "XeninDS.Models.Killfeed",
    addToQueue = function(self, data)
      table.insert(self.queue, data)

      if (IsValid(XeninDS.Killfeed)) then return end

      XeninDS:QueueKillfeed(data)
    end,
    removeFromQueue = function(self, id)
      if (!istable(self.queue[id])) then return end

      table.remove(self.queue, id)
    end,
    getCurrent = function(self)
      return self.queue[1]
    end,
    next = function(self)
      self:removeFromQueue(1)

      local tbl = self:getCurrent()
      if (!istable(tbl)) then return end

      XeninDS:QueueKillfeed(tbl)
    end,
    __type = function(self)
      return self.__name
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      self.queue = {}
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
  XeninDS.Models.Killfeed = _class_0
end
