function Approach(a, b, amount) {
	if (a < b)
	{
	    a += amount;
	    if (a > b)
	        return b;
	}
	else
	{
	    a -= amount;
	    if (a < b)
	        return b;
	}
	return a;
}

function ApproachFade(Value,Target,MaxSpd,Ease) {
	Value += median(-MaxSpd,MaxSpd,(1-Ease)*(Target-Value));
	return Value;
}

function ApproachCircleEase(Value,Target,MaxSpd,Ease) {
	Value += median(-MaxSpd,MaxSpd,(1-Ease)*angle_difference(Target,Value));
	return Value
}

function Wave(_from, _to, _duration, _offset) {
	a4 = (_to - _from) * 0.5;
	return _from + a4 + sin((((current_time * 0.001) + _duration * _offset) / _duration) * (pi*2)) * a4;
}

function ValuePercent(_x, _a, _b) {
	return (_x - _a) / (_b - _a)
}

function Input() {
	key_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
	key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
	
	key_jump = keyboard_check_pressed(vk_space);
}

function PlayerDraw() {
	var _yExtra = round(bounce);
	var _top = y - (y - bbox_top)*scale;

	draw_sprite_ext(sprite_index,image_index,x+random_range(-3,3)*max(1-timer,0),y-_yExtra+random_range(-3,3)*max(1-timer,0),scale,scale,0,c_white,1);

	#region Draw Fuse
	if(timer > 0) {
	var _time = timer/maxTime;
	var _len;
	var _x = x;
	var _y = _top-3;
	draw_set_color(c_grey);

	if(_time > 1/8) {
		_len = min(2*ValuePercent(_time,1/8,3/8),2);
		draw_line(x,_top-3-_yExtra,x-_len,_top-3-_len-_yExtra);
		_x = x-_len;
		_y = _top-3-_len;
	}
	if(_time > 3/8) {
		_len = min(3*ValuePercent(_time,3/8,6/8),3)
		draw_line(x-2,_top-5-_yExtra,x-2-_len,_top-5-_yExtra);
		_x = floor(x-1-_len);
		_y = _top-5;
	}

	if(_time > 6/8) {
		_len = min(2,2*ValuePercent(_time,6/8,1));
		draw_line(x-5,_top-5-_yExtra,x-5-_len,_top-5+_len-_yExtra);
		_x = x-5-_len;
		_y = _top-5+_len;
	}

	draw_sprite_ext(sPlayerSpark,-1,_x+1,_y+1-_yExtra,random_range(1,1.5),random_range(1,1.5),random(360),c_white,1);
	}
	#endregion

	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(fontPlayer);

	if(timer >= 10) draw_text_transformed(x+1,y-_yExtra,floor(timer),min(1,scale),min(1,scale),0);
	else draw_text_transformed(x+1,y-_yExtra,string_replace(string_format(timer,1,1)," ","0"),min(1,scale),min(1,scale),0);
}

function scale_canvas(_bw,_bh,_cw,_ch) {
/// @function                       scale_canvas(base width, base height, current width, current height, center);
/// @param {int}    base width      The base width for the game room
/// @param {int}    base height     The base height for the game room
/// @param {int}    current width   The current width of the game canvas
/// @param {int}    current height  The current height of the game canvas
/// @param {bool}   center          Set whether to center the game window on the canvas or not

var _aspect = (_bw / _bh);

if ((_cw / _aspect) > _ch)
    {
    window_set_size((_ch *_aspect), _ch);
    }
else
    {
    window_set_size(_cw, (_cw / _aspect));
    }
	window_center();
}
