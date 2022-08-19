/// @desc

if instance_number(oPlayer) == 1 {
	global.usingMultiplayer = false;
	rollback_leave_game();
	oPlayer.player = 0;
	if oPlayer.starting < 2 oPlayer.x = room_width/2;
}