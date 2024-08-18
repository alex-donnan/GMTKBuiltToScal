draw_sprite_ext(
	sp_jumper,
	(light_count == 0) ? 0 : 1,
	x, y+8,
	1, 1,
	image_angle,
	c_black,
	1
);
draw_sprite_ext(
	sp_jumper,
	(light_count == 0) ? 0 : 1,
	x, y,
	1, 1,
	image_angle,
	c_white,
	1
);