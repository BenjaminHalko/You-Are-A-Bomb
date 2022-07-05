/// @desc Handle Disconnection

if rollback_event_id == rollback_disconnected_from_peer {
	oGameManager.playersLeft -= 1;
	with(oPlayer) {
		if(player_id == rollback_event_param.player_id) {
			var _explosionSize = 6*TILE_SIZE;
			for(var i = x-_explosionSize; i < x+_explosionSize; i+=TILE_SIZE) {
				for(var j = y-_explosionSize; j < y+_explosionSize; j+=TILE_SIZE) {
					if(tilemap_get_at_pixel(global.collisionMap,i,j) != 1 or !point_in_circle(i,j,x,y,_explosionSize)) continue;
					array_push(oGameManager.destroyList,[i,j]);
					instance_create_layer(i-(i mod TILE_SIZE),j-(j mod TILE_SIZE),layer,oWallExplosion);
				}
			}
			with(instance_create_layer(x,y,layer,oPlayerExplode)) index = other.image_index;
			instance_create_layer(x,y,layer,oPlayerExplosion);
		}
	}
}