
event_inherited();

// All levels
LVL_MAIN = 1;
LVL_EFF = 2;
LVL_FCN = 3;
LVL_THM = 4;
fn_menu_lvl_add(LVL_MAIN);
fn_menu_lvl_add(LVL_EFF);
fn_menu_lvl_add(LVL_FCN);
fn_menu_lvl_add(LVL_THM);
for (var l = 0; l < array_length(lvl); l++)
	fn_menu_lvl_rect_add(l, 0, 0, 0, global.config.video.res_width, global.config.video.res_height, , (l == LVL_MAIN ? 0.5 : 0.75));

// Main level
var l = LVL_MAIN;
lvl[l].option_cancel.key[1] = CONFIG_KEY.MENU_USER;
fn_menu_lvl_fader_start(l, , , , , global.user.thm[global.user.thm_curr].snd.confirm);
for (var o = 0; o < 3; o++)
	fn_menu_lvl_option_add(l, o, textdata($"menu_user_main_option_{o}"));
for (var p = 0; p < 2; p++)
	fn_menu_lvl_panel_add(l, p);
fn_menu_lvl_decor_add(l, 0);
fn_menu_lvl_decor_add(l, 1, (irandom_range(1, 10) != 1 ? (fn_obj_exists(obj_actor_user) == true ? obj_actor_user.dir[obj_actor_user.DIR_DN].spr : spr_user_dir_dn) : spr_actor_macaco_monkey));
for (var a = 0; a < 3; a++)
	fn_menu_lvl_label_add(l, a);
fn_menu_lvl_label_icon_add(l, 1);
