
// Graphics
var _res_width = global.config.video.resolution[0].width;
var _res_height = global.config.video.resolution[0].height;
if (global.config.video.fullscreen.act == true) // Draws black rectangles to cover drawings that go off-screen
{
	var _fullscreenRect_cols = [c_black, c_black, c_black, c_black];
	fn_draw_rect(0, -_res_height, -(_res_width * 2), (_res_height * 3), _fullscreenRect_cols, 1);
	fn_draw_rect(_res_width, -_res_height, (_res_width * 2), (_res_height * 3), _fullscreenRect_cols, 1);
}
if (global.config.video.showVer.act == true) // Draws Version
{
	var _showVer_spr = spr_config_video_showVer;
	var _showVer_width = fn_spr_width(_showVer_spr);
	var _showVer_height = fn_spr_height(_showVer_spr);
	var _showVer_x = (_res_width - 4 - _showVer_width);
	var _showVer_y = (_res_height - 4 - _showVer_height);
	var _showVer_color = [global.user.theme[global.user.theme_curr].color.grayLight, global.user.theme[global.user.theme_curr].color.whiteLight];
	var _showVer_alpha = 0.5;
	for (var v = 0; v < 2; v++)
		fn_draw_spr(_showVer_spr, v, _showVer_x, _showVer_y, _showVer_color[v], _showVer_alpha);
}
if (global.config.video.showFps.act == true) // Draws FPS
{
	var _showFps_txt = $"{fps} FPS";
	var _showFps_cols = [global.user.theme[global.user.theme_curr].color.whiteLight, global.user.theme[global.user.theme_curr].color.whiteDark];
	fn_draw_text(_showFps_txt, (320 - 4 - fn_text_width(_showFps_txt)), 2, _showFps_cols, 0.5);
}
if (global.config.video.showBdr.act == true) // Draws Border
{
	var _showBdr_spr = spr_config_video_showBdr;
	var _showBdr_scale = 0.5;
	fn_draw_spr(_showBdr_spr, 0, 0, 0, , , _showBdr_scale, _showBdr_scale);
}




// oi bom noite !!!!!!
