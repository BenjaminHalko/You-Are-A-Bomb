/// @desc Create Global Variables
randomize();

enum OS {
	OSBROWSER,
	OSOPERA,
	OSMOBILE,
	OSDESKTOP
}

if(os_type == os_operagx) global.ostype = OS.OSOPERA;
else if(os_browser != browser_not_a_browser) global.ostype = OS.OSBROWSER;
else if(os_type == os_android or os_type == os_ios) global.ostype = OS.OSMOBILE;
else global.ostype = OS.OSDESKTOP;

global.googlePlayIsAvailable = GooglePlayServices_IsAvailable();

#macro BROWSER (global.ostype == OS.OSBROWSER)
#macro OPERA (global.ostype == OS.OSOPERA)
#macro DESKTOP (global.ostype == OS.OSDESKTOP)
#macro MOBILE ((global.ostype == OS.OSMOBILE) or (os_type == os_android) or (os_type == os_ios))

#macro CHALLENGEID "50505bbb-2b2f-4027-88fa-11b1d5a6c826"
#macro GOOGLEPLAYLEADERBOARDID "CgkIn8Sfj7sXEAIQAQ"
#macro TILE_SIZE 8

surface_resize(application_surface,room_width,room_height);
if(DESKTOP) {
	window_set_size(room_width*3,room_height*3);
	window_center();
}

create = 2;
minAmount = 4;
amount = 0;

Min = 4;
Max = 8;

timerstart = false;

gameoverNum = 0;
newrecord = false;

title = true;

choice = 0;

tutorial = false;

vol = 1;

global.particle = true;

oBackground.b = []

global.usingGamepad = false;

repeat(5) array_push(oBackground.b,{
	wait: irandom(60*5),
	x: irandom(room_width),
	y: -12,
	vsp: 0,
	scale: random(1)
});

oBackground.backgrid = array_create(room_width div 2,0);
var _amount = irandom_range(80,100);
for(var i = 0; i < array_length(oBackground.backgrid); i++) {
	_amount += irandom_range(-4*(_amount > 80),4*(_amount < 100));
	oBackground.backgrid[i] = _amount;
}

global.frontgrid = array_create(room_width div 4,0);
var _amount = irandom_range(30,40);
for(var i = 0; i < array_length(global.frontgrid); i++) {
	_amount += irandom_range(-4*(_amount > 30),4*(_amount < 40));
	global.frontgrid[i] = _amount;
}

global.score = [0,0];
global.hiscore = 0;

if(OPERA) {
	try gxc_challenge_get_global_scores(function(_status, _result) {
		try if (_status == 200 and array_length(_result.data.scores) > 0) global.hiscore = _result.data.scores[0].score/1000;
		catch(_error) show_debug_message(_error);
	},{challengeId: CHALLENGEID});
	catch(_error) show_debug_message(_error);
} else if(file_exists("score")) {
	var _file = file_text_open_read("score");
	global.hiscore = file_text_read_real(_file);
	file_text_close(_file);
}

if(is_nan(global.hiscore)) global.hiscore = 0;

var lay_id = layer_get_id("Wall");
global.collisionMap = layer_tilemap_get_id(lay_id);	

song = audio_play_sound(mSong,1,true);
audio_sound_gain(song,0.6,0);

curve = animcurve_get_channel(PlayerStartCurve,0);
logo = 0;

p1 = noone;
p2 = noone;

leftScreen = false;
rightScreen = false;
jumpScreen = false;
jumpIsPressed = false;
	
screenButtonY = room_height-40;
leftScreenX = 40;
rightScreenX = leftScreenX+48;
jumpScreenX = room_width-leftScreenX;

if(BROWSER) {
	width = browser_width;
	height = browser_height;
	scale_canvas(480,256,width,height);
}

for(var i = 0; i < room_height; i += TILE_SIZE) {
	tilemap_set_at_pixel(global.collisionMap,2,0,i);	
	tilemap_set_at_pixel(global.collisionMap,2,TILE_SIZE,i);
	tilemap_set_at_pixel(global.collisionMap,2,room_width-TILE_SIZE*2,i);
	tilemap_set_at_pixel(global.collisionMap,2,room_width-TILE_SIZE,i);
}