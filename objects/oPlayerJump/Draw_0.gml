/// @desc Draw Circle

draw_set_color(col);
draw_set_alpha(image_alpha);
draw_circle(x,y,scale,false);
draw_set_alpha(1);
image_alpha -= 0.1;
scale += .5;
if(image_alpha <= 0) instance_destroy();
