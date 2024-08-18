if (sockets.in.wiring || sockets.in.connected_to == undefined) {
	toggle = false;	
}

if (!is_null(sockets.out.connected_to) && toggle) {
	if (!is_null(sockets.out.connected_to.action)) {
		sockets.out.connected_to.action();
	}
}