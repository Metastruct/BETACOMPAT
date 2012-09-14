local vgui_Create=vgui.Create

vgui.Create=function(a,...)
	local ret = vgui_Create(a,...)
	if !a or a:gsub(" ","")=="" then
		error "totally missing control name??"
	end
	if !ret then
		local x,y=a:match("(..)(.*)") -- DLabel 
		if x then
			local a=x:upper()..y:lower()
			ret = vgui_Create(a,...)
		end
	end
	if !ret then
		local x,y=a:match("(.)(.*)") -- Label
		if x then
			local a=x:upper()..y:lower()
			ret = vgui_Create(a,...)
		end
	end
	return ret
end