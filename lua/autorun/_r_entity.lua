local _R_Entity_SetColor=_R.Entity.SetColor
local Color=Color
_R.Entity.SetColor=function(r,g,b,a) 
	return _R_Entity_SetColor(g and b and Color(r,g,b,a or 255) or r)
end