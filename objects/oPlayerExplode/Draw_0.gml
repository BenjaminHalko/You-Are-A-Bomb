/// @desc

for(var i = 0; i < array_length(p); i++) {
	draw_set_alpha(0.8);
	draw_sprite_part(sprite_index,image_index,p[i].xoffset,p[i].yoffset,1,1,p[i].x,p[i].y);
	draw_set_alpha(1);
	p[i].x += p[i].hsp;
	p[i].vsp += 0.1;
	p[i].y += p[i].vsp;
	if(p[i].y > room_height) {
		array_delete(p,i,1);
		i--;
	}
}

if(array_length(p) == 0) instance_destroy();
