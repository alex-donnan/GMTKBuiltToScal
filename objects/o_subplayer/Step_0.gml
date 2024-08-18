vy += (!collision_line(
	x, y,
	x + vx, y + vy,
	o_wall, 0, true
));

xscale = (vx != 0) ? sign(vx) : xscale;

while (place_meeting(x + vx, y, o_wall)) {
	vx -= xscale;
}
while (place_meeting(x, y + vy, o_wall)) {
	vy -= sign(vy);
}

image_speed = (vx != 0) ? 30 / room_speed : 0;

x += vx;
y += vy;