depth = -y;
if (mouse_check_button_pressed(mb_left)) {
	if (
		!collision_circle(GUI_MOUSE_X, GUI_MOUSE_Y, 2, o_socket, 0, true) &&
		collision_point(GUI_MOUSE_X, GUI_MOUSE_Y, self, 0, false)
	) {
		LAYER2_MOVE = self;
		ox = x;
		oy = y;
	}
}

if (mouse_check_button(mb_left) && LAYER2_MOVE == self) {
	depth = -1000;
	if (mouse_check_button_pressed(mb_right)) {
		image_angle += 90;
	}
	x = GUI_MOUSE_X;
	y = GUI_MOUSE_Y;

	x = (bbox_left < 256) ? x + (256 - bbox_left) : x;
	x = (bbox_right > 512) ? x + (512 - bbox_right) : x;
	y = (bbox_top < 0) ? y + (0 - bbox_top) : y;
	y = (bbox_bottom > room_height) ? y + (room_height - bbox_bottom) : y;
	x = x div 16 * 16;
	y = y div 16 * 16;
}

if (mouse_check_button_released(mb_left) && LAYER2_MOVE == self) {
	if (
		!collision_rectangle(
			bbox_left, bbox_top,
			bbox_right, bbox_bottom,
			o_layer2_parent, 0, true
		) &&
		!collision_rectangle(
			bbox_left, bbox_top,
			bbox_right, bbox_bottom,
			o_clock, 0, true
		)
	) {
		LAYER2_MOVE = undefined;
	} else {
		x = ox;
		y = oy;
	}
}