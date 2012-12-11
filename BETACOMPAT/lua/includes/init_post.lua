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
------------------------------------------
include=_include

local files = file.FindInLua("includes/extensions/*.lua")
for k,v in pairs(files) do
	local str = "extensions/"..v
	if not table.HasValue(bad,str) then
		include("includes/"..str)
	end
end


function debug.Trace()

	ErrorNoHalt(debug.traceback())
	  
end


-- get is missing nowadays, sigh?
http.Get=function(url,head,func,...)
	assert(not not func)
	local t={...}
	local function Fail( body, length, headers, responsecode )
		if #t>0 then
			func(unpack(t),"",0)
		else
			func("",0)
		end
	end
	local function Write( body, length, headers, responsecode )
		
		if tonumber(responsecode)!=200 then
			Fail( body, length, headers, responsecode )
		end
		
		if #t>0 then
			func(unpack(t),body,length)
		else
			func(body,length)
		end
	end

	http.Fetch( url, Write, Fail ) 
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

local tonumber=tonumber
function Color( r, g, b, a )
	if type(b)!="number" then error("Invalid type to Color(): "..tostring(type(b)),2) end
	r=r or 255
	g=g or 255
	b=b or 255
	a=a or 255
	
	r=r>255 and 255 or r
	g=g>255 and 255 or g
	b=b>255 and 255 or b
	a=a>255 and 255 or a
	return { 	r = r, 
				g = g, 
				b = b, 
				a = a }
end



/*
function IsMounted( name )

	local content = GetMountableContent()[ name ]
	
	if ( content == nil ) then return false end
	if ( content.mountable == false ) then return false end
	
	return content.mounted

end*/

Msg"[Lua] " print("Initialized GMod "..tostring(VERSION).." with "..tostring(jit and jit.version or "no LuaJit").." on "..(jit and jit.os or "??") )