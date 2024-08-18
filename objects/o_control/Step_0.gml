switch (game_state.event) {
	case state_event.enter:
		if (game_state.fade_alpha != 0. && !game_state.fade_skip) {
			game_state.fade_alpha = animcurve_channel_evaluate(
				game_state.fade_curve,
				game_state.fade_pos
			);
			game_state.fade_pos += 1. / game_state.fade_speed;
		} else {
			game_state.enter();
		}
		break;
	case state_event.update:
		game_state.update();
		if (!is_null(MENU_MOVE)) MENU_MOVE.ui_click();
		else if (!is_null(MENU_TOP)) MENU_TOP.ui_click();
		break;
	case state_event.leave:
		if (game_state.fade_alpha != 1. && !game_state.fade_skip) {
			game_state.fade_alpha = animcurve_channel_evaluate(
				game_state.fade_curve,
				game_state.fade_pos
			);
			game_state.fade_pos -= 1. / game_state.fade_speed;
		} else {
			var state_name = game_state.leave();
			if (!is_null(state_name)) {
				game_state = game_state_dict[$ state_name];
				game_state.goto_room();
				array_foreach(
					camera_surfaces,
					function(el) {
						surface_free(el);		
					}
				);
			}
		}
		break;
}