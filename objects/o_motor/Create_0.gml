/*
	A motor
	2 sockets
	
	while powered, move in the direction that is powered
*/

light_count = 0;
sockets = {
	left: instance_create_layer(
		x - 20, y - 20,
		"entities",
		o_socket,
		{
			parent: id,
			action: function() {
				parent.image_speed = 30 / room_speed;
				parent.light_count = 7;
				o_subplayer.vx = -0.5 * CONTROL.game_state.level_timer_speed_lerp;
			}
		}
	),
	right: instance_create_layer(
		x + 20, y - 20,
		"entities",
		o_socket,
		{
			parent: id,
			action: function() {
				parent.image_speed = 30 / room_speed;
				parent.light_count = 7;
				o_subplayer.vx = 0.5 * CONTROL.game_state.level_timer_speed_lerp;
			}
		}
	),
};