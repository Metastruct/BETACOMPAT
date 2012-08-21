local mat = _R.IMaterial
if mat and !mat.GetMaterialMatrix then 
	mat.GetMaterialMatrix = mat.GetMaterialMatrix or mat.GetMatrix
	mat.GetMaterialVector = mat.GetMaterialVector or mat.GetVector
	mat.SetMaterialMatrix = mat.SetMaterialMatrix or mat.SetMatrix
	mat.GetMaterialFloat = mat.GetMaterialFloat or mat.GetFloat
	mat.GetMaterialInt = mat.GetMaterialInt or mat.GetInt
	mat.GetMaterialString = mat.GetMaterialString or mat.GetString
	mat.GetMaterialTexture = mat.GetMaterialTexture or mat.GetTexture
	mat.SetMaterialFloat = mat.SetMaterialFloat or mat.SetFloat
	mat.SetMaterialInt = mat.SetMaterialInt or mat.SetInt
	mat.SetMaterialString = mat.SetMaterialString or mat.SetString
	mat.SetMaterialTexture = mat.SetMaterialTexture or mat.SetTexture
	mat.SetMaterialVector = mat.SetMaterialVector or mat.SetVector
end
