if (CONTROL.game_state.level_active) {
	array_foreach(
		connected_to_arr,
		function(socket) {
			if (
				!is_null(socket) && 
				!is_null(socket.action) &&
				socket.clock_time == floor(CONTROL.game_state.level_timer_degrees) &&
				socket.cooldown == 0
			) {
				socket.action();
				socket.cooldown = 4;
			}
		}
	);
}

if (collision_point(GUI_MOUSE_X, GUI_MOUSE_Y, self, 0, false)) {
	if (mouse_check_button_pressed(mb_left)) {
		var ind = array_find_index(
			connected_to_arr,
			method({ time: floor(point_direction(o_clock.x, o_clock.y, GUI_MOUSE_X, GUI_MOUSE_Y)) }, function(el) {
				return abs(el.clock_time - time) < 4;
			})
		);
		if (ind != -1) {
			with (connected_to_arr[ind]) {
				connected_to = undefined;
				clock_time = -1;
				wiring = true;
			}
			array_delete(connected_to_arr, ind, 1);
		}
	}
	if (mouse_check_button_pressed(mb_right)) {
		var ind = array_find_index(
			connected_to_arr,
			method({ time: floor(point_direction(o_clock.x, o_clock.y, GUI_MOUSE_X, GUI_MOUSE_Y)) }, function(el) {
				return abs(el.clock_time - time) < 4;
			})
		);
		if (ind != -1) {
			with (connected_to_arr[ind]) {
				connected_to = undefined;
				clock_time = -1;
				wiring = false;
			}
			array_delete(connected_to_arr, ind, 1);
		}
	}
}