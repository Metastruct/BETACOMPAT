
require ( "datastream" )

for k,v in pairs(file.FindInLua("includes/extensions/*.lua")) do
	--print("extnsions including "..tostring(v))
	include("extensions/"..v)
end


AddCSLuaFile"vgui/dsysbutton.lua"

-- _R.Entity.SetColor