function Approach(a, b, amount) {
	if (a < b)
	{
	    a += amount;
	    if (a > b)
	        return b;
	}
	else
	{
	    a -= amount;
	    if (a < b)
	        return b;
	}
	return a;
}

function ValuePercent(_x, _a, _b) {
	return (_x - _a) / (_b - _a);
}

function PlayerDraw() {
	var _yExtra = round(bounce);
	var _top = y - (y - bbox_top)*scale;

	draw_sprite_ext(sprite_index,image_index,x+random_range(-3,3)*max(1-timer,0),y-_yExtra+random_range(-3,3)*max(1-timer,0),scale,scale,0,c_white,1);

	#region Draw Fuse
	if(timer > 0) {
	var _time = timer/maxTime;
	var _len;
	var _x = x;
	var _y = _top-3;
	draw_set_color(c_grey);

	if(_time > 1/8) {
		_len = min(2*ValuePercent(_time,1/8,3/8),2);
		draw_line(x+(BROWSER || OPERA),_top-3-_yExtra+(BROWSER || OPERA),x-_len+(BROWSER || OPERA),_top-3-_len-_yExtra+(BROWSER || OPERA));
		_x = x-_len;
		_y = _top-3-_len;
	}
	if(_time > 3/8) {
		_len = min(3*ValuePercent(_time,3/8,6/8),3)
		draw_line(x-2+(BROWSER || OPERA),_top-5-_yExtra+(BROWSER || OPERA),x-2-_len+(BROWSER || OPERA),_top-5-_yExtra+(BROWSER || OPERA));
		_x = floor(x-1-_len);
		_y = _top-5;
	}

	if(_time > 6/8) {
		_len = min(2,2*ValuePercent(_time,6/8,1));
		draw_line(x-5+(BROWSER || OPERA),_top-5-_yExtra+(BROWSER || OPERA),x-5-_len+(BROWSER || OPERA),_top-5+_len-_yExtra+(BROWSER || OPERA));
		_x = x-5-_len;
		_y = _top-5+_len;
	}

	draw_sprite_ext(sPlayerSpark,-1,_x+1,_y+1-_yExtra,random_range(1,1.5),random_range(1,1.5),random(360),c_white,1);
	}
	#endregion

	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(fontPlayer);

	var _text = string_replace(string_format(timer,1,1)," ","0");

	if(string_length(_text) > 3) draw_text_transformed(x+1,y-_yExtra,floor(timer),min(1,scale),min(1,scale),0);
	else draw_text_transformed(x+1,y-_yExtra,_text,min(1,scale),min(1,scale),0);
}

function scale_canvas(_bw,_bh,_cw,_ch) {
	var _aspect = (_bw / _bh);

	if ((_cw / _aspect) > _ch) window_set_size((_ch *_aspect), _ch);
	else window_set_size(_cw, (_cw / _aspect));
	window_center();
}

function StartGame() {
	with(oGameManager) {
		if(other.choice == 0) {
			global.usingMultiplayer = false;
			playersLeft = 1;
			p1 = instance_create_layer(room_width/2,room_height/4,"Instances",oPlayer);
			p2 = noone;
			alarm[2] = room_speed*5;
		} else if(other.choice == 1) {
			global.usingMultiplayer = false;
			playersLeft = 2;
			p1 = instance_create_layer(room_width/3,room_height/4,"Instances",oPlayer);
			p1.player = 1;
			p2 = instance_create_layer(room_width/3*2,room_height/4,"Instances",oPlayer);
			p2.player = 2;
			p2.image_index = 2;
			alarm[2] = room_speed*5;
		} else {
			global.usingMultiplayer = true;
			rollback_define_input({
				left: [vk_left,ord("A"),gp_padl],
				right: [vk_right,ord("D"),gp_padr],
				jump: [vk_space,vk_shift,vk_control,vk_up,ord("W"),gp_face1,gp_face2,gp_face3,gp_face4],
				axisH: gp_axislh
			});
			rollback_define_player(oPlayer);
			if (!rollback_join_game()) {
				rollback_create_game(4,!OPERA);
				other.multiplayerCreated = true;
			} else other.multiplayerCreated = false;
			playerNames = ["PLAYER 1","PLAYER 2","PLAYER 3","PLAYER 4"];
			other.create = 2;
		}
		alarm[0] = -1;
		alarm[1] = -1;
		gameoverNum = 0;
		newrecord = false;
		timerstart = false;
		create = 2;
		amount = minAmount+irandom_range(Min,Max);
		playerScores = [0,0,0,0];
		total = 0;
		totalSubtract = 0;
	}
	instance_destroy(oEnemy);
	title = false;
	logo = 0;
}