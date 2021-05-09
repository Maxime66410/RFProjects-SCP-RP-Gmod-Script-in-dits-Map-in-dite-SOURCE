local MetaPlayer = FindMetaTable("Player")

local Staff = {}

AnoConfig = { 
	colorprefixe = Color(255, 93, 0, 255),
	chatprefixe = "[Narration]",
	cmd = "na"
}

function MetaPlayer:IsStaff()
	for _, v in pairs(Staff) do
		if self:IsUserGroup(v) then
			return true
		end
	end

	return false
end


