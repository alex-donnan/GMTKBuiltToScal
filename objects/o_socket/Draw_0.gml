if (wiring || !is_null(connected_to)) {
	depth = -1000;
	draw_sprite(sp_plug, 0, x, y);
	if (!is_null(connected_to)) {
		var clock = (connected_to.object_index == o_clock);
		var pos_x = (clock) ?
			connected_to.x + lengthdir_x(28, clock_time) :
			connected_to.x;
		var pos_y = (clock) ?
			connected_to.y + lengthdir_y(28, clock_time) :
			connected_to.y;
		var pos_rot = (clock) ? clock_time - 90 : 0;
		
		draw_line_width_color(x, y - 3,  pos_x, pos_y, 2, c_black, c_black);
		draw_sprite_ext(
			sp_plug, 0,
			pos_x, pos_y,
			1, 1,
			pos_rot,
			c_white,
			1
		);
	} else {
		var pos_x = GUI_MOUSE_X;
		var pos_y = GUI_MOUSE_Y;
		if (point_distance(GUI_MOUSE_X, GUI_MOUSE_Y, o_clock.x, o_clock.y) < 28) {
			var pos_dir = point_direction(o_clock.x, o_clock.y, GUI_MOUSE_X, GUI_MOUSE_Y);
			pos_x = o_clock.x + lengthdir_x(28, pos_dir);
			pos_y = o_clock.y + lengthdir_y(28, pos_dir);
		}
		draw_line_width_color(x, y - 3, pos_x, pos_y, 2, c_black, c_black);
		draw_sprite_ext(
			sp_plug, 1,
			pos_x, pos_y,
			1, 1,
			point_direction(x, y, pos_x, pos_y) + 90,
			c_white,
			1
		);
	}
}

// TODO : draw line should be separated out and second plug drawn by connected to
// excluding clock - line will be drawn by control perhaps?