local _R_Entity_SetModelScale=_R.Entity.SetModelScale
_R.Entity.SetModelScale = function(ent,scale,time,x)
	time=time or 0.1
	if type(scale)=="number" then
		return _R_Entity_SetModelScale(ent,scale,time,x)
	end
	if scale and scale.x and scale.y and scale.z then
		local matrix=Matrix()
		matrix:Scale(scale)
		ent:EnableMatrix("RenderMultiply", matrix)
	end
	error"Invalid parameters"
end