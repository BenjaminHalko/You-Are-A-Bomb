/// @desc

if(gameoverNum == 0 and global.score > global.hiscore and !title) {
	global.hiscore = global.score;
	newrecord = true;
	var _file = file_text_open_write("score");
	file_text_write_real(_file,global.score);
	file_text_close(_file);
}

gameoverNum++;

if(gameoverNum > 8) title = true;
