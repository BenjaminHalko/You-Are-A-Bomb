/// @desc
randomize();

surface_resize(application_surface,room_width,room_height);
if(!BROWSER) window_set_size(room_width*3,room_height*3);

#macro TILE_SIZE 8
#macro BROWSER 1

create = 2;
minAmount = 4;
amount = 0;

Min = 4;
Max = 8;

timerstart = false;

gameoverNum = 0;
newrecord = false;

title = true;

global.particle = true;

global.b = []

repeat(5) array_push(global.b,{
	wait: irandom(60*5),
	x: irandom(room_width),
	y: -12,
	vsp: 0,
	scale: random(1)
});

global.backgrid = array_create(room_width div 2,0);
var _amount = irandom_range(80,100);
for(var i = 0; i < array_length(global.backgrid); i++) {
	_amount += irandom_range(-4*(_amount > 80),4*(_amount < 100));
	global.backgrid[i] = _amount;
}

global.frontgrid = array_create(room_width div 4,0);
var _amount = irandom_range(30,40);
for(var i = 0; i < array_length(global.frontgrid); i++) {
	_amount += irandom_range(-4*(_amount > 30),4*(_amount < 40));
	global.frontgrid[i] = _amount;
}

global.score = 0;
global.hiscore = 0;
if(file_exists("score")) {
	var _file = file_text_open_read("score");
	global.hiscore = file_text_read_real(_file);
	file_text_close(_file);
}

if(is_nan(global.hiscore)) global.hiscore = 0;

var lay_id = layer_get_id("Wall");
global.collisionMap = layer_tilemap_get_id(lay_id);	

audio_play_sound(mSong,1,true);

curve = animcurve_get_channel(PlayerStartCurve,0);
logo = 0;

if(BROWSER) {
	width = browser_width;
	height = browser_height;
	scale_canvas(480,256,width,height);
}
