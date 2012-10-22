if SERVER then
	AddCSLuaFile("language_add.lua")
	return
end
local language_Add=language.Add
language.Add=function(id,text,...)
	local newid
	
	local txt=id:lower()
	if txt:find("^tool_") then
		local stool,lang=txt:match("tool_(.+)_(.+)")
		if lang then
			newid = "tool." ..stool..'.'..lang
		end
	end
	if newid then language_Add(newid,text,...) end
	return language_Add(id,text,...)
end

