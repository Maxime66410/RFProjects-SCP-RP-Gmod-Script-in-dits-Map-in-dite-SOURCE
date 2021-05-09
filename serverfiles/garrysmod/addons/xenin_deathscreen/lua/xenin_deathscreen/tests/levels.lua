local test = XeninUI.Units.Test("Level system"):setBeforeAll(function(self)
  self.selected = XeninDS.LevelSystem:getActive()
  self.sys = XeninDS.LevelSystem:getSystem()
end):setAfterAll(function(self)
  self.selected = nil
  self.sys = nil
end):addSpec("The selected system exist", function(self)
  if (!self.selected) then return end

  XeninUI.Units.Assert(self.sys):isNotNil()
end):addSpec("Not error if selected system is installed", function(self)
  if (!self.selected) then return end

  XeninUI.Units.Assert(self.sys.isInstalled()):isTrue()
end)

XeninDS:AddTest(test)
