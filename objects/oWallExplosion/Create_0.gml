/// @desc

p = [];

for(var i = 0; i < 2; i++) for(var j = 0; j < 2; j++) array_push(p,{
	x: x+4*i,
	y: y+4*j,
	xoffset: 8+i*4,
	yoffset: j*4,
	vsp: random_range(-4,-5),
	hsp: random(3)*(1-i*2)
});
