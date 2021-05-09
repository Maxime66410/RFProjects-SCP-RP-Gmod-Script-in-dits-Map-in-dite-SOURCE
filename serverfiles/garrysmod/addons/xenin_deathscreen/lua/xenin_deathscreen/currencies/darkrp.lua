XeninDS.Currencies:set("darkrp", {
  format = function(self, money)
    return DarkRP.formatMoney(money)
  end,
  add = function(self, ply, money)
    if (CLIENT) then return end

    ply:addMoney(money)
  end,
  get = function(self, ply)
    return ply:getDarkRPVar("wallet")
  end,
  canAfford = function(self, ply, amount)
    return ply:canAfford(amount)
  end
})
