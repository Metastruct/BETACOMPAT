
local _R_Vehicle_GetPassenger=_R.Vehicle.GetPassenger

_R.Vehicle.GetPassenger=function(veh,num)
	return _R_Vehicle_GetPassenger(veh,num or 0)
end