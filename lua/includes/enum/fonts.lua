if SERVER then
	AddCSLuaFile("fonts.lua")
	return
end

local surface_CreateFont=surface.CreateFont
surface.CreateFont=function(font_name, size, weight, antialias, additive, new_font_name, shadow, outline, blursize, scan, ... )
	if type(size)=="table" then return surface_CreateFont(font_name, size, weight, antialias, additive, new_font_name, shadow, outline, blursize, scan, ... ) end
	surface_CreateFont(new_font_name,
	{
		size=size,
		weight=weight,
		antialias=antialias, 
		additive=additive,
		font=font_name, 
		shadow=shadow, 
		outline=outline,
		blursize=blursize, 
		scanlines=scan 
	})
end




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
surface.CreateFont("Trebuchet MS",22,900,false,false,"Trebuchet22",false,false) -- this was missing but why??
surface.CreateFont("Trebuchet MS",24,900,false,false,"Trebuchet24",false,false)
surface.CreateFont("Marlett",14,0,false,false,"Marlett",false,false)
surface.CreateFont("Lucida Console",10,0,false,false,"DefaultFixed",false,false)
surface.CreateFont("Tahoma",12,0,false,false,"DefaultSmall",false,false)
surface.CreateFont("Tahoma",13,700,false,false,"TabLarge",true,false)
