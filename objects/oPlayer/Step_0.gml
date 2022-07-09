/// @desc Player Behaviour

if(defeated) exit;

if(starting < 2) {
	starting = Approach(starting,2,0.05);
	scale = animcurve_channel_evaluate(animcurve_get_channel(PlayerStartCurve,0),min(1,starting));
	exit;
}

//Input
var _gpLeft = false;
var _gpRight = false;
var _gpJump = false;
for(var i = 0; i < gamepad_get_device_count(); i++) {
	if(gamepad_button_check(i,gp_padl) or gamepad_axis_value(i,gp_axislh) <= -0.5) _gpLeft = true;
	if(gamepad_button_check(i,gp_padr) or gamepad_axis_value(i,gp_axislh) >= 0.5) _gpRight = true;
	for(var j = gp_face1; j <= gp_face4; j++) if(gamepad_button_check_pressed(i,j)) _gpJump = true;
}

if(_gpLeft or _gpRight or _gpJump) global.usingGamepad = true;

if (global.usingMultiplayer) {
	var _input = rollback_get_input();
	key_left = _input.left;
	key_right = _input.right;
	key_jump = _input.jump_pressed;
} else if(player == 0) or (player == 2 and global.usingGamepad) {
	key_left = keyboard_check(vk_left) or keyboard_check(ord("A")) or oGlobalController.leftScreen or (_gpLeft and player == 0);	
	key_right = keyboard_check(vk_right) or keyboard_check(ord("D")) or oGlobalController.rightScreen or (_gpRight and player == 0);	
	key_jump = keyboard_check_pressed(vk_space) or keyboard_check_pressed(vk_shift) or keyboard_check_pressed(vk_control) or keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W")) or oGlobalController.jumpIsPressed or (_gpJump and player == 0);	
} else if(global.usingGamepad) { 
	key_left = _gpLeft;
	key_right = _gpRight;
	key_jump = _gpJump;
} else if(player == 1) {
	key_left = keyboard_check(ord("A"));	
	key_right = keyboard_check(ord("D"));	
	key_jump = keyboard_check_pressed(vk_space) or keyboard_check_pressed(ord("W"));
} else {
	key_left = keyboard_check(vk_left);	
	key_right = keyboard_check(vk_right);	
	key_jump = keyboard_check_pressed(vk_shift) or keyboard_check_pressed(vk_control) or keyboard_check_pressed(vk_up);
}

if(timer <= 0 or y > room_height) {
	var _explosionSize = 6*TILE_SIZE;
	
	if(scale > 2) {
 		for(var i = x-_explosionSize; i < x+_explosionSize; i+=TILE_SIZE) {
			for(var j = y-_explosionSize; j < y+_explosionSize; j+=TILE_SIZE) {
				if(tilemap_get_at_pixel(global.collisionMap,i,j) != 1 or !point_in_circle(i,j,x,y,_explosionSize)) continue;
				array_push(oGameManager.destroyList,[i,j]);
				instance_create_layer(i-(i mod TILE_SIZE),j-(j mod TILE_SIZE),layer,oWallExplosion);
			}
		}
		with(instance_create_layer(x,y,layer,oPlayerExplode)) index = other.image_index;
		instance_create_layer(x,y,layer,oPlayerExplosion);
		defeated = true;
		oGameManager.playersLeft -= 1;
	} else {
		scale += 0.3;
	}
	
	timer = 0;
	exit;
} else if(oGameManager.timerstart) timer -= 1/60;

if(key_left != key_right) oGameManager.timerstart = true;

with(oEnemy) {
	var _radius = 24;
	if(point_in_circle(x,y,other.x,other.y,_radius) or activeId == other.id) {
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
		activeId = other.id;
	}
}

hsp = Approach(hsp,0,0.3);
hsp = median(-maxwalk,maxwalk,hsp+(key_right - key_left)*walkspd);
vsp += grv;

if(key_jump) jumpTimer = 10;

if((canJump-- > 0 or doubleJump) && jumpTimer > 0) {
	vsp = jumpspd;
	if(canJump <= 0) {
		doubleJump = 0;
		var _jump = instance_create_depth(x,y-round(bounce),depth+1,oPlayerJump);
		if(player == 2) _jump.col = #00996B;
		else if(player == 3) _jump.col = #99007A;
		else if(player == 4) _jump.col = #995200;
	}
	audio_play_sound(snJump,2,false);
	canJump = 0;
	jumpTimer = 0;
}

jumpTimer--;
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
if (tilemap_get_at_pixel(global.collisionMap, bbox_right, _ybbox + vsp_final) || tilemap_get_at_pixel(global.collisionMap, bbox_left, _ybbox + vsp_final)) or (vsp_final >= 8 and (tilemap_get_at_pixel(global.collisionMap, bbox_right, _ybbox + vsp_final/2) || tilemap_get_at_pixel(global.collisionMap, bbox_left, _ybbox + vsp_final/2)))
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
