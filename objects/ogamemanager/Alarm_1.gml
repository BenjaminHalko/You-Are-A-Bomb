/// @desc Save Score And Flash Text

if(!global.usingMultiplayer) {
	if(gameoverNum == 0 and !oGlobalController.title) {
		if(OPERA) {
			try gxc_challenge_submit_score(max(playerScores[0],playerScores[1])*1000,undefined,{challengeId: CHALLENGEID});
			catch(_error) show_debug_message(_error);
		}
	
		if(max(playerScores[0],playerScores[1]) > global.hiscore) {
			global.hiscore = max(playerScores[0],playerScores[1]);
			newrecord = true;
			if(!OPERA) {
				var _file = file_text_open_write("score");
				file_text_write_real(_file,global.hiscore);
				file_text_close(_file);
			}
		}
	}
}

gameoverNum++;

if(gameoverNum == 8 and global.usingMultiplayer) {
	alarm[0] = -1;
	alarm[1] = -1;
	playersLeft = instance_number(oPlayer);
	gameoverNum = 0;
	newrecord = false;
	timerstart = false;
	create = 2;
	amount = minAmount+irandom_range(Min,Max);
	instance_destroy(oEnemy);
	with(oPlayer) {
		event_perform(ev_create,0);
		player = player_id + 1;
		if player_id != 0 image_index = player_id + 1;
	}
	playerScores = [0,0,0,0];
}
else if(gameoverNum > 8) title = true;
