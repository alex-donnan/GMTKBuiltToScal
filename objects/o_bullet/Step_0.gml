x += vx;
y += vy;

if (place_meeting(x, y, o_button)) {
	var inst = instance_place(x, y, o_button);
	inst.action();
	instance_destroy(self);
}

if (place_meeting(x, y, o_wall)) {
	instance_destroy(self);	
}
