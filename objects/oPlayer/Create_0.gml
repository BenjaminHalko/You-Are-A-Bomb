/// @desc Initialize Player Variables

if variable_instance_exists(id,"player_id") {
	y = room_height/4;
	if player_id == 0 {
		oGameManager.p1 = id;
	} else if player_id == 1 {
		oGameManager.p2 = id;
	} else if player_id == 2 {
		oGameManager.p3 = id;
	} else {
		oGameManager.p4 = id;
	}
}

startingTime = 10;
maxTime = startingTime;
timer = maxTime;
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

player = 0;

jumpTimer = 0;

defeated = false;