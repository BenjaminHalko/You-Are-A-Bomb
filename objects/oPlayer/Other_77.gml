/// @desc Game Start

oGameManager.playersLeft = instance_number(oPlayer);
if !global.usingMultiplayer exit;
player = player_id + 1
if player_id != 0 image_index = player_id + 1;

var _info = rollback_get_info(player_id);

if _info.player_type == "User" {
	oGameManager.playerNames[player_id] = _info.player_name;
}