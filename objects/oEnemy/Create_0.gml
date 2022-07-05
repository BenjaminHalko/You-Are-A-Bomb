/// @desc Initialize Enemy

grv = 0.3;

bounce = 0;
bounceSpd = 0;
bounced = false;

vsp = 0;
vsp_f = 0;
vsp_final = 0;

if global.usingMultiplayer {
	maxTime = max(2.5,3-max(global.score[0],global.score[1],global.score[2],global.score[3])/600+(max(global.score[0],global.score[1],global.score[2],global.score[3]) <= 10)*.5);
	if oGameManager.playersLeft == 1 maxTime = min(maxTime,2.5);
} else
	maxTime = max(2.5,3-max(global.score[0],global.score[1],global.score[2],global.score[3])/1200+(max(global.score[0],global.score[1],global.score[2],global.score[3]) <= 10));
timer = maxTime;

scale = 1;

active = false;
activeId = noone;

image_index = 1;
