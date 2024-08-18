draw_sprite_ext(
	sp_motor,
	image_index,
	x, y+8,
	1, 1,
	image_angle,
	c_black,
	1
);
draw_sprite_ext(
	sp_motor,
	image_index,
	x, y,
	1, 1,
	image_angle,
	c_white,
	1
);

if (light_count == 0) image_speed = 0;