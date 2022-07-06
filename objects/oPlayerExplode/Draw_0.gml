/// @desc Draw Explosion

draw_set_alpha(0.8);
for(var i = 0; i < array_length(p); i++) {
	draw_point_color(p[i].x,p[i].y,colors[index][p[i].col]);
}
draw_set_alpha(1);
