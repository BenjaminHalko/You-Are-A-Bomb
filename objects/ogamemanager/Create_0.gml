/// @desc Setup Game

global.usingMultiplayer = false;

gameoverNum = 0;
newrecord = false;

timerstart = false;

p1 = noone;
p2 = noone;
p3 = noone;
p4 = noone;
total = 0;
playerScores = [0,0,0,0];
playersLeft = 0;
startTime = 0;
totalSubtract = 0;

create = 2;
minAmount = 4;
amount = 0;

Min = 4;
Max = 8;

destroyList = [];

tutorial = false;

playerNames = ["PLAYER 1","PLAYER 2","PLAYER 3","PLAYER 4"];

var lay_id = layer_get_id("Wall");
collisionMap = layer_tilemap_get_id(lay_id);