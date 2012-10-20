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

if ( CLIENT ) then

	include ( "extensions/client/entity.lua" )
	include ( "extensions/client/globals.lua" )
	include ( "extensions/client/panel.lua" )
	include ( "extensions/client/player.lua" )
	include ( "extensions/client/render.lua" )

	require ( "search" )

end


------------------------------------------
include=_include

local files = file.FindInLua("includes/extensions/*.lua")
for k,v in pairs(files) do
	local str = "extensions/"..v
	if not table.HasValue(bad,str) then
		include("includes/"..str)
	end
end



if ( !debug ) then return end

--[[---------------------------------------------------------
   Name: Trace
   Desc: Dumps a trace to the console..
   
Trace: 
	1: Line 21	"Trace"			includes/extensions/debug.lua
	2: Line 222	"WriteTable"	includes/modules/saverestore.lua
	3: Line 170	"WriteVar"		includes/modules/saverestore.lua
	4: Line 259	"WriteTable"	includes/modules/saverestore.lua
	5: Line 170	"WriteVar"		includes/modules/saverestore.lua
	6: Line 259	"WriteTable"	includes/modules/saverestore.lua
	7: Line 272	"Func"			includes/extensions/entity_networkvars.lua
	8: Line 396	"(null)"		includes/modules/saverestore.lua
	
	This trace shows that the function was called from the engine (line 8) in save restore.
	Save restore then called something in entity_networkvars for some reason. Then
	that function called WriteTable(6), which called other functions until it got to the trace
	in 1 which was called by WriteTable in saverestore.lua
   
-----------------------------------------------------------]]
function debug.Trace()

	local level = 1
	  
	Msg( "\nTrace: \n" )
	  
	while true do
	  
		local info = debug.getinfo(level, "Sln")
		if (!info) then break end
		
		if (info.what) == "C" then
		
			Msg(level, "\tC function\n")
		  
		else
		
			Msg( string.format( "\t%i: Line %d\t\"%s\"\t%s\n", level or "", info.currentline or "", info.name or "", info.short_src or "" ) )
		  
		end
		
		level = level + 1
		
	end
	  
	Msg( "\n\n" )
	  
end


-- get is missing nowadays, sigh?
http.Get=function(url,head,func,...)
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

/*
function IsMounted( name )

	local content = GetMountableContent()[ name ]
	
	if ( content == nil ) then return false end
	if ( content.mountable == false ) then return false end
	
	return content.mounted

end*/

Msg"[Lua] "print("Initialized "..tostring(jit.version).." on "..jit.os)