-- controlpanel.lua
function GetControlPanel( strName )
	return controlpanel.Get( strName )
end

-- ents_Create.lua
ents.Create=ents.Create or function(ent)
	if ent!="prop_physics" then ErrorNoHalt"Cant create entities clientside using ents.Create!" end
	return ents.CreateClientProp()
end

-- _r_csoundpatch.lua
local _R_CSoundPatch_ChangeVolume=_R.CSoundPatch.ChangeVolume

_R.CSoundPatch.ChangeVolume=function(a,b,c,d)
	return _R_CSoundPatch_ChangeVolume(a,b,c or 0,d)
end

local _R_CSoundPatch_ChangePitch=_R.CSoundPatch.ChangePitch

_R.CSoundPatch.ChangePitch=function(a,b,c)
	return _R_CSoundPatch_ChangePitch(a,b,c or 0)
end
-- _r_entity_setmodelscale.lua
local _R_Entity_SetModelScale=_R.Entity.SetModelScale
_R.Entity.SetModelScale = function(ent,scale,time,...)
	time=time or 0

	if type(scale) == "Vector" then
		local matrix=Matrix()
		if ent:GetBoneName(0) == "static_prop" then
			matrix:Scale(scale)
		else
			matrix:Scale(Vector(scale.y, scale.x, scale.z))
		end
		ent:EnableMatrix("RenderMultiply", matrix)
		return
	end
	
	return _R_Entity_SetModelScale(ent,scale,time,...)
end



-- vgui_Create.lua
local vgui_Create=vgui.Create

local fixtable={
 ["dlabel"]="DLabel",
 ["dbutton"]="DButton",
 ["dtree"]="DTree",
 ["HTML"]="DHTML", -- HTML crashes
}

vgui.Create=function(a,...)
	a=fixtable[a] or a
	
	local ret = vgui_Create(a,...)
	if !a or a:gsub(" ","")=="" then
		error "totally missing control name??"
	end
	return ret
end


local lua_load_own_files = CreateClientConVar("lua_load_own_files","0",true,true)
if lua_load_own_files:GetBool() and -- TODO: RECURSION
   GetConVar ("sv_allowcslua"):GetBool() then
	Msg"[CAutorun] "print"Loading clientside autorun files!"
	
	for _, files in pairs(file.Find("lua/autorun/client/*.lua", "GAME")) do
		include("autorun/client/" .. files)
	end
end