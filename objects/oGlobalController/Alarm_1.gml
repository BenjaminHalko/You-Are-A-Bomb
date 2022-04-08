/// @desc

if(gameoverNum == 0 and max(global.score[0],global.score[1]) > global.hiscore and !title) {
	global.hiscore = max(global.score[0],global.score[1]);
	newrecord = true;
	if(OPERA) {
		try gxc_challenge_submit_score(global.hiscore*1000,undefined,{challengeId: CHALLENGEID});
		catch(_error) show_debug_message(_error);
	} else {
		var _file = file_text_open_write("score");
		file_text_write_real(_file,global.hiscore);
		file_text_close(_file);
	}
}

gameoverNum++;

if(gameoverNum > 8) title = true;
