local Commands
do
  local _class_0
  local _base_0 = {
    __name = "Commands",
    getCommands = function(self)
      return XeninDS.Config.chatcommands
    end,
    handleCommands = function(self, ply, text)
      text = text:lower()
      local cmds = self:getCommands()

      if (!cmds[text]) then return end

      cmds[text](ply)
    end,
    __type = function(self)
      return "XeninDS.Commands"end
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
  Commands = _class_0
end

XeninDS.Commands = Commands()

concommand.Add("xenin_deathscreen_give_card", function(ply, cmd, args)
  if (IsValid(ply)) then return end
  local sid64 = args[1]
  local cardId = args[2]

  assert(sid64, "First argument is a steamid64")
  assert(cardId, "Second argument is a card id")
  local card = XeninDS.Config:getCard(cardId)
  assert(istable(card), "No card were found for that card id")

  ply = player.GetBySteamID64(sid64)
  if IsValid(ply) then
    local ds = ply:XeninDeathscreen()
    if (ds:getCard(cardId)) then return end

    ds:addCard(cardId)
    ds:saveCard(cardId)
  else
    XeninDS.Models.Container:saveCard(sid64, cardId)
  end
end)

hook.Add("PlayerSay", "XeninDS", function(...)
  XeninDS.Commands:handleCommands(...)end)
