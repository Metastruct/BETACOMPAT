local _R_Entity_SetColor=_R.Entity.SetColor
local Color=Color
_R.Entity.SetColor=function(e,r,g,b,a) 
	return _R_Entity_SetColor(e,g and b and Color(r,g,b,a or 255) or r)
end

_R.Entity.SetShouldDrawInViewMode = function() --[[TODO]] end