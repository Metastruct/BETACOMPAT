
if SERVER then
	AddCSLuaFile"fixfonts.lua"
	return
end
 -- Missing ConsoleFont, etc.
surface.CreateFont("Trebuchet MS",18,500,true,false,"Trebuchet18")
surface.CreateFont("Trebuchet MS",19,500,true,false,"Trebuchet19")
surface.CreateFont("Trebuchet MS",20,500,true,false,"Trebuchet20")
surface.CreateFont("Trebuchet MS",22,500,true,false,"Trebuchet22")
surface.CreateFont("Trebuchet MS",24,500,true,false,"Trebuchet24")
surface.CreateFont("Trebuchet MS",17,700,true,false,"TabLarge",true)
surface.CreateFont("Default",16,800,true,false,"UiBold")
surface.CreateFont("coolvetica",32,500,true,false,"ScoreboardHeader")
surface.CreateFont("coolvetica",22,500,true,false,"ScoreboardSubtitle")
surface.CreateFont("coolvetica",19,500,true,false,"ScoreboardPlayerName")
surface.CreateFont("coolvetica",15,500,true,false,"ScoreboardPlayerName2")
surface.CreateFont("coolvetica",22,500,true,false,"ScoreboardPlayerNameBig")