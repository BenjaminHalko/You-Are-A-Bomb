/// @desc

if(create < room_width div TILE_SIZE - 2) {
	repeat(2) {
		amount += irandom_range(-6*(amount > Min and create != room_width div TILE_SIZE div 2 - 1)+2*(create == room_width div TILE_SIZE div 2 - 1)-2*(create == room_width div TILE_SIZE div 2 + 1),6*(amount < Max)*(create != room_width div TILE_SIZE div 2 + 1))*(create != room_width div TILE_SIZE div 2);
		for(var i = 0; i < room_height div TILE_SIZE; i++) tilemap_set(global.collisionMap,i >= room_height div TILE_SIZE -(minAmount+abs(amount)),create,i);	
		create++;
	}
}



if(timerstart) global.score += 1/60;
else if(instance_exists(oPlayer) and oPlayer.timeStart) timerstart = true;

if(global.score > 0 and alarm[0] <= 0 and !title) alarm[0] = room_speed;

if(!instance_exists(oPlayer) and alarm[1] <= 0) alarm[1] = 30;

if(keyboard_check_pressed(vk_anykey)) {
	if(title) {
		instance_create_layer(room_width/2,room_height/4,"Player",oPlayer);
		instance_destroy(oEnemy);
		alarm[0] = -1;
		alarm[1] = -1;
		amount = minAmount+irandom_range(Min,Max);
		create = 2;
		gameoverNum = 0;
		title = false;
		timerstart = false;
		logo = 0;
		global.score = 0;
	} else if(!instance_exists(oPlayer) and gameoverNum > 1) title = true;
}

if(title) logo = Approach(logo,1,0.05);

if BROWSER and (browser_width != width || browser_height != height)
{
	width = browser_width;
	height = browser_height;
	scale_canvas(480,256,width,height);
}
