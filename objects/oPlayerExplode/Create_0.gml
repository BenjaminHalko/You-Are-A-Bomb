/// @desc Initialize Explosion

index = 1;

colors = [
[ #00244C, #001933, #000C19],
[ #333333, #2B2B2B, #191919],
[ #004C35, #003322, #001911],
[ #4C003E, #33002A, #190014],
[ #663700, #4C2600, #331A00]];

p = [];

for(var i = 0; i < 30; i += 1+MOBILE*1.2) for(var j = 0; j < 30; j += 1+MOBILE*1.2) if(point_in_circle(i,j,16,16,16)) array_push(p,{
	x: x+(i-14),
	y: y+(j-14),
	vsp: random_range(0.5,-3),
	hsp: random((i-14)/14),
	col: irandom(2),
	grv: random_range(0.1,0.2)
});

if(!global.particle or global.mobileOperaGX) and !global.usingMultiplayer instance_destroy();