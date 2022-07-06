/// @desc Draw Explosion

for(var i = 0; i < array_length(p); i++) {
	draw_sprite_part(sWall,0,p[i].xoffset,p[i].yoffset,4,4,p[i].x,p[i].y);
}
