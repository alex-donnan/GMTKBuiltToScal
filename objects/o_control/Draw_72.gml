for (var i = 0; i < 3; i++) {
	if (!surface_exists(camera_surfaces[i])) {
		camera_surfaces[i] = surface_create(256, 256);
		view_surface_id[i] = camera_surfaces[i];
	}
}
