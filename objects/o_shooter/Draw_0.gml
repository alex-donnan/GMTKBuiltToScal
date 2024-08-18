draw_sprite_ext(
	sp_shooter,
	light_count div 3,
	x, y+8,
	1, 1,
	image_angle,
	c_black,
	1
);
draw_sprite_ext(
	sp_shooter_shots,
	shots,
	x, y,
	1, 1,
	image_angle,
	c_white,
	1
);
draw_sprite_ext(
	sp_shooter,
	light_count div 3,
	x, y,
	1, 1,
	image_angle,
	c_white,
	1
);