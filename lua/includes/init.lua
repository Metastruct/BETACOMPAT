
--[[---------------------------------------------------------
    Non-Module includes
-----------------------------------------------------------]]

include ( "init_pre.lua" ) 		-- Hack
AddCSLuaFile ( "init_pre.lua" ) 		-- Hack
include ( "util.lua" )			-- Misc Utilities	
include ( "util/sql.lua" )		-- Include sql here so it's 
								-- available at loadtime to modules.

--[[---------------------------------------------------------
    Shared Modules
-----------------------------------------------------------]]

require ( "baseclass" )
require ( "concommand" )		-- Console Commands
require ( "saverestore" )		-- Save/Restore
require ( "gamemode" )			-- Gamemode manager
require ( "weapons" )			-- SWEP manager
require ( "hook" )				-- Gamemode hooks
require ( "timer" )				-- Timer manager
require ( "schedule" )			-- Schedule manager
require ( "scripted_ents" )		-- Scripted Entities
require ( "player_manager" )	-- Player models manager
require ( "numpad" )
require ( "team" )
require ( "undo" )
require ( "cleanup" )
require ( "duplicator" )
require ( "constraint" )
require ( "construct" )	
require ( "usermessage" )
require ( "list" )
require ( "cvars" )
require ( "http" )
require ( "net" )
require ( "rpc" )
require ( "properties" )
require ( "widget" )
require ( "datastream" )

--[[---------------------------------------------------------
    Serverside only modules
-----------------------------------------------------------]]

if ( SERVER ) then

	require ( "server_settings" )
	require ( "ai_schedule" )
	require ( "ai_task" )
	include( "util/entity_creation_helpers.lua" )

end


--[[---------------------------------------------------------
    Clientside only modules
-----------------------------------------------------------]]

if ( CLIENT ) then

	require ( "draw" )			-- 2D Draw library
	require ( "markup" )		-- Text markup library
	require ( "effects" )
	require ( "killicon" )
	require ( "spawnmenu" )
	require ( "controlpanel" )
	require ( "presets" )
	require ( "cookie" )
	require ( "menubar" )
	
	include( "util/model_database.lua" )	-- Store information on models as they're loaded
	include( "util/vgui_showlayout.lua" ) 	-- VGUI Performance Debug
	include( "util/tooltips.lua" )	
	include( "util/client.lua" )
	include( "gui/icon_progress.lua" )

end


--[[---------------------------------------------------------
    Shared modules
-----------------------------------------------------------]]
include( "gmsave.lua" )

--[[---------------------------------------------------------
    Extensions
	
	Load extensions that we specifically need for the menu,
	to reduce the chances of loading something that might 
	cause errors.
-----------------------------------------------------------]]

include ( "extensions/file.lua" )
include ( "extensions/angle.lua" )
include ( "extensions/debug.lua" )
include ( "extensions/entity.lua" )
include ( "extensions/ents.lua" )
include ( "extensions/math.lua" )	
include ( "extensions/player.lua" )
include ( "extensions/player_auth.lua" )
include ( "extensions/string.lua" )
include ( "extensions/table.lua" )
include ( "extensions/util.lua" )
include ( "extensions/vector.lua" )

if ( CLIENT ) then
	include ( "extensions/client/entity.lua" )
	include ( "extensions/client/globals.lua" )
	include ( "extensions/client/panel.lua" )
	include ( "extensions/client/player.lua" )
	include ( "extensions/client/render.lua" )
end

--[[---------------------------------------------------------
    Print version information to the console
-----------------------------------------------------------]]

Msg( _VERSION .. " initialized on Garry's Mod "..VERSION.."\n" )

AddCSLuaFile ( "init_post.lua" ) 		-- Hack
include ( "init_post.lua" )

if ( SERVER ) then

	concommand.Add( "+numpad", CC_NumpadOn )
	concommand.Add( "-numpad", CC_NumpadOff )
	
end
