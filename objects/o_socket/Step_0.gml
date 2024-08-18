if (!is_null(parent)) {
	x = parent.x + lengthdir_x(plen, pdir + parent.image_angle);
	y = parent.y + lengthdir_y(plen, pdir + parent.image_angle);
}

if (is_null(LAYER3_MOVE)) {
	if (mouse_check_button_pressed(mb_left) && collision_point(GUI_MOUSE_X, GUI_MOUSE_Y, self, 0, false)) {
		if (!is_null(connected_to) && connected_to != o_clock) {
			connected_to.connected_to = undefined;
			connected_to.clock_time = -1;
			connected_to.wiring = true;
		
			connected_to = undefined
			clock_time = -1;
			wiring = false;
		} else {
			wiring = true;
		}
	} else if (mouse_check_button_pressed(mb_right)) {
		if (collision_point(GUI_MOUSE_X, GUI_MOUSE_Y, self, 0, false)) {
			if (!is_null(connected_to)) {
				if (connected_to != o_clock) {
					with (connected_to) {
						connected_to = undefined;
						clock_time = -1;
						wiring = false;
					}
				} else {
					o_clock.connected_to_arr = array_filter(
						o_clock.connected_to_arr,
						method({ socket: self }, function(el) {
							return el != self;
						})
					);
				}
			}
			connected_to = undefined;
			clock_time = -1;
			wiring = false;
		}
	}

	if (wiring && mouse_check_button_released(mb_left)) {
		var other_socket = collision_point(GUI_MOUSE_X, GUI_MOUSE_Y, o_socket, 0, true);
		if (!is_null(other_socket)) {
			connected_to = other_socket;
			other_socket.connected_to = self;
		}
		if (collision_point(GUI_MOUSE_X, GUI_MOUSE_Y, o_clock, 0, true)) {
			connected_to = o_clock;
			clock_time = floor(point_direction(o_clock.x, o_clock.y, GUI_MOUSE_X, GUI_MOUSE_Y));
			array_push(o_clock.connected_to_arr, self);
		}
	
		wiring = false;
	}
}

if (cooldown > 0) { --cooldown; }