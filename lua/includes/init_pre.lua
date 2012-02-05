_G.BETA=true
_G._BETA=true
_G.__BETA=true

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
			return file.FindNewBeta(name,"DATA",...)
		elseif where==true then
			return file.FindNewBeta(name,"GAME",...)
		else
			return file.FindNewBeta(name,where,...)
		end
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

for k,v in pairs(file.FindInLua("includes/enum/*.lua")) do
	print("including "..tostring(v))
	include("enum/"..v)
end
