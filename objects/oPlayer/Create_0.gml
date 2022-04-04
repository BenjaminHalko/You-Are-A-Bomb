/// @desc

startingTime = 10;
maxTime = startingTime;
timer = maxTime;
timeStart = false;
starting = 0;

hsp = 0;
vsp = 0;
hsp_f = 0;
vsp_f = 0;
hsp_final = 0;
vsp_final = 0;

canJump = 0;
doubleJump = 0;

bounce = 0
bounceSpd = 0;

scale = 0;

grv = 0.6;
walkspd = 0.5;
maxwalk = 2;
jumpspd = -7;
startCurve = animcurve_get_channel(PlayerStartCurve,0);

scale = 0;

x = room_width/2;
