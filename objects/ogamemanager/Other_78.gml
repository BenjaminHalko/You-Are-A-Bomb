/// @desc

if rollback_event_id == rollback_disconnected_from_peer {
	playersLeft -= 1;
	if instance_number(oPlayer) == 1 {
		global.usingMultiplayer = false;
		rollback_leave_game();
		oPlayer.player = 0;
		if oPlayer.starting < 2 oPlayer.x = room_width/2;
	}
}