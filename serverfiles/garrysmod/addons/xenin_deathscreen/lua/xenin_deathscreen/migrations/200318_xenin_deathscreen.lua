return function(Table, callback)
  if callback == nil then callback = function() end
  end
  XeninUI.Promises.all({
    Table("xenin_deathscreen_cards", function(tbl)
      tbl:increments("id")
      tbl:steamid64("sid64")
      tbl:string("card_id", 255)
    end),
    Table("xenin_deathscreen_equipped", function(tbl)
      tbl:increments("id")
      tbl:steamid64("sid64")
      tbl:string("card_id", 255)
    end),
    Table("xenin_deathscreen_cards_settings", function(tbl)
      tbl:increments("id")
      tbl:steamid64("sid64")
      tbl:string("setting", 64)
      tbl:string("value", 255)
    end)
  }):next(callback)
end
