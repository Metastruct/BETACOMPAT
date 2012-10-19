local _R_Entity_SetModelScale=_R.Entity.SetModelScale
_R.Entity.SetModelScale = function(ent,scale,time,x)
	time=time or 0.1
	if type(scale)=="number" then
		return _R_Entity_SetModelScale(ent,scale,time,x)
	end
	if scale and scale.x and scale.y and scale.z then
		local matrix=Matrix()
		if ent:GetBoneName(0) == "static_prop" then
			matrix:Scale(scale)
		else
			matrix:Scale(Vector(scale.y, scale.x, scale.z))
		end
		ent:EnableMatrix("RenderMultiply", matrix)
	else
		error"Invalid parameters"
	end
end


