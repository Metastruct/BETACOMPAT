ents.Create=ents.Create or function(ent)
	if ent!="prop_physics" then error"Cant create entities clientside!" end
	return ents.CreateClientProp()
end