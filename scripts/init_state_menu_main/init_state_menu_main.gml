/*
	Main menu
	Start the game or choose a level
*/

function init_state_menu_main() {
	with(CONTROL.game_state_dict.menu_main) {
		//Texture loads, other managerial stuff
		enter = function() {
			next_event();
		}
	
		//Update as necessary
		update = function() {
			// ACTIVATE //
			next_event("level");
		}
	
		//Reset and end state
		leave = function() {
			reset();
			check_state_undefined();
			return next_state;
		}
	}
}