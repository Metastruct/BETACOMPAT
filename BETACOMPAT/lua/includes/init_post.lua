local bad={}
local _include=include
local include=function(v) table.insert(bad,v) end
--------------- from init.lua ----------------

include ( "extensions/file.lua" )
include ( "extensions/angle.lua" )
include ( "extensions/debug.lua" )
include ( "extensions/entity.lua" )
include ( "extensions/ents.lua" )
include ( "extensions/math.lua" )
include ( "extensions/player.lua" )
include ( "extensions/player_auth.lua" )
include ( "extensions/string.lua" )
include ( "extensions/table.lua" )
include ( "extensions/util.lua" )
include ( "extensions/vector.lua" )
include ( "extensions/game.lua" )
include ( "extensions/motionsensor.lua" )

if ( CLIENT ) then

	include ( "extensions/client/entity.lua" )
	include ( "extensions/client/globals.lua" )
	include ( "extensions/client/panel.lua" )
	include ( "extensions/client/player.lua" )
	include ( "extensions/client/render.lua" )

	require ( "search" )

end

------------------------------------------
-- fu
AddCSLuaFile"includes/extensions/file.lua"
------------------------------------------
include=_include

local files = file.FindInLua("includes/extensions/*.lua")
for k,v in pairs(files) do
	local str = "extensions/"..v
	if not table.HasValue(bad,str) then
		include("includes/"..str)
	end
end


debug.Trace = debug.Trace or function()
	ErrorNoHalt(debug.traceback("",2):sub(2,-1))
end





hook.Add("PostInitEntity", "GM13", function()
	hook.Remove("PostInitEntity", "GM13")
	
	local _R_Entity_EmitSound=_R.Entity.EmitSound
	function _R.Entity.EmitSound(self, filen, vol, p)
		local volume = 100
		local pitch = 100
		if vol then volume = math.Clamp(vol, 1, 100) end
		if p then pitch = p end
		OldEmitFunc(self, filen, volume, pitch)
	end
end)


function AccessorFuncNW( tab, varname, name, varDefault, iForce )

	tab[ "Get"..name ] = function ( self ) return self:GetNetworkedVar( varname, varDefault ) end

	if ( iForce == FORCE_STRING ) then
		tab[ "Set"..name ] = function ( self, v ) self:SetNetworkedVar( varname, tostring(v) ) end
	return end
	
	if ( iForce == FORCE_NUMBER ) then
		tab[ "Set"..name ] = function ( self, v ) self:SetNetworkedVar( varname, tonumber(v) ) end
	return end
	
	if ( iForce == FORCE_BOOL ) then
		tab[ "Set"..name ] = function ( self, v ) self:SetNetworkedVar( varname, tobool(v) ) end
	return end
	
	tab[ "Set"..name ] = function ( self, v ) self:SetNetworkedVar( varname, v ) end

end



/*
function IsMounted( name )

	local content = GetMountableContent()[ name ]
	
	if ( content == nil ) then return false end
	if ( content.mountable == false ) then return false end
	
	return content.mounted

end*/

local withjit=jit and jit.status and jit.status() and " (JIT Enabled)" or " (JIT Disabled)"
Msg"[Lua] " print("Initialized GMod "..tostring(VERSION).." with "..tostring(jit and jit.version or "no LuaJit").." on "..(jit and jit.os or "??")..withjit)

local t={} for k,v in pairs(engine.GetGames()) do if v.installed and v.owned and v.mounted then table.insert(t,v.folder) end end
Msg"[Games Mounted] " print(table.concat(t," "))