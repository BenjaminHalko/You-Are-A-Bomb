if os_type == os_android {
	var _height = min(display_get_height(),display_get_width());
	var _width = max(display_get_height(),display_get_width());
	room_set_height(rGame,480 * _height / _width);
}

room_goto_next();