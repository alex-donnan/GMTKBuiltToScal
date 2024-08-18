#macro CONTROL o_control
#macro DEBUG true

global.layer2_move = undefined;
global.layer3_move = undefined;
#macro LAYER2_MOVE global.layer2_move
#macro LAYER3_MOVE global.layer3_move

// Build the high level state machine //
game_state_dict = {
	startup: new State("startup"),
	menu_main: new State("menu_main", rm_main),
	level: new State("level", rm_level_1)
};
game_state = game_state_dict.startup;

init_state_startup();
init_state_menu_main();
init_state_level();

camera_surfaces = [
	surface_create(256, 256),
	surface_create(256, 256),
	surface_create(256, 256)
];
camera_zoom = 2;
#macro GUI_MOUSE_X (mouse_x/3) + (CONTROL.camera_zoom * 256)
#macro GUI_MOUSE_Y mouse_y