if SERVER then
	AddCSLuaFile("_g_stuff.lua")
end
GetWorldEntity=GetWorldEntity or game.GetWorld
isDedicatedServer=isDedicatedServer or game.IsDedicated
IsDedicatedServer=IsDedicatedServer or game.IsDedicated
SinglePlayer=SinglePlayer or game.SinglePlayer
MaxPlayers = MaxPlayers or game.MaxPlayers
WorldSound=WorldSound or sound and sound.Play