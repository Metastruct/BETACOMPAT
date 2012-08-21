-- Adding missing materials for map

if SERVER then
	resource.AddFile("materials/console/gmod_logo.vmt")
	resource.AddFile("materials/gui/silkicons/box.vmt")
	AddCSLuaFile"materialfixes.lua"
else
	-- fix missing material functions
end