if SERVER then
	AddCSLuaFile("_g_stuff.lua")
end
GetWorldEntity=GetWorldEntity or game.GetWorld or function() return Entity(0) end
isDedicatedServer=isDedicatedServer or game.IsDedicated or function() return true end
IsDedicatedServer=IsDedicatedServer or game.IsDedicated or function() return true end
SinglePlayer=SinglePlayer or game.SinglePlayer or function() return false end
MaxPlayers = MaxPlayers or game.MaxPlayers or function() return 32 end
WorldSound=WorldSound or sound and sound.Play or function() error"EEK" end
IsVector=IsVector or isvector