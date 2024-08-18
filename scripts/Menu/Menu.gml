/*
	Menus and UI elements
	
	Base element of UI
	Position, anchor, and children
	Calculates own width height of internal elements if not specified
	
	Active elements need callbacks for various actions:
		onHover
		onPress
		onRelease
		
	My need to get GMLive set up for this
*/
global.menu_dict = {};
global.menu_active = [];
global.menu_objects = [];
global.menu_trigger = [];
global.menu_selected = undefined;
#macro MENUS global.menu_dict
#macro MENU_ACTIVE global.menu_active
#macro MENU_OBJECTS global.menu_objects
#macro MENU_TOP array_last(MENU_ACTIVE)
#macro MENU_TRIGGERS global.menu_trigger
#macro MENU_MOVE global.menu_selected

function push_menu(_menu_arr, _menu_name) {
	array_push(_menu_arr, MENUS[$ _menu_name]);
	array_sort(_menu_arr, function(el1, el2) { return el2.ui_depth - el1.ui_depth });
	MENUS[$ _menu_name].ui_active = true;
}

function pop_menu(_menu_arr) {
	var menu = array_pop(_menu_arr);
	menu.ui_active = false;
}

#macro WIN_WIDTH window_get_width()
#macro WIN_HEIGHT window_get_height()

enum ui_anchors {
	top_left,
	top_center,
	top_right,
	mid_left,
	mid_center,
	mid_right,
	bot_left,
	bot_center,
	bot_right
}

enum menu_anims {
	instant,
	fade,
	slide,
	bounce
}

function UI(
	_params = {
		_x: 0,
		_y: 0,
		_padding: 0,
		_width: 0,
		_height: 0,
		_max_width: 0,
		_max_height: 0,
		_fill_width: 1.0,
		_fill_height: 1.0,
		_anchor: ui_anchors.mid_center,
		_pos_lock: true,
		_sprite: undefined
	},
	_children = []
) constructor {
	// Position //
	x = (is_null(_params[$ "_x"])) ? 0 : _params._x;
	y = (is_null(_params[$ "_y"])) ? 0 : _params._y;
	
	// Draw //
	ui_padding = (is_null(_params[$ "_padding"])) ? 0 : _params._padding;
	ui_width = (is_null(_params[$ "_width"])) ? 0 : _params._width;
	ui_height = (is_null(_params[$ "_height"])) ? 0 : _params._height;
	ui_max_width = (is_null(_params[$ "_max_width"])) ? WIN_WIDTH : _params._max_width;
	ui_max_height = (is_null(_params[$ "_max_height"])) ? WIN_HEIGHT : _params._max_height;
	ui_fill_width = _params[$ "_fill_width"];
	ui_fill_height = _params[$ "_fill_height"];
	ui_anchor = (is_null(_params[$ "_anchor"])) ? ui_anchors.mid_center : _params._anchor;
	ui_pos_lock = (is_null(_params[$ "_pos_lock"])) ? true : _params._pos_lock;
	ui_sprite = (is_null(_params[$ "_sprite"])) ? undefined : _params._sprite;
	ui_sub_index = 0;
	ui_depth = 0;
	
	// Children //
	ui_parent = undefined;
	ui_children = _children;
	
	// Functions //
	static ui_init = function() {
		ui_max_width = (ui_width > 0) ? ui_width : ui_max_width;
		ui_max_height = (ui_height > 0) ? ui_height : ui_max_height;
		
		var closure = {
			type: instanceof(self),
			width: ui_width,
			height: ui_height,
			max_width: ui_max_width,
			max_height: ui_max_height,
			fill_width: (is_null(ui_fill_width)) ? 1.0 : ui_fill_width,
			fill_height: (is_null(ui_fill_height)) ? 1.0 : ui_fill_height,
			padding: ui_padding,
			children: array_length(ui_children),
			depth: ui_depth
		}
		
		array_foreach(
			ui_children,
			method(closure, function(el) {
				el.ui_depth = depth - 1;
				el.ui_max_width = (max_width * fill_width) - (padding * 2);
				el.ui_max_height = (max_height * fill_height) - (padding * 2);
				
				el.ui_init();
				
				if (type == "UIColumn" || type == "UIMenu") width = max(width, el.ui_width);
				else width += el.ui_width;
				
				if (type == "UIRow") height = max(height, el.ui_height);
				else height += el.ui_height;
			})
		);
		
		if (ui_width == 0)  ui_width = min(closure.max_width, closure.width + (ui_padding * 2));
		if (ui_height == 0) ui_height = min(closure.max_height, closure.height + (ui_padding * 2));
		
		if (!is_null(ui_fill_width) && ui_max_width != WIN_WIDTH)  ui_width = closure.max_width * ui_fill_width;
		if (!is_null(ui_fill_height) && ui_max_height != WIN_HEIGHT) ui_height = closure.max_height * ui_fill_height;
	}
	
	static ui_update = function() {
		if (instanceof(self) == "UIMenu" && x == 0 && y == 0) {
			switch (ui_anchor) {
				case ui_anchors.top_left:
					x = 0;
					y = 0;
					break;
				case ui_anchors.mid_left:
					x = 0;
					y = (window_get_height() / 2) - (ui_height / 2);
					break;
				case ui_anchors.bot_left:
					x = 0;
					y = window_get_height() - ui_height;
					break;
				case ui_anchors.top_center:
					x = (window_get_width() / 2) - (ui_width / 2);
					y = 0;
					break;
				case ui_anchors.mid_center:
					x = (window_get_width() / 2) - (ui_width / 2);
					y = (window_get_height() / 2) - (ui_height / 2);
					break;
				case ui_anchors.bot_center:
					x = (window_get_width() / 2) - (ui_width / 2);
					y = window_get_height() - ui_height;
					break;
				case ui_anchors.top_right:
					x = window_get_width() - ui_width;
					y = 0;
					break;
				case ui_anchors.mid_right:
					x = window_get_width() - ui_width;
					y = (window_get_height() / 2) - (ui_height / 2);
					break;
				case ui_anchors.bot_right:
					x = window_get_width() - ui_width;
					y = window_get_height() - ui_height;
					break;
			}
		}
		
		var closure = {
			type: instanceof(self),
			x_shift: x + ui_padding,
			y_shift: y + ui_padding,
			depth: ui_depth,
			padding: ui_padding
		}
		
		array_foreach(
			ui_children,
			method(closure, function(el) {
				el.x = x_shift;
				el.y = y_shift;
				el.ui_depth = depth - 1;
				
				if (type == "UIRow") {
					if (instanceof(el) == "UIRow") throw("ERR: A row should not contain rows.");
					x_shift += el.ui_width + padding;
				}
				
				if (type == "UIColumn" || type == "UIMenu") {
					if (instanceof(el) == "UIColumn") throw("ERR: A column should not contain columns.");
					y_shift += el.ui_height + padding;
				}
				
				el.ui_update();
			})
		);
	}
	
	static ui_draw = function() {
		if (!is_null(ui_sprite)) {
			depth = ui_depth;
			if (sprite_get_nineslice(ui_sprite)) {
				draw_sprite_stretched_ext(
					ui_sprite,
					ui_sub_index,
					x, y,
					ui_width, ui_height,
					c_white,
					1
				);
			}
		}
		
		if (DEBUG) {
			if (ui_hover()) {
				draw_rectangle_color(
					x, y,
					x + ui_width, y + ui_height,
					c_green, c_green, c_green, c_green,
					true
				);
			}
		}
		
		array_foreach(
			ui_children,
			function(el) {
				el.ui_draw();
			}
		);
	}
	
	static ui_hover = function() {
		var hover = point_in_rectangle(
			device_GUI_MOUSE_X(0),
			device_GUI_MOUSE_Y(0),
			x, y,
			x + ui_width,
			y + ui_height
		);
		
		if (hover) {
			array_foreach(
				ui_children,
				function(el) {
					el.ui_hover();
				}
			);
		}
		
		return hover;
	}
	
	static ui_press = function() {
		return ui_hover() && device_mouse_check_button(0, mb_left);	
	}
	
	static ui_release = function() {
		return ui_hover() && device_mouse_check_button_released(0, mb_left);
	}
	
	static ui_click = function(_instance = UI) {
		if (ui_press() || ui_release()) {			
			array_foreach(
				ui_children,
				method({ instance: _instance }, function(el) {
					el.ui_click(instance);
				})
			);
		}
	}
	
	static ui_add_child = function(_child) {
		if (is_instanceof(_child, UI)) {
			array_push(ui_children, _child);
			_child.ui_parent = self;
		}
		return self;
	}
	
	static ui_remove_child = function(_child) {
		ui_children = array_filter(
			ui_children,
			method({ child: _child }, function(el) {
				return el != child;	
			})
		);
	}
}

// MENU //
function UIMenu(
	_anim = menu_anims.instant,
	_params = {},
	_children = []
) : UI (
	_params,
	_children
) constructor {
	ui_active = false;
	ui_menu_animation = _anim;
	ui_depth = array_length(struct_get_names(MENUS)) * -50;
}

#region structural ui
// ROW //
function UIRow(
	_min_width = 0,
	_params = {},
	_children = []
) : UI (
	_params,
	_children
) constructor {
	ui_min_width = _min_width;
	ui_fill_width = (is_null(_params[$ "_fill_width"])) ? 1.0 : _params._fill_width;
}

function UIColumn(
	_min_height = 0,
	_params = {},
	_children = []
) : UI (
	_params,
	_children
) constructor {
	ui_min_height = _min_height;
	ui_fill_height = (is_null(_params[$ "_fill_height"])) ? 1.0 : _params._fill_height;
}

#endregion

#region Functional elements

function UIMove(
	_params = {},
	_children = []
) : UI (
	_params,
	_children
) constructor {
	// FUNCTIONS //
	static ui_click = function(_instance = UI) {
		if (ui_press() && is_null(MENU_MOVE)) {
			MENU_MOVE = self;
		}
		
		if (MENU_MOVE == self) {
			ui_depth = -10000;
			x = lerp(x, device_GUI_MOUSE_X(0) - (ui_width / 2), 0.9);
			y = lerp(y, device_GUI_MOUSE_Y(0) - (ui_height / 2), 0.9);
			ui_update();
			
			if (ui_release()) {
				var pre_parent = MENU_MOVE.ui_parent;
				array_foreach(
					array_concat(MENU_OBJECTS, [MENU_TOP]),
					function(el) {
						el.ui_click(UIMoveSocket);
					}
				);
				if (pre_parent != MENU_MOVE.ui_parent) pre_parent.ui_remove_child(MENU_MOVE);
				MENU_MOVE = undefined;
				ui_parent.ui_update();
			}
		}
	}
}

function UIMoveSocket(
	_callback = undefined,
	_params = {},
	_children = []
) : UI (
	_params,
	_children
) constructor {
	// Functions //
	static ui_click = function(_instance = UI) {
		if (is_instanceof(self, _instance)) {
			if (ui_release() && !is_null(MENU_MOVE)) {
				if (array_length(ui_children) == 1) {
					var swap_child = ui_children[0];
					ui_remove_child(swap_child);
					MENU_MOVE.ui_parent.ui_add_child(swap_child);
					MENU_MOVE.ui_parent.ui_update();
				}
				if (array_length(ui_children) == 0) {
					ui_add_child(MENU_MOVE);
				}
			}
		
			if (ui_press() && array_length(ui_children) == 1) {
				ui_children[0].ui_click();
			}
		}
	}
}

function UIButton(
	_value,
	_payload = undefined,
	_callback = undefined,
	_params = {},
	_children = []
) : UI (
	_params,
	_children
) constructor {
	ui_value = _value;
	ui_payload = _payload;
	ui_callback = _callback;
	
	// FUNCTIONS //
	static ui_draw = function() {
		if (!is_null(ui_sprite)) {
			depth = ui_depth;
			if (sprite_get_nineslice(ui_sprite)) {
				draw_sprite_stretched_ext(
					ui_sprite,
					ui_press(),
					x, y,
					ui_width, ui_height,
					c_white,
					1
				);
			}
		}
		
		if (DEBUG) {
			if (ui_hover()) {
				draw_rectangle_color(
					x, y,
					x + ui_width, y + ui_height,
					c_green, c_green, c_green, c_green,
					true
				);
			}
		}
		
		array_foreach(
			ui_children,
			function(el) {
				el.ui_draw();
			}
		);
	}
	
	static ui_click = function(_instance = UI) {
		if (is_instanceof(self, _instance)) {
			if (ui_release()) {
				array_push(MENU_TRIGGERS, ui_value);
				if (!is_null(ui_callback)) ui_callback();
			
				array_foreach(
					ui_children,
					function(el) {
						el.ui_click();
					}
				);
			}
		}
	}
}

function UILabel(
	_text = "",
	_decorator = undefined,
	_params = {},
	_children = []
) : UI (
	_params,
	_children
) constructor {
	ui_text = _text;
	// TODO : Implement text decoration (color, wave, etc.)
	ui_text_decorator = _decorator;
	
	// FUNCTIONS //
	static ui_init = function() {
		if (ui_width == 0) ui_width = min(
			ui_max_width,
			string_width(ui_text) + (ui_padding * 2)
		);
		if (ui_height == 0) ui_height = min(
			ui_max_height,
			string_height_ext(ui_text, -1, ui_width - (ui_padding * 2)) + (ui_padding * 2)
		);
		
		if (!is_null(ui_fill_width))  ui_width = ui_max_width * ui_fill_width;
		if (!is_null(ui_fill_height)) ui_height = ui_max_height * ui_fill_height;
	}
	
	static ui_draw = function() {
		draw_set_font(f_base);
		draw_set_color(c_black);
		if (ui_text != "") {
			draw_text_ext(
				x + ui_padding, y + ui_padding,
				ui_text,
				-1,
				ui_width - (ui_padding * 2)
			);
		}
	}
}

function UISprite(
	_params = {},
	_children = []
) : UI (
	_params,
	_children
) constructor {
	// FUNCTIONS //
	static ui_init = function() {
		if (is_null(ui_sprite)) throw("ERR: Sprite should not be undefined");
		
		if (ui_width == 0) ui_width = min(
			ui_max_width,
			sprite_get_width(ui_sprite) + (ui_padding * 2)
		);
		if (ui_height == 0) ui_height = min(
			ui_max_height,
			sprite_get_height(ui_sprite) + (ui_padding * 2)
		);
		
		if (!is_null(ui_fill_width))  ui_width = ui_max_width * ui_fill_width;
		if (!is_null(ui_fill_height)) ui_height = ui_max_height * ui_fill_height;
	}
	
	static ui_draw = function() {
		draw_sprite_ext(
			ui_sprite,
			0,
			x, y,
			1, 1,
			0,
			c_white,
			1
		);
	}
}

#endregion