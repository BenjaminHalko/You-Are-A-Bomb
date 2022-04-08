/// @desc

grv = 0.3;

bounce = 0;
bounceSpd = 0;
bounced = false;

vsp = 0;
vsp_f = 0;
vsp_final = 0;

maxTime = max(2.5,3-max(global.score[0],global.score[1])/600+(max(global.score[0],global.score[1]) <= 10));
timer = maxTime;

scale = 1;

active = false;
activeId = noone;

image_index = 1;
