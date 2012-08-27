
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