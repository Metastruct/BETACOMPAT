if not CLIENT then return end
local lua_load_own_files = CreateClientConVar("lua_load_own_files","0",true,true)
if lua_load_own_files:GetBool() then -- TODO: RECURSION
	Msg"[CAutorun] "print"Loading clientside autorun files!"
	
	for _, files in pairs(file.Find("lua/autorun/client/*.lua", "GAME")) do
		include("autorun/client/" .. files)
	end
end