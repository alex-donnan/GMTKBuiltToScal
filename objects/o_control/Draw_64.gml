draw_surface_stretched(
	camera_surfaces[camera_zoom],
	0, 0,
	256, 256
);

//TODO zoom into and out of Oiram and Robot

draw_set_alpha(CONTROL.game_state.fade_alpha);
draw_rectangle_color(0, 0, room_width, 256, c_black, c_black, c_black, c_black, false);
draw_set_alpha(1.);