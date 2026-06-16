
event_inherited();

// All levels
LVL_MAIN = 1;
LVL_USER_EFFECT = 2;
LVL_USER_FUNC = 3;
LVL_USER_THEME = 4;
fn_menu_lvl_add(LVL_MAIN);
fn_menu_lvl_add(LVL_USER_EFFECT);
fn_menu_lvl_add(LVL_USER_FUNC);
fn_menu_lvl_add(LVL_USER_THEME);
for (var l = 0; l < array_length(lvl); l++)
	fn_menu_lvl_rect_add(l, 0, 0, 0, global.config.video.resolution[0].width, global.config.video.resolution[0].height);

// Main level
var l = LVL_MAIN;
lvl[l].option_cancel.key[1] = CONFIG_KEY.MENU_USER;
fn_menu_lvl_fader_start(l, , , , , global.user.theme[global.user.theme_curr].audio.confirm);
for (var o = 0; o < 3; o++)
{
	fn_menu_lvl_option_add(l, o);
	fn_menu_lvl_option_icon_add(l, o);
}
for (var p = 0; p < 2; p++)
	fn_menu_lvl_panel_add(l, p);
fn_menu_lvl_decor_add(l, 0);
fn_menu_lvl_decor_add(l, 1, (irandom_range(1, 100) > 5 ? (fn_object_exists(obj_actor_user) == true ? obj_actor_user.dir[obj_actor_user.DIR_DN].spr : spr_user_dir_dn) : spr_actor_macaco_monkey));
for (var a = 0; a < 3; a++)
	fn_menu_lvl_label_add(l, a);
fn_menu_lvl_label_icon_add(l, 1);

// User levels
for (var l = LVL_USER_EFFECT; l <= LVL_USER_THEME; l++)
{
	lvl[l].data[0] = (l == LVL_USER_EFFECT ? global.user.effect : (l == LVL_USER_FUNC ? global.user.func : global.user.theme));
	fn_menu_lvl_panel_add(l, 0);
	fn_menu_lvl_panel_title_add(l, 0);
	for (var o = 0; o < 10; o++)
		fn_menu_lvl_option_add(l, o);
	fn_menu_lvl_label_add(l, 0);
	lvl[l].option_move.list.active = false;
	lvl[l].option_move.table.active = true;
}
