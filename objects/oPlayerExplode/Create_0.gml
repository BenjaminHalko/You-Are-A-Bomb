/// @desc

if(!global.particle) {
	instance_destroy();
	exit;
}

p = [];

for(var i = 0; i < 30; i += 1+MOBILE) for(var j = 0; j < 30; j += 1+MOBILE) array_push(p,{
	x: x+(i-14),
	y: y+(j-14),
	xoffset: i div 2,
	yoffset: j div 2,
	vsp: random_range(0.5,-3),
	hsp: random((i-14)/14)
});
