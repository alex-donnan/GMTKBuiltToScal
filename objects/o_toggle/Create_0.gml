/*
	A toggle
	2 sockets
	
	input toggles
	output provides power if on
*/

sockets = {
	in: instance_create_layer(
		x - 4, y - 4,
		"entities",
		o_socket,
		{
			parent: id,
			action: function() {
				parent.toggle = !parent.toggle;
			}
		}
	),
	out: instance_create_layer(
		x - 4, y + 4,
		"entities",
		o_socket,
		{
			parent: id,
			action: undefined
		}
	)
};