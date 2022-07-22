/// @desc
draw_rectangle_color(0,0,room_width,room_height/2,#260000,#260000,c_black,c_black,false);
draw_set_color(c_black);

for(var i = 0; i < array_length(global.b); i++) {
	if(global.b[i].wait > 0) global.b[i].wait--;
	else {
		global.b[i].vsp += 0.3*global.b[i].scale;
		global.b[i].y += global.b[i].vsp;
		draw_circle(global.b[i].x,global.b[i].y,6*global.b[i].scale,false);
		if(global.b[i].y > room_height) {
			global.b[i].y = -12;
			global.b[i].wait = irandom(60*3);
			global.b[i].x = irandom(room_width);
			global.b[i].scale = random_range(0.3,1);
			global.b[i].vsp = 0;
		}
	}
}

if !surface_exists(surface) {
	surface = surface_create(room_width,room_height);
	surface_set_target(surface);
	var _size = 2;
	for(var i = 0; i < array_length(global.backgrid); i++) draw_rectangle(i*_size,room_height,(i+1)*_size-(os_browser == browser_not_a_browser),room_height-global.backgrid[i]*_size,false);

	_size = 4;
	draw_set_color(c_dkgray);
	for(var i = 0; i < array_length(global.frontgrid); i++) draw_sprite_ext(sWallBackground,0,i*_size,room_height,1,global.frontgrid[i],0,merge_color(c_white,c_black,0.9),1);
	surface_reset_target();
}

draw_surface(surface,0,0);
gpu_set_blendmode(bm_subtract);
draw_rectangle_color(0,room_height/3*2,room_width,room_height,c_black,c_black,c_white,c_white,false);
gpu_set_blendmode(bm_normal);