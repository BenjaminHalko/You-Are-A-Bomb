/// @desc Initialize Enemy

grv = 0.3;

bounce = 0;
bounceSpd = 0;
bounced = false;

vsp = 0;
vsp_f = 0;
vsp_final = 0;

if global.usingMultiplayer {
	maxTime = max(2.5,3-oGameManager.total/600+(oGameManager.total <= 10)*.5);
	if oGameManager.playersLeft == 1 maxTime = min(maxTime,2.5);
} else
	maxTime = max(2.5,3-oGameManager.total/1200+(oGameManager.total <= 10));
timer = maxTime;

scale = 1;

active = false;
activeId = noone;

image_index = 1;
