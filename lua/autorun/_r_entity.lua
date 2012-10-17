local _R_Entity_SetColor=_R.Entity.SetColor
local Color=Color
_R.Entity.SetColor=function(e,r,g,b,a) 
	return _R_Entity_SetColor(e,g and b and Color(r,g,b,a or 255) or r)
end
if CLIENT then
	local _R_Entity_SetModeScale=_R.Entity.SetModeScale
	_R.Entity.SetModeScale=function(ent,scale,time,x)
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
end