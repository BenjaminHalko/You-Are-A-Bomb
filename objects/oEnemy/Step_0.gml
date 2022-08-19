/// @desc Enemy Behaviour

vsp += grv;

vsp_final = vsp + vsp_f;
vsp_f = vsp_final - floor(abs(vsp_final))*sign(vsp_final);
vsp_final -= vsp_f;

bounceSpd -= 0.4;
bounce = max(0,bounce+bounceSpd);

if(!instance_exists(activeId) or activeId.defeated) activeId = noone;

if(timer <= 0 or y > room_height) {
	var _explosionSize = random_range(4,6)*TILE_SIZE;
	
	if(activeId == noone) {
		if(scale > 2) {
			instance_create_layer(x,y,layer,oPlayerExplosion);
	 		for(var i = x-_explosionSize; i < x+_explosionSize; i+=TILE_SIZE) {
				for(var j = y-_explosionSize; j < y+_explosionSize; j+=TILE_SIZE) {
					if(tilemap_get_at_pixel(oGameManager.collisionMap,i,j) != 1 or !point_in_circle(i,j,x,y,_explosionSize)) continue;
					array_push(oGameManager.destroyList,[i,j]);
					instance_create_layer(i-(i mod TILE_SIZE),j-(j mod TILE_SIZE),layer,oWallExplosion);
				}
			}
			instance_create_layer(x,y,layer,oPlayerExplode);
			instance_destroy();
		} else {
			scale += 0.3;	
		}
	}
	
	timer = 0;
	exit;
} else timer -= 1/60;

if(activeId != noone) exit;

//Vertical Tiles
if (tilemap_get_at_pixel(oGameManager.collisionMap, bbox_right, bbox_bottom + vsp_final) || tilemap_get_at_pixel(oGameManager.collisionMap, bbox_left, bbox_bottom + vsp_final)) or (vsp_final >= 8 and (tilemap_get_at_pixel(oGameManager.collisionMap, bbox_right, bbox_bottom + vsp_final/2) || tilemap_get_at_pixel(oGameManager.collisionMap, bbox_left, bbox_bottom + vsp_final/2)))
{
	y = y - (bbox_bottom mod TILE_SIZE);
	if (sign(vsp) == 1) {
		y += TILE_SIZE - 1;
		if(!bounced) {
			bounceSpd = 1.5;
			bounced = true;
			audio_play_sound(snLand,2,false);
		}
	}
	vsp = 0;
	vsp_final = 0;
	
}
	
//Vertical Move Commit
y += vsp_final;
