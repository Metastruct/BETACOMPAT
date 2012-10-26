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


