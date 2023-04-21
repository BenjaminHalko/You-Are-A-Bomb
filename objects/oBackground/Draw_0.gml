/// @desc
draw_rectangle_color(0,0,room_width,room_height-136,#260000,#260000,c_black,c_black,false);
draw_set_color(c_black);

for(var i = 0; i < array_length(oBackground.b); i++) {
	if(oBackground.b[i].wait > 0) oBackground.b[i].wait--;
	else {
		oBackground.b[i].vsp += 0.3*oBackground.b[i].scale;
		oBackground.b[i].y += oBackground.b[i].vsp;
		draw_circle(oBackground.b[i].x,oBackground.b[i].y,6*oBackground.b[i].scale,false);
		if(oBackground.b[i].y > room_height) {
			oBackground.b[i].y = -12;
			oBackground.b[i].wait = irandom(60*3);
			oBackground.b[i].x = irandom(room_width);
			oBackground.b[i].scale = random_range(0.3,1);
			oBackground.b[i].vsp = 0;
		}
	}
}

if !surface_exists(surface) {
	surface = surface_create(room_width,room_height);
	surface_set_target(surface);
	var _size = 2;
	for(var i = 0; i < array_length(oBackground.backgrid); i++) draw_rectangle(i*_size,room_height,(i+1)*_size-(os_browser == browser_not_a_browser),room_height-oBackground.backgrid[i]*_size,false);

	_size = 4;
	draw_set_color(c_dkgray);
	for(var i = 0; i < array_length(global.frontgrid); i++) draw_sprite_ext(sWallBackground,0,i*_size,room_height,1,global.frontgrid[i],0,merge_color(c_white,c_black,0.9),1);
	surface_reset_target();
}

draw_surface(surface,0,0);
gpu_set_blendmode(bm_subtract);
draw_rectangle_color(0,room_height/3*2,room_width,room_height,c_black,c_black,c_white,c_white,false);
gpu_set_blendmode(bm_normal);