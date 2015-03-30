ents.Create=ents.Create or function(ent)
	if ent!="prop_physics" then error"Cant create entities clientside!" end
	return ents.CreateClientProp()
end
_ClientsideModel=ClientsideModel
ClientsideModel=function(mdl) -- ClientsideModel is broken so let's redefine it like this
	local e = ents.CreateClientProp()
	e:SetModel(mdl)
	return e
end