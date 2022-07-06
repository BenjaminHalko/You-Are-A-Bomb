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
		if alarm[0] <= 0 alarm[0] = room_speed-room_speed/4*min(3,playersLeft - 1);
	} else alarm[0] = -1;
	
	if(global.usingMultiplayer) total = (rollback_current_frame-totalSubtract)/60;
	else total += 1/60;
	if(instance_exists(p1) and !p1.defeated) playerScores[0] = total;
	if(instance_exists(p2) and !p2.defeated) playerScores[1] = total;
	if(instance_exists(p3) and !p3.defeated) playerScores[2] = total;
	if(instance_exists(p4) and !p4.defeated) playerScores[3] = total;
} else if(global.usingMultiplayer) {
	totalSubtract = rollback_current_frame;
	for(var i = 0; i < instance_number(oPlayer); i++) {
		if instance_find(oPlayer,i).timer == 0 continue;
		instance_find(oPlayer,i).x = room_width/(instance_number(oPlayer)+1)*(i+1);	
	}
}

if array_length(destroyList) > 0 and (!global.usingMultiplayer or rollback_sync_on_frame()) {
	while(array_length(destroyList) > 0) {
		var _data = array_pop(destroyList);
		tilemap_set_at_pixel(global.collisionMap,0,_data[0],_data[1]);
	}
}