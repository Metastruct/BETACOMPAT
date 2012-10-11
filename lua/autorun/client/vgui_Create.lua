local vgui_Create=vgui.Create

local fixtable={
 ["dlabel"]="DLabel",
 ["dbutton"]="DButton"
}

vgui.Create=function(a,...)
	a=fixtable[a] or a
	
	local ret = vgui_Create(a,...)
	if !a or a:gsub(" ","")=="" then
		error "totally missing control name??"
	end
	return ret
end