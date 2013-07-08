_G.start_garbage = collectgarbage"count" -- let's see how much garry fucks us

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
LUA_PATH=LUA_PATH or "LUA"
_R=_R or debug.getregistry()

-- also fixing here
if CLIENT then
	local col={r=255,g=255,b=255,a=255}
	_G.print=function(...)
		local a={}
		for i=1,select('#',...) do
			local v=select(i,...)
			v=tostring(v) or "no value"
			a[i]=v	
		
		end
		MsgC(col,table.concat(a,"\t")..'\n')
	end
end

file.FindDirBeta=file.FindDirBeta or file.FindDir or function(...)
	local f=file.FindNewBeta or file.Find
	local a,b=f(...)
	return b
end

	file.FindDir=function(name,where,...)
	
		if name then
			if name:find("lua_temp",1,true) then
				name=name:gsub("lua_temp/",""):gsub("lua_temp\\","")
				where=true
			end
		end
	
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

	file.Find=function(name,where,sorting,...)
		if name then
			if name:find("lua_temp",1,true) then
				name=name:gsub("lua_temp/",""):gsub("lua_temp\\","")
				where=true
			end
		end
		sorting=sorting or "namedesc"
		if where==nil or where==false then
			if DEBUG then
			--	ErrorNoHalt("Warning, calling file.Find on ("..name..") with old behaviour!")
			end
			local files,dirs =  file.FindNewBeta(name,"DATA",sorting,...)
			for k,v in pairs(dirs or {}) do	table.insert(files or {},v) end
			return files,dirs
		elseif where==true then
			if DEBUG then
			--	ErrorNoHalt("Warning, calling file.Find on ("..name..") with old behaviour!")
			end
			local files,dirs =  file.FindNewBeta(name,"GAME",sorting,...)
			for k,v in pairs(dirs or {}) do	table.insert(files or {},v) end
			return files,dirs
		else
			local files,dirs =  file.FindNewBeta(name,where,sorting,...)
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
		if name then
			if name:find("lua_temp",1,true) then
				name=name:gsub("lua_temp/",""):gsub("lua_temp\\","")
				where=true
			end
		end
	
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
		if name then
			if name:find("lua_temp",1,true) then
				name=name:gsub("lua_temp/",""):gsub("lua_temp\\","")
				where=true
			end
		end
	
		
		if where==nil or where==false then
			return file.IsDirBeta(name,"DATA",...)
		elseif where==true then
			return file.IsDirBeta(name,"GAME",...)
		else
			return file.IsDirBeta(name,where,...)
		end
	end

utilx=utilx or util

file.FindInLua=function(a,b,c)
	local a,b = file.FindNewBeta(a,b or "LUA",c or "")
	for k,v in pairs(b) do
		table.insert(a,v)
	end
	return a
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


IsValid=IsValid or ValidEntity or _R.Entity.IsValid
ValidEntity=ValidEntity or IsValid

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

for k,v in pairs(file.FindInLua("includes/enum/*.lua")) do
	include("enum/"..v)
end



-- FIX ASAP
local _Vector=Vector
Vector=function(x,y,z) return y==nil and type(x)=="number" and _Vector(1,1,1) or _Vector(x or 0,y or 0,z or 0) end 

-- FIX SOON
local _Angle=Angle
Angle=function(p,y,r) return y==nil and type(p)=="number" and _Angle(1,1,1) or _Angle(p or 0,y or 0,r or 0) end 

/*
Removed ents.Create clientside
Removed GetMountedContent()
Removed GetMountableContent()
Removed GetGamemodes()
Removed GetAddonList()
Removed GetAddonInfo()
Removed Player:GetCursorAimVector()
NETWORKED VARS
*/
/*	["GetAddons"] = function:([C]),
	["GetGames"] = function:([C]),
	["GetGamemodes"] = function:([C]),
	["SetMounted"] = function:([C]),
	["ActiveGamemode"] = function:([C]),
}*/

GetGamemodes=GetGamemodes or engine.GetGamemodes
GetAddonList=GetAddonList or engine.GetAddons
GetAddonInfo=GetAddonInfo or function() return {} end
GetMountableContent=GetMountableContent or function() return {} end
GetMountedContent=GetMountedContent or function() return {} end

resource = resource or {}
resource.AddFile = resource.AddFile or function() end
resource.AddSingleFile = resource.AddSingleFile or function() end
