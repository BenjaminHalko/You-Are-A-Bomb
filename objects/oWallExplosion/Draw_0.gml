/// @desc Draw Explosion

for(var i = 0; i < array_length(p); i++) {
	draw_sprite_part(sWall,0,p[i].xoffset,p[i].yoffset,4,4,p[i].x,p[i].y);
	p[i].x += p[i].hsp;
	p[i].vsp += 0.3;
	p[i].y += p[i].vsp;
	if(p[i].y > global.bottom) {
		array_delete(p,i,1);
		i--;
	}
}

if(array_length(p) == 0) instance_destroy();
