XeninDS.Currencies:set("ps1", {
  format = function(self, money)
    return string.Comma(money) .. " points"
  end,
  add = function(self, ply, money)
    if (CLIENT) then return end

    ply:PS_GivePoints(money)
  end,
  get = function(self, ply)
    return ply:PS_GetPoints()
  end,
  canAfford = function(self, ply, amount)
    return ply:PS_HasPoints(amount)
  end
})
