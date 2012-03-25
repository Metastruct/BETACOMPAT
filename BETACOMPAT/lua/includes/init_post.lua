-- are we early enough?

local str="TEST"
file.Write("gmodbetabugfix.txt",str)
local str_=file.Read("gmodbetabugfix.txt",str)
file.Delete("gmodbetabugfix.txt")
if str_!=str then
	function file.Read( filename, path )

		if ( path == true ) then path = "GAME" end
		if ( path == nil || path == false ) then path = "DATA" end

		local f = file.Open( filename, "r", path )
		if ( !f ) then return end

		local str = f:ReadString( f:Size() )

		f:Close()

		if ( !str ) then str = "" end
		return str:sub(1,-2)

	end
end


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
AddCSLuaFile"vgui/dnumberwang.lua"

local _R_Entity_SetColor=_R.Entity.SetColor

local meta={}

_R.Entity.SetColor=function(self,r,g,b,a)
	if g then
		_R_Entity_SetColor(self,Color(r,g,b,a))
	else
		_R_Entity_SetColor(self,r)
	end
end

local _R_Entity_GetColor=_R.Entity.GetColor



function meta:__tostring()
	return self and self.r or 255
end

_R.Entity.GetColor=function(self)
	local col=_R_Entity_GetColor(self)
	setmetatable(col,meta)
	return col,col.g,col.b,col.a
end