/*
	Jumper
	
	on trigger provides a powerful jump one time.
	has to be reset
*/

light_count = 0;
sockets = {
	right: instance_create_layer(
		x + 20, y - 20,
		"entities",
		o_socket,
		{
			parent: id,
			action: function() {
				parent.image_index = 1;
				parent.light_count = 7;
				if (!parent.toggle && place_meeting(o_subplayer.x, o_subplayer.y + 2, o_wall)) {
					o_subplayer.vy = -12;
					parent.toggle = true
				}
			}
		}
	),
}