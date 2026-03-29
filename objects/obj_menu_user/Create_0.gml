
event_inherited();

// All levels
LVL_MAIN = 0;
LVL_EFF = 1;
LVL_FCN = 2;
LVL_THM = 3;
fn_menu_lvl_add(LVL_MAIN);
fn_menu_lvl_add(LVL_EFF);
fn_menu_lvl_add(LVL_FCN);
fn_menu_lvl_add(LVL_THM);
for (var l = 0; l < array_length(lvl); l++)
	fn_menu_lvl_rect_add(l, 0, 0, 0, global.config.video.res_width, global.config.video.res_height, , 0.35);

// Main level
var l = LVL_MAIN;
