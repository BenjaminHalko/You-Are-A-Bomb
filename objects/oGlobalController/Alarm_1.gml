/// @desc Save Score And Flash Text

if(gameoverNum == 0 and !title) {
	if(OPERA) {
		try gxc_challenge_submit_score(max(global.score[0],global.score[1])*1000,undefined,{challengeId: CHALLENGEID});
		catch(_error) show_debug_message(_error);
	}
	
	if(global.googlePlayIsAvailable) {
		GooglePlayServices_Leaderboard_SubmitScore(GOOGLEPLAYLEADERBOARDID,max(global.score[0],global.score[1])*1000,"");
	}
	
	if(max(global.score[0],global.score[1]) > global.hiscore) {
		global.hiscore = max(global.score[0],global.score[1]);
		newrecord = true;
		if(!OPERA) {
			var _file = file_text_open_write("score");
			file_text_write_real(_file,global.hiscore);
			file_text_close(_file);
		}
	}
}

gameoverNum++;

if(gameoverNum > 8) title = true;
