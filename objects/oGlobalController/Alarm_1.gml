/// @desc

if(gameoverNum == 0 and max(global.score[0],global.score[1]) > global.hiscore and !title) {
	global.hiscore = max(global.score[0],global.score[1]);
	newrecord = true;
	var _file = file_text_open_write("score");
	file_text_write_real(_file,max(global.score[0],global.score[1]));
	file_text_close(_file);
}

gameoverNum++;

if(gameoverNum > 8) title = true;
