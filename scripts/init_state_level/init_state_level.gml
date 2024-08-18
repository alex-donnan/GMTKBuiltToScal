/*
	Levels
	
	All levels operate the same
	room controlled by button selection in menu
*/

function init_state_level() {
	with(CONTROL.game_state_dict.level) {
		level_number = 0;
		level_timer = 0;
		level_timer_degrees = 90 - ((level_timer / (room_speed * 12)) * 360);
		level_timer_speed = 1.;
		level_timer_speed_lerp = 0.;
		level_active = false;
		
		//Texture loads, other managerial stuff
		enter = function() {
			level_timer = 0;
			level_timer_speed = 1.;
			level_timer_speed_lerp = 0.;
			level_active = false;
			next_event();
		}
	
		//Update as necessary
		update = function() {
			//Reset the room
			if (keyboard_check_pressed(ord("R"))) {
				reset();
				room_restart();
			}
			if (keyboard_check_pressed(ord("1"))) {
				CONTROL.camera_zoom = 0;
			}
			if (keyboard_check_pressed(ord("2"))) {
				CONTROL.camera_zoom = 1;
			}
			if (keyboard_check_pressed(ord("3"))) {
				CONTROL.camera_zoom = 2;
			}
			
			//Stop start time
			if (keyboard_check_pressed(vk_space) && is_null(LAYER3_MOVE)) {
				level_active = !level_active;
			}
			
			//Active? Move time
			level_timer_speed_lerp = (level_active) ?
				lerp(level_timer_speed_lerp, level_timer_speed, 0.05) :
				lerp(level_timer_speed_lerp, 0., 0.25);
			level_timer += level_timer_speed_lerp;
			level_timer = level_timer mod (room_speed * 12);
			level_timer_degrees = 90 - ((level_timer / (room_speed * 12)) * 360);
			level_timer_degrees += (sign(level_timer_degrees) <= 0) ? 360 : 0;
		}
	
		//Reset and end state
		leave = function() {
			reset();
			check_state_undefined();
			return next_state;
		}
	}
}