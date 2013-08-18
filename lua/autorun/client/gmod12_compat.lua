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

timer.Simple(0,function() 
	_G.FONT_CANCREATE = true
end)





local vgui_Create=vgui.Create
local tbl=setmetatable({},{__mode='v'})
vgui.Create=function(ctrl,...)
	
	local ret = vgui_Create(ctrl,...)
	if ctrl=="Awesomium" --[[or ctrl=="CAwsHTML"]] then
		table.insert(tbl,ret)
	end
	return ret
end

local Panel=FindMetaTable"Panel"

local Panel_OpenURL=Panel.OpenURL
Panel.OpenURL=function(pnl,url,...)
	pnl.__openurl = url
	return Panel_OpenURL(pnl,url,...)
end

concommand.Add("awesomium_list",function()
	for k,v in pairs(tbl) do
		Msg(k,":\t ")
		if ValidPanel(v) then
			print(v,v.__openurl)
			Msg("\tParent: ",v:GetParent())
		else
			print"Not GC'd"
		end
	end
end)

concommand.Add("awesomium_kill",function(_,_,_,c)
	for k,v in pairs(tbl) do
		if k==tonumber(c) then
			v:Remove()
		end
	end
end)

