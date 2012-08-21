AddCSLuaFile("vgui/dnumberwang.lua")
AddCSLuaFile("vgui/dsysbutton.lua")


local bad,_include,include = {},_G.include,function(v) table.insert(bad,v) end
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

if ( CLIENT ) then

	include ( "extensions/client/entity.lua" )
	include ( "extensions/client/globals.lua" )
	include ( "extensions/client/panel.lua" )
	include ( "extensions/client/player.lua" )
	include ( "extensions/client/render.lua" )


end

------------------------------------------
include=_include

local files = file.FindInLua("includes/extensions/*.lua")
for k,v in pairs(files) do
	local str = "extensions/"..v
	if not table.HasValue(bad,str) then
		include(str)
	end
end


-- get is missing nowadays, sigh?
http.Get=function(url,head,func,...)
	local function Write( body, length, headers, responsecode )
		func(...,body,length)
	end
	local function Fail( body, length, headers, responsecode )
		func(...,"",0)
	end
	http.Fetch( url, Write, Fail ) 
end



hook.Add("PostInitEntity", "GM13", function()
	hook.Remove("PostInitEntity", "GM13")
	
	local OldEmitFunc=_R.Entity.EmitSound
	function _R.Entity.EmitSound(self, filen, vol, p)
		local volume = 100
		local pitch = 100
		if vol then volume = math.Clamp(vol, 1, 100) end
		if p then pitch = p end
		OldEmitFunc(self, filen, vol, pitch)
	end
end)

if CLIENT then

	surface.CreateFont("Tahoma",16,500,false,false,"CloseCaption_Italic",false,false)
	surface.CreateFont("Lucida Console",10,0,false,false,"DefaultFixedDropShadow",true,false)
	surface.CreateFont("Tahoma",16,500,false,false,"DefaultUnderline",false,false)
	surface.CreateFont("Tahoma",12,1000,false,false,"UiBold",false,false)
	surface.CreateFont("HalfLife2",120,400,true,true,"TitleFont2",false,false)
	surface.CreateFont("Lucida Console",10,500,false,false,"ConsoleText",false,false)
	surface.CreateFont("Courier New",7,500,true,true,"DebugFixedSmall",false,false)
	surface.CreateFont("Tahoma",12,0,false,false,"DefaultVerySmall",false,false)
	surface.CreateFont("HalfLife2",72,400,true,true,"TitleFont",false,false)
	surface.CreateFont("Lucida Console",10,0,false,false,"DefaultFixedOutline",false,true)
	surface.CreateFont("Courier New",10,500,true,true,"DebugFixed",false,false)
	surface.CreateFont("Trebuchet MS",42,900,false,false,"HUDNumber2",false,false)
	surface.CreateFont("Tahoma",16,900,false,false,"CloseCaption_BoldItalic",false,false)
	surface.CreateFont("Trebuchet MS",40,900,false,false,"HUDNumber",false,false)
	surface.CreateFont("Tahoma",16,1000,false,false,"DefaultBold",false,false)
	surface.CreateFont("Tahoma",16,900,false,false,"CloseCaption_Bold",false,false)
	surface.CreateFont("Tahoma",16,500,false,false,"CloseCaption_Normal",false,false)
	surface.CreateFont("Tahoma",16,500,false,false,"Default",false,false)
	surface.CreateFont("Trebuchet MS",45,900,false,false,"HUDNumber5",false,false)
	surface.CreateFont("Trebuchet MS",44,900,false,false,"HUDNumber4",false,false)
	surface.CreateFont("Tahoma",13,0,false,false,"DefaultSmallDropShadow",true,false)
	surface.CreateFont("Verdana",16,600,true,true,"MenuLarge",false,false)
	surface.CreateFont("Trebuchet MS",43,900,false,false,"HUDNumber3",false,false)
	surface.CreateFont("Trebuchet MS",41,900,false,false,"HUDNumber1",false,false)
	surface.CreateFont("Trebuchet MS",18,900,false,false,"Trebuchet18",false,false)
	surface.CreateFont("Tahoma",18,0,false,false,"DefaultLarge",false,false)
	surface.CreateFont("Trebuchet MS",20,900,false,false,"Trebuchet20",false,false)
	surface.CreateFont("Trebuchet MS",24,900,false,false,"Trebuchet24",false,false)
	surface.CreateFont("Marlett",14,0,false,false,"Marlett",false,false)
	surface.CreateFont("Lucida Console",10,0,false,false,"DefaultFixed",false,false)
	surface.CreateFont("Tahoma",12,0,false,false,"DefaultSmall",false,false)
end