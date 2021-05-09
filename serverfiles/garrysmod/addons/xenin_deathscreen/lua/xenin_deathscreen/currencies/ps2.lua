XeninDS.Currencies:set("ps2", {
  format = function(self, money)
    return string.Comma(money) .. " points"
  end,
  add = function(self, ply, money)
    if (CLIENT) then return end

    ply:PS2_AddStandardPoints(money)
  end,
  get = function(self, ply)
    return ply.PS2_Wallet.points
  end,
  canAfford = function(self, ply, amount)
    return ply.PS2_Wallet.points >= amount
  end
})
