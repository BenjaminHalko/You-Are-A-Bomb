/// @desc
if(starting < 2) {
	starting = Approach(starting,2,0.05);
	scale = animcurve_channel_evaluate(startCurve,min(1,starting));
	exit;
}

Input();

if(timer <= 0 or y > room_height) {
	oGlobalController.timerstart = false;
	var _explosionSize = 6*TILE_SIZE;
	
	if(scale > 2) {
		instance_create_layer(x,y,layer,oPlayerExplosion);
 		for(var i = x-_explosionSize; i < x+_explosionSize; i+=TILE_SIZE) {
			for(var j = y-_explosionSize; j < y+_explosionSize; j+=TILE_SIZE) {
				if(tilemap_get_at_pixel(global.collisionMap,i,j) != 1 or !point_in_circle(i,j,x,y,_explosionSize)) continue;
				tilemap_set_at_pixel(global.collisionMap,0,i,j);
				instance_create_layer(i-(i mod TILE_SIZE),j-(j mod TILE_SIZE),layer,oWallExplosion);
			}
		}
		instance_create_layer(x,y,layer,oPlayerExplode);
		instance_create_layer(x,y,layer,oPlayerExplosion);
		instance_destroy();
	} else {
		scale += 0.3;
	}
	
	timer = 0;
	exit;
} else if(timeStart) timer -= 1/60;

if(key_left != key_right) timeStart = true;

with(oEnemy) {
	var _radius = 24;
	if(point_in_circle(x,y,other.x,other.y,_radius) or active > 0) {
		var _dist = min(point_distance(x,y,other.x,other.y),active);
		var _dir = point_direction(x,y,other.x,other.y);
		x += lengthdir_x(_dist,_dir);
		y += lengthdir_y(_dist,_dir);
		if(round(x) == other.x and round(y) == other.y) {
			with(instance_create_layer(other.x,other.y-16,other.layer,oScore)) amount = string(other.timer);
			other.timer = min(21,other.timer+timer);
			other.maxTime = other.timer;
			instance_destroy();
			audio_play_sound(snPickup,2,false);
		}
		
		active += 0.5;
		other.scale = max(other.scale,1.5/(1-_dist/_radius));
	}
}

hsp = Approach(hsp,0,0.3);
hsp = median(-maxwalk,maxwalk,hsp+(key_right - key_left)*walkspd);
vsp += grv;

if((canJump-- > 0 or doubleJump) && key_jump) {
	vsp = jumpspd;
	if(canJump <= 0) {
		doubleJump = 0;
		instance_create_depth(x,y-round(bounce),depth+1,oPlayerJump);
	}
	audio_play_sound(snJump,2,false);
	canJump = 0;
	
}

bounceSpd -= 0.4;
bounce = max(0,bounce+bounceSpd);

scale = Approach(scale,1,0.1);

hsp_final = hsp + hsp_f;
hsp_f = hsp_final - floor(abs(hsp_final))*sign(hsp_final);
hsp_final -= hsp_f;
 
vsp_final = vsp + vsp_f;
vsp_f = vsp_final - floor(abs(vsp_final))*sign(vsp_final);
vsp_final -= vsp_f;

var _xbbox, _ybbox;
if(hsp > 0) _xbbox = bbox_right; else _xbbox = bbox_left;
if(vsp > 0) _ybbox = bbox_bottom; else _ybbox = bbox_top;

//Horizontal Tiles
if (tilemap_get_at_pixel(global.collisionMap, _xbbox + hsp_final, bbox_top) || tilemap_get_at_pixel(global.collisionMap, _xbbox + hsp_final, bbox_bottom))
{
	x = x - (_xbbox mod TILE_SIZE);
	if (sign(hsp) == 1) x += TILE_SIZE - 1;
	hsp = 0;
	hsp_final = 0;
}
	
//Horizontal Move Commit
x += hsp_final;
	
//Vertical Tiles
if (tilemap_get_at_pixel(global.collisionMap, bbox_right, _ybbox + vsp_final) || tilemap_get_at_pixel(global.collisionMap, bbox_left, _ybbox + vsp_final))
{
	y = y - (_ybbox mod TILE_SIZE);
	if (sign(vsp) == 1) {
		y += TILE_SIZE - 1;
		if(canJump < 8) {
			bounceSpd = 1.5;
			audio_play_sound(snLand,2,false);
		}
		canJump = 10;
		doubleJump = 1;
	}
	vsp = 0;
	vsp_final = 0;
	
}
	
//Vertical Move Commit
y += vsp_final;

if(key_left != key_right && bounce == 0 && canJump > 0) {
	bounceSpd = 2;
	audio_play_sound(snWalk,2,false);
}
