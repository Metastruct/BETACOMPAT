local _R_CSoundPatch_ChangeVolume=_R.CSoundPatch.ChangeVolume

_R.CSoundPatch.ChangeVolume=function(a,b,c)
	return _R_CSoundPatch_ChangeVolume(a,b or 0,c)
end