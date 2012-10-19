local _R_CSoundPatch_ChangeVolume=_R.CSoundPatch.ChangeVolume

_R.CSoundPatch.ChangeVolume=function(a,b,c,d)
	return _R_CSoundPatch_ChangeVolume(a,b,c or 0,d)
end

local _R_CSoundPatch_ChangePitch=_R.CSoundPatch.ChangePitch

_R.CSoundPatch.ChangePitch=function(a,b,c)
	return _R_CSoundPatch_ChangePitch(a,b,c or 0)
end