local _R_CSoundPatch_ChangeVolume=_R.CSoundPatch.ChangeVolume

_R.CSoundPatch.ChangeVolume=function(a,b,c)
	return _R_CSoundPatch_ChangeVolume(a,b,c or 0)
end