/*
	Objects in layer 3
	
	Can have sockets that connect to the "clock" object
	Position on the 0-12 second loop triggers it to run at that moment
*/
light_count = 0;
sockets = {
	in1: instance_create_layer(
		x - 4, y - 4,
		"entities",
		o_socket,
		{
			parent: id,
			action: function() {
				parent.light_count = 10;
				parent.sockets.out.action();
			}
		}
	),
	in2: instance_create_layer(
		x - 4, y + 4,
		"entities",
		o_socket,
		{
			parent: id,
			action: function() {
				parent.light_count = 10;
				parent.sockets.out.action();
			}
		}
	),
	out: instance_create_layer(
		x + 20, y + 4,
		"entities",
		o_socket,
		{
			parent: id,
			action: function() {
				if (!is_null(connected_to) && !is_null(connected_to.action)) {
					connected_to.action()
				}
			}
		}
	),
};