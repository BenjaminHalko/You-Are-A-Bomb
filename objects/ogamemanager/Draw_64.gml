/// @desc Draw GUI

draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_font(fontGui);

if(tutorial) draw_text(room_width/2,room_height/4,"MOVE LEFT OR RIGHT TO START");

if(gameoverNum % 2) {
	if(!oGlobalController.title) {
		if(!global.usingMultiplayer)
		draw_text(room_width/2,room_height/2,"GAME OVER");
		else {
			var _max = global.score[0];
			var _name = playerNames[0];
			for(var i = 1; i < 4; i++) {
				if(global.score[i] > _max) {
					_max = global.score[i];
					_name = playerNames[i];
				}
			}
			draw_text(room_width/2,room_height/2,_name+" WINS!");
		}
	} else if(MOBILE) draw_text(room_width/2,room_height-50,"TAP ANYWHERE TO START");
	
	if(newrecord) {
		draw_set_valign(fa_top);
		draw_set_color(c_red);
		draw_text(room_width/2,26-20*MOBILE,"NEW RECORD");
	}
}

if(MOBILE) {
	draw_text(room_width/4+20,6,"SCORE\n"+string(global.score[0] div 60)+":"+string_replace(string_format(global.score[0] % 60,2,2)," ","0"));
	draw_text(room_width/4*3-20,6,"HIGH SCORE\n"+string(global.hiscore div 60)+":"+string_replace(string_format(global.hiscore % 60,2,2)," ","0"));
} else {
	if(!global.usingMultiplayer) {
		draw_text(room_width/4,6,"PLAYER 1\n"+string(global.score[0] div 60)+":"+string_replace(string_format(global.score[0] % 60,2,2)," ","0"));
		draw_text(room_width/4*3,6,"PLAYER 2\n"+string(global.score[1] div 60)+":"+string_replace(string_format(global.score[1] % 60,2,2)," ","0"));
		draw_text(room_width/2,6,"HIGH SCORE\n"+string(global.hiscore div 60)+":"+string_replace(string_format(global.hiscore % 60,2,2)," ","0"));
	} else {
		var _col = [
		c_blue,
		c_lime,
		c_fuchsia,
		#FFAA00];
		for(var i = 0; i < 4; i++) {
			draw_text_transformed_color(room_width/5*(i+1)+16*(i-1.5),6,playerNames[i],min(1,(room_width/5+6)/string_width(playerNames[i])),1,0,_col[i],_col[i],c_white,c_white,1);
			draw_text(room_width/5*(i+1)+16*(i-1.5),6,"\n"+string(global.score[i] div 60)+":"+string_replace(string_format(global.score[i] % 60,2,2)," ","0"));
		}
	}
}