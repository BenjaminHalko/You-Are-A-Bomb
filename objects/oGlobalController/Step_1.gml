/// @desc

if(create < room_width div TILE_SIZE - 2) {
	repeat(2) {
		amount += irandom_range(-6*(amount > Min and create != room_width div TILE_SIZE div 2 - 1)+2*(create == room_width div TILE_SIZE div 2 - 1)-2*(create == room_width div TILE_SIZE div 2 + 1),6*(amount < Max)*(create != room_width div TILE_SIZE div 2 + 1))*(create != room_width div TILE_SIZE div 2);
		for(var i = 0; i < room_height div TILE_SIZE; i++) tilemap_set(global.collisionMap,i >= room_height div TILE_SIZE -(minAmount+abs(amount)),create,i);	
		create++;
	}
}



if(timerstart) {
	if(instance_exists(p1)) global.score[0] += 1/60;
	if(instance_exists(p2)) global.score[1] += 1/60;
} else {
	with(oPlayer) if(timeStart) {
		other.timerstart = true;
		with(oPlayer) timeStart = true;
	}
}

if(global.score[0] > 0 and alarm[0] <= 0 and !title) { alarm[0] = room_speed-room_speed/4*(instance_number(oPlayer) == 2); tutorial = false; alarm[2] = -1;}

if(!instance_exists(oPlayer) and alarm[1] <= 0) alarm[1] = 30;

if title and !MOBILE and (keyboard_check_pressed(vk_up) or keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("W")) or keyboard_check_pressed(ord("S"))) {
	choice = !choice;
	audio_sound_pitch(audio_play_sound(snPickup,2,false),1.4);
}

if(keyboard_check_pressed(vk_enter) or keyboard_check_pressed(vk_space) or keyboard_check_pressed(vk_shift) or keyboard_check_pressed(vk_control) or (mouse_check_button_pressed(mb_left) and MOBILE)) {
	if(title) {
		if(choice == 0) {
			p1 = instance_create_layer(room_width/2,room_height/4,"Player",oPlayer);
			p2 = noone;
		} else {
			p1 = instance_create_layer(room_width/3,room_height/4,"Player",oPlayer);
			p1.player = 1;
			p2 = instance_create_layer(room_width/3*2,room_height/4,"Player",oPlayer);
			p2.player = 2;
			p2.image_index = 2;
		}
		instance_destroy(oEnemy);
		alarm[0] = -1;
		alarm[1] = -1;
		amount = minAmount+irandom_range(Min,Max);
		create = 2;
		gameoverNum = 0;
		title = false;
		timerstart = false;
		logo = 0;
		newrecord = false;
		global.score = [0,0];
		alarm[2] = room_speed*5;
	} else if(!instance_exists(oPlayer) and gameoverNum > 1) title = true;
}

if(title) logo = Approach(logo,1,0.05);

if BROWSER and (browser_width != width || browser_height != height)
{
	width = browser_width;
	height = browser_height;
	scale_canvas(480,256,width,height);
}

if MOBILE {
	var _jumpHeld = jumpScreen;
	var _top = screenButtonY-24;
	var _bottom = screenButtonY+24;
	leftScreen = false;
	rightScreen = false;
	jumpScreen = false;
	jumpIsPressed = false;
	
	for(var i = 0; i < 5; i++) {
		if(!device_mouse_check_button(i, mb_left)) continue;
		
		var _px = device_mouse_x(i);
		var _py = device_mouse_y(i);
		
		if(point_in_rectangle(_px,_py,leftScreenX-24,_top,leftScreenX+32,_bottom)) leftScreen = true;
		else if(point_in_rectangle(_px,_py,rightScreenX-32,_top,rightScreenX+24,_bottom)) rightScreen = true;
		else if(point_in_circle(_px,_py,jumpScreenX,screenButtonY,24)) {
			jumpScreen = true;
			if(!_jumpHeld) jumpIsPressed = true;
		}
	}
}
