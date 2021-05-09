local NetworkBase
do
  local _class_0
  local _base_0 = {
    __name = "NetworkBase",
    receiver = function(self, name, func)
      if func == nil then func = function() end
      end
      net.Receive(name, function(len, ply)
        func(self, ply or LocalPlayer(), len)
      end)
    end,
    send = function(self, name, target, func)
      net.Start(name)

      if CLIENT then
        target(self)

        net.SendToServer()
      else
        func(self)

        net.Send(target)
      end
    end,
    compress = function(self, data)
      local tbl = false
      if istable(data) then
        data = util.TableToJSON(data)
        tbl = true
      end

      data = util.Compress(data)
      local len = data:len()

      net.WriteUInt(len, 32)
      net.WriteBool(tbl)
      net.WriteData(data, len)
    end,
    decompress = function(self)
      local len = net.ReadUInt(32)
      local tbl = net.ReadBool()
      local data = net.ReadData(len)
      data = util.Decompress(data)

      if tbl then
        data = util.JSONToTable(data)
      end

      return data
    end,
    __type = function(self)
      return "XeninDS.NetworkBase"end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self) end,
    __base = _base_0
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  NetworkBase = _class_0
end

XeninDS.NetworkBase = NetworkBase
