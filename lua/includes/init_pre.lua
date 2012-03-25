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
			local files,dirs =  file.FindNewBeta(name,"DATA",...)
			for k,v in pairs(dirs or {}) do	table.insert(files or {},v) end
			return files,dirs
		elseif where==true then
			local files,dirs =  file.FindNewBeta(name,"GAME",...)
			for k,v in pairs(dirs or {}) do	table.insert(files or {},v) end
			return files,dirs
		else
			local files,dirs =  file.FindNewBeta(name,where,...)
			for k,v in pairs(dirs or {}) do	table.insert(files or {},v) end
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

for k,v in pairs(file.FindInLua("includes/enum/*.lua")) do
	print("including "..tostring(v))
	include("enum/"..v)
end
