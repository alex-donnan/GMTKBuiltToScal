/*
	Game State structs
	
	Basic enter, update, leave functions for use in CONTROL
*/

enum state_event {
	enter,
	update,
	leave
}

function State(
		_name,
		_next_room = undefined,
		_functions = {
			enter: undefined,
			update: undefined,
			leave: undefined
		}
	) constructor {
		
	// Basic state variables
	name = _name;
	event = state_event.enter;
	next_state = undefined;
	next_room = _next_room;
	
	static fade_curve = animcurve_get_channel(ac_state, "fade");
	fade_pos = 0;
	fade_alpha = 1.;
	fade_speed = room_speed;
	fade_skip = false;
	
	// State functions
	enter = _functions.enter;
	update = _functions.update;
	leave = _functions.leave;
	
	// Reset 
	static reset = function() {
		event = state_event.enter;	
	}
	
	// Go to next event
	static next_event = function(_state = undefined) {
		event = (event + 1) mod 3;
		next_state = _state;
	}
	
	// Go to next room
	static goto_room = function() {
		if (!is_null(next_room) && room != next_room) {
			room_goto(next_room);
		}
	}
	
	// Check undefined next state
	static check_state_undefined = function() {
		if (is_null(next_state)) throw($"State {name} : undefined next_state")	
	}
}