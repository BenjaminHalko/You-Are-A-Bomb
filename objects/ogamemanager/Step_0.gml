/// @desc Data

if(global.usingMultiplayer and !rollback_game_running) exit;

if(timerstart and !oGlobalController.title) { tutorial = false; alarm[2] = -1;}

if(playersLeft == 0 and alarm[1] <= 0) alarm[1] = 30;

if(create < room_width div TILE_SIZE - 2) {
	repeat(2) {
		amount += irandom_range(-6*(amount > Min and create != room_width div TILE_SIZE div 2 - 1)+2*(create == room_width div TILE_SIZE div 2 - 1)-2*(create == room_width div TILE_SIZE div 2 + 1),6*(amount < Max)*(create != room_width div TILE_SIZE div 2 + 1))*(create != room_width div TILE_SIZE div 2);
		for(var i = 0; i < room_height div TILE_SIZE; i++) tilemap_set(global.collisionMap,i >= room_height div TILE_SIZE -(minAmount+abs(amount)),create,i);	
		create++;
	}
}

if(timerstart) {
	if playersLeft != 0 {
		if alarm[0] <= 0 alarm[0] = room_speed-room_speed/4*(playersLeft == 2);
	} else alarm[0] = -1;
	if(instance_exists(p1) and !p1.defeated) global.score[0] += 1/60;
	if(instance_exists(p2) and !p2.defeated) global.score[1] += 1/60;
	if(instance_exists(p3) and !p3.defeated) global.score[2] += 1/60;
	if(instance_exists(p4) and !p4.defeated) global.score[3] += 1/60;
} else {
	with(oPlayer) if(timeStart) {
		other.timerstart = true;
		with(oPlayer) timeStart = true;
	}
}

if(!global.usingMultiplayer or rollback_sync_on_frame()) {
	while(array_length(destroyList) > 0) {
		var _data = array_pop(destroyList);
		tilemap_set_at_pixel(global.collisionMap,0,_data[0],_data[1]);
	}
}

if keyboard_check_pressed(vk_escape) and !oGlobalController.title {
	rollback_leave_game();
	oGlobalController.title = true;
	playersLeft = 0;
	timerstart = false;
	instance_destroy(oPlayer);
	instance_destroy(oEnemy);
	global.usingMultiplayer = false;
	playerNames = ["PLAYER 1","PLAYER 2","PLAYER 3","PLAYER 4"];
}