
local files = file.FindInLua("includes/extensions/*.lua")
local bad = {
"extensions/file.lua",
"extensions/angle.lua",
"extensions/debug.lua",
"extensions/entity.lua",
"extensions/ents.lua",
"extensions/math.lua",	
"extensions/player.lua",
"extensions/player_auth.lua",
"extensions/string.lua",
"extensions/table.lua",
"extensions/util.lua",
"extensions/vector.lua"

}

require ( "datastream" )

for k,v in pairs(files) do
	local str = "extensions/"..v
	if not table.HasValue(bad,str) then
		include(str)
	end
end


AddCSLuaFile"vgui/dsysbutton.lua"

-- _R.Entity.SetColor