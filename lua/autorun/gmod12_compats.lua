-- gmod13_generic.lua
timer.Remove("CheckHookTimes")

IsVector = isvector

-- jit.lua
jit.off() 
jit.flush()

-- _r_entity.lua
local _R_Entity_SetColor=_R.Entity.SetColor
local Color=Color
_R.Entity.SetColor=function(e,r,g,b,a) 
	return _R_Entity_SetColor(e,g and b and Color(r,g,b,a or 255) or r)
end

_R.Entity.SetShouldDrawInViewMode = function() --[[TODO]] end
-- _r_player.lua

local meta = FindMetaTable( "Player" )

function meta:GetScriptedVehicle()

	return self:GetNetworkedEntity( "ScriptedVehicle", NULL )

end

function meta:SetScriptedVehicle( veh )

	self:SetNetworkedEntity( "ScriptedVehicle", veh )
	self:SetViewEntity( veh )

end

meta.GetCursorAimVector=function(pl) 
	return pl:EyeAngles():Forward()
end

local _R_Player_GetInfoNum=meta.GetInfoNum
meta.GetInfoNum=function(pl,what,def)
	def=def or 0
	return _R_Player_GetInfoNum(pl,what,def)
end

local _R_Player_GetInfo=meta.GetInfo
meta.GetInfo=function(pl,what,def)
	def=def or ""
	return _R_Player_GetInfo(pl,what,def)
end
-- _r_setangle.lua

_R.Entity.GetAngle=_R.Entity.GetAngle or _R.Entity.GetAngles
_R.Entity.SetAngle=_R.Entity.SetAngle or _R.Entity.SetAngles
_R.PhysObj.GetAngle=_R.PhysObj.GetAngle or _R.PhysObj.GetAngles
_R.PhysObj.SetAngle=_R.PhysObj.SetAngle or _R.PhysObj.SetAngles
_R.VMatrix.GetAngle=_R.VMatrix.GetAngle or _R.VMatrix.GetAngles
_R.VMatrix.SetAngle=_R.VMatrix.SetAngle or _R.VMatrix.SetAngles

-- _r_vector.lua
local _R_Vector_Normalize=_R.Vector.Normalize
function _R.Vector.Normalize(v)
	_R_Vector_Normalize(v)
	return v
end
-- _r_vehicle.lua

local _R_Vehicle_GetPassenger=_R.Vehicle.GetPassenger
if _R_Vehicle_GetPassenger then
	_R.Vehicle.GetPassenger=function(veh,num)
		return _R_Vehicle_GetPassenger(veh,num or 0)
	end
end

if CLIENT then
	local lua_load_own_files = CreateClientConVar("lua_load_own_files","0",true,true)
	if lua_load_own_files:GetBool() and -- TODO: RECURSION
	   GetConVar ("sv_allowcslua"):GetBool() then
		Msg"[CAutorun] "print"Loading clientside autorun files!"
		for _, files in pairs(file.Find("lua/autorun/*.lua", "GAME")) do
			include("autorun/" .. files)
		end
	end
end