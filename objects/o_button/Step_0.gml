toggle = (
	place_meeting(x, y, o_subplayer) &&
	abs(point_direction(x, y, o_subplayer.x, o_subplayer.y) - image_angle) < 45
);

if (toggle) action();