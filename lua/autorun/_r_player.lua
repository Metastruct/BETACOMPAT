
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