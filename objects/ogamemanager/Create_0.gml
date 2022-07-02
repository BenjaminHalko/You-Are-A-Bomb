/// @desc Setup Game

global.usingMultiplayer = false;

rollback_define_player(oPlayer);

rollback_define_input({
	left: [vk_left,ord("A")],
	right: [vk_right,ord("D")],
	jump: [vk_space,vk_shift,vk_control,vk_up,ord("W")]
});

gameoverNum = 0;
newrecord = false;

timerstart = false;

p1 = noone;
p2 = noone;
p3 = noone;
p4 = noone;
playersLeft = 0;

create = 2;
minAmount = 4;
amount = 0;

Min = 4;
Max = 8;

destroyList = [];

tutorial = false;

playerNames = ["PLAYER 1","PLAYER 2","PLAYER 3","PLAYER 4"];