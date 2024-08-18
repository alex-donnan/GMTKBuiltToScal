/*
	Shooter
	
	on trigger fires a projectile one time.
	MUST be on the edges of the screen - firing from that edge prioritizing horizontal
*/

light_count = 0;
shots = 3;
sockets = {
	right: instance_create_layer(
		x + 20, y - 20,
		"entities",
		o_socket,
		{
			parent: id,
			action: function() {
				if (!parent.toggle && parent.shots > 0) {
					parent.image_index = 1;
					parent.light_count = 7;
					--parent.shots;
					
					var room_dir = (point_direction(room_width - 128, 128, x, y) + 45) div 90;
					var _vx = 0;
					var _vy = 0;
					switch(room_dir) {
						case 0:
							_vx = 4;
							break;
						case 1:
							_vy = -4;
							break;
						case 2:
							_vx = -4;
							break;
						case 3:
							_vy = 4;
							break;
					}
					
					instance_create_depth(
						o_subplayer.x, o_subplayer.y - 16,
						1 - o_subplayer.y,
						o_bullet,
						{
							vx: _vx,
							vy: _vy
						}
					);
					parent.toggle = true
				}
			}
		}
	),
}