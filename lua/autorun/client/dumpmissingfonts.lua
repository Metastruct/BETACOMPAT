concommand.Add("dumpmissingfonts",function() 
	for k,v in pairs(missingfonts) do
		print(k)
	end
end)