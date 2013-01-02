
local _R_Vehicle_GetPassenger=_R.Vehicle.GetPassenger
if _R_Vehicle_GetPassenger then
	_R.Vehicle.GetPassenger=function(veh,num)
		return _R_Vehicle_GetPassenger(veh,num or 0)
	end
end