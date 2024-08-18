if (CONTROL.game_state.name == "level") {
	draw_sprite_ext(
		sp_clock,
		0,
		x, y+8,
		1, 1,
		0,
		c_black,
		1
	);
	draw_sprite_ext(
		sp_clock,
		0,
		x, y,
		1, 1,
		0,
		c_white,
		1
	);

	draw_sprite_ext(
		sp_clock_hand,
		0,
		x, y,
		1, 1,
		CONTROL.game_state.level_timer_degrees,
		c_white,
		1
	);
}