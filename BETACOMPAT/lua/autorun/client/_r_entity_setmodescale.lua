local _R_Entity_SetModeScale=_R.Entity.SetModeScale
_R.Entity.SetModeScale = function(ent,scale,time,x)
	time=time or 0.1
	if type(scale)=="number" then
		return _R_Entity_SetModeScale(ent,scale,time,x)
	end
	if scale and scale.x and scale.y and scale.z then
		local matrix=Matrix()
		matrix:Scale(scale)
		ent:EnableMatrix("RenderMultiply", matrix)
	end
	error"Invalid parameters"
end
print"EEEEEEEEEEEKEEEEEEEEEEEKEEEEEEEEEEEKEEEEEEEEEEEKEEEEEEEEEEEKEEEEEEEEEEEKEEEEEEEEEEEKEEEEEEEEEEEKEEEEEEEEEEEKEEEEEEEEEEEKEEEEEEEEEEEKEEEEEEEEEEEK"
print"EEEEEEEEEEEKEEEEEEEEEEEKEEEEEEEEEEEKEEEEEEEEEEEKEEEEEEEEEEEKEEEEEEEEEEEKEEEEEEEEEEEKEEEEEEEEEEEKEEEEEEEEEEEKEEEEEEEEEEEKEEEEEEEEEEEKEEEEEEEEEEEKEEEEEEEEEEEKEEEEEEEEEEEKEEEEEEEEEEEKEEEEEEEEEEEK"
print"EEEEEEEEEEEK"