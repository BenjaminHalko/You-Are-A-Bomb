/// @desc

for(var i = 0; i < array_length(p); i++) {
	p[i].x += p[i].hsp;
	p[i].vsp += 0.3;
	p[i].y += p[i].vsp;
	if(p[i].y > room_height) {
		array_delete(p,i,1);
		i--;
	}	
}

if(array_length(p) == 0) instance_destroy();