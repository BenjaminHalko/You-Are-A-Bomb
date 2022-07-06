/// @desc

if rollback_event_id == rollback_game_info {
	canContinue = true;
}

if rollback_event_id == rollback_game_full or rollback_event_id == rollback_connect_error {
	rollback_leave_game();
	title = true;
	oGameManager.playersLeft = 0;
	oGameManager.timerstart = false;
	instance_destroy(oPlayer);
	instance_destroy(oEnemy);
	global.usingMultiplayer = false;
	oGameManager.playerNames = ["PLAYER 1","PLAYER 2","PLAYER 3","PLAYER 4"];
}