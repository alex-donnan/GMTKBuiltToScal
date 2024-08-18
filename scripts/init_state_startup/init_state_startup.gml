/*
	Startup state
	Loading takes place here
*/

function init_state_startup() {
	with(CONTROL.game_state_dict.startup) {
		fade_skip = true;
		
		//Texture loads, other managerial stuff
		enter = function() {
			next_event();
		}
	
		//Update as necessary
		update = function() {
			// ACTIVATE //
			next_event("menu_main");
		}
	
		//Reset and end state
		leave = function() {
			reset();
			check_state_undefined();
			return next_state;
		}
	}
}