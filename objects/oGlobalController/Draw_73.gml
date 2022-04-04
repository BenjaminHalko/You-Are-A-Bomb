/// @desc

draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_font(fontGui);

draw_text(room_width/4+20,6,"SCORE\n"+string_replace(string_format(global.score,2,2)," ","0"));
draw_text(room_width/4*3-20,6,"HIGH SCORE\n"+string_replace(string_format(global.hiscore,2,2)," ","0"));

if(title) {
	draw_set_valign(fa_bottom);
	var _x = animcurve_channel_evaluate(curve,logo);
	draw_sprite_ext(sLogo,0,room_width/2,room_height/2,_x,_x,0,c_white,_x);
	draw_text(room_width/2,room_height-6,"© 2022 BENJAMIN HALKO\nMADE FOR LUDUM DARE 50");
}

if(gameoverNum % 2) {
	draw_set_valign(fa_middle);
	if(title) draw_text(room_width/2,room_height-48,"PRESS ANY KEY");
	else draw_text(room_width/2,room_height/2,"GAME OVER");
	
	if(newrecord) {
		draw_set_valign(fa_top);
		draw_set_color(c_red);
		draw_text(room_width/2,6,"NEW RECORD");
	}
}
