/// @desc Draw GUI

draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_font(fontGui);

if(global.usingMultiplayer and !rollback_game_running) {
	draw_set_valign(fa_middle);
	if (!canContinue) 
		draw_text(room_width/2,room_height/2,"CONNECTING...");
	else if (multiplayerCreated) or true
		draw_text(room_width/2,room_height/2,"WAITING FOR PLAYERS...\n\nPRESS ENTER TO START EARLY");
	else
		draw_text(room_width/2,room_height/2,"WAITING FOR PLAYERS...");
}

if(title) {
	if(!MOBILE) {
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_text(room_width/2-30,room_height-76,"1 PLAYER");
		draw_text(room_width/2-30,room_height-60,"2 PLAYER");
		if(challenge) draw_text_color(room_width/2-30,room_height-38,"ONLINE MULTIPLAYER",c_white,c_white,c_dkgray,c_dkgray,0.7);
		else draw_text(room_width/2-30,room_height-38,"ONLINE MULTIPLAYER");
		draw_text(room_width/2-40,room_height-76+16*choice+6*(choice == 2),">");
		draw_set_halign(fa_center);
	} else if(oGameManager.gameoverNum % 2) draw_text(room_width/2,room_height-50,"TAP ANYWHERE TO START");
	draw_set_valign(fa_bottom);
	var _x = animcurve_channel_evaluate(curve,logo);
	draw_sprite_ext(sLogo,0,room_width/2,room_height/2-16,_x,_x,0,c_white,_x);
	draw_text(room_width/2,room_height-6,"© 2022 BENJAMIN HALKO\nMADE FOR LUDUM DARE 50");
	
	
}

if(MOBILE) {
	draw_sprite_ext(sScreenButtons,0,leftScreenX+1,screenButtonY+1,1,1,0,c_black,0.4);
	draw_sprite_ext(sScreenButtons,0,rightScreenX+1,screenButtonY+1,-1,1,0,c_black,0.4);
	draw_sprite_ext(sScreenButtons,2,jumpScreenX+1,screenButtonY+1,1,1,0,c_black,0.4);
	
	draw_sprite(sScreenButtons,leftScreen,leftScreenX,screenButtonY);
	draw_sprite_ext(sScreenButtons,rightScreen,rightScreenX,screenButtonY,-1,1,0,c_white,1);
	draw_sprite(sScreenButtons,2+jumpScreen,jumpScreenX,screenButtonY);
}
