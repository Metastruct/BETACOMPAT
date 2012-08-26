if SERVER then
	AddCSLuaFile("init.lua")
	AddCSLuaFile("init_pre.lua")
	AddCSLuaFile("init_post.lua")
end

_G.BETA=true
_G._BETA=true
_G.__BETA=true
_G.DEBUG=true
_G._DEBUG=true

file.FindDirBeta=file.FindDir

	file.FindDir=function(name,where,...)
		if where==nil or where==false then
			return file.FindDirBeta(name,"DATA",...)
		elseif where==true then
			return file.FindDirBeta(name,"GAME",...)
		else
			return file.FindDirBeta(name,where,...)
		end
	end

file.TimeBeta =	file.Time 
				file.Time=
	function(name,where,...)
		if where==nil or where==false then
			return file.TimeBeta(name,"DATA",...)
		elseif where==true then
			return file.TimeBeta(name,"GAME",...)
		else
			return file.TimeBeta(name,where,...)
		end
	end

file.FindNewBeta=file.Find

	file.Find=function(name,where,...)
		if where==nil or where==false then
			if DEBUG then
			--	ErrorNoHalt("Warning, calling file.Find on ("..name..") with old behaviour!")
			end
			local files,dirs =  file.FindNewBeta(name,"DATA",...)
			for k,v in pairs(dirs or {}) do	table.insert(files or {},v) end
			return files,dirs
		elseif where==true then
			if DEBUG then
			--	ErrorNoHalt("Warning, calling file.Find on ("..name..") with old behaviour!")
			end
			local files,dirs =  file.FindNewBeta(name,"GAME",...)
			for k,v in pairs(dirs or {}) do	table.insert(files or {},v) end
			return files,dirs
		else
			local files,dirs =  file.FindNewBeta(name,where,...)
			--for k,v in pairs(dirs or {}) do	table.insert(files or {},v) end
			return files,dirs
		end
	end
	
-- oh god
file.TFind=function(name,func)

	local files,dirs =  file.FindNewBeta(name,"GAME")
	timer.Simple(0,func,name,dirs,files)
	
end
	
file.ExistsBeta=file.Exists

	file.Exists=function(name,where,...)
		if where==nil or where==false then
			return file.ExistsBeta(name,"DATA",...)
		elseif where==true then
			return file.ExistsBeta(name,"GAME",...)
		else
			return file.ExistsBeta(name,where,...)
		end
	end
file.IsDirBeta=file.IsDir

	file.IsDir=function(name,where,...)
		if where==nil or where==false then
			return file.IsDirBeta(name,"DATA",...)
		elseif where==true then
			return file.IsDirBeta(name,"GAME",...)
		else
			return file.IsDirBeta(name,where,...)
		end
	end

utilx=utilx or util

file.FindInLua=function(a)
	return file.FindNewBeta(a,LUA_PATH)
end

TableToKeyValues=util.TableToKeyValues
KeyValuesToTable=util.KeyValuesToTable
if CLIENT then
	cam.StartMaterialOverrride=render.MaterialOverride
	SetMaterialOverride=render.MaterialOverride
end

function IncludeClientFile( filename )
	
	if ( CLIENT ) then
		include( filename )
	else
		AddCSLuaFile( filename )
	end
	
end



server_settings=server_settings or {}
local server_settings=server_settings
function server_settings.Int( name, default )

	if ( !ConVarExists( name ) ) then return default end

	return GetConVarNumber( name )

end

function server_settings.Bool( name, default )

	if (default) then default = 1 else default = 0 end

	return server_settings.Int( name, default ) != 0

end

for k,v in pairs(file.Find("includes/enum/*.lua",LUA_PATH)) do
	ErrorNoHalt("including "..tostring(v))
	include("enum/"..v)
end


local meta = FindMetaTable( "Player" )

function meta:GetScriptedVehicle()

	return self:GetNetworkedEntity( "ScriptedVehicle", NULL )

end

function meta:SetScriptedVehicle( veh )

	self:SetNetworkedEntity( "ScriptedVehicle", veh )
	self:SetViewEntity( veh )

end

-- FIX ASAP
local _Vector=Vector
Vector=function(x,y,z) return y==nil and _Vector(1,1,1) or _Vector(x,y,z) end 

-- FIX SOON
local _Angle=Angle
Angle=function(p,y,r) return y==nil and _Angle(1,1,1) or _Angle(p,y,r) end 
ErrorNoHalt"init_pre"
/*
   Removed ents.Create clientside
   Removed GetMountedContent()
Removed GetMountableContent()
Added game.GetMountedAddons()
Added string.StartWith( str, start )
Added string.EndsWith( str, end )
Removed GetGamemodes()
Removed GetAddonList()
Removed GetAddonInfo()
Removed Player:GetCursorAimVector()
NETWORKED VARS
*/
