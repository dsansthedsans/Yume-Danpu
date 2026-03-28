
// Video/Graphics
if (global.config.vid.fscr.act == true) // Draws black rectangles to cover drawings that go off-screen
{
	var _resW = global.config.vid.resW;
	var _resH = global.config.vid.resH;
	var _fscrRect_color = c_black;
	fn_draw_rect(0, -_resH, -(_resW * 2), (_resH * 3), _fscrRect_color, _fscrRect_color, _fscrRect_color, _fscrRect_color, 1);
	fn_draw_rect(_resW, -_resH, (_resW * 2), (_resH * 3), _fscrRect_color, _fscrRect_color, _fscrRect_color, _fscrRect_color, 1);
}
if (global.config.vid.showVer.act == true) // Draws Version
{
	var _showVer_spr = spr_config_vid_showVer;
	var _showVer_width = fn_spr_width(_showVer_spr);
	var _showVer_height = fn_spr_height(_showVer_spr);
	var _showVer_x = (global.config.vid.resW - 4 - _showVer_width);
	var _showVer_y = (global.config.vid.resH - 4 - _showVer_height);
	var _showVer_color = [global.user.thm[global.user.thm_curr].color.grayLight, global.user.thm[global.user.thm_curr].color.whiteLight];
	var _showVer_alpha = 0.5;
	for (var v = 0; v < 2; v++)
		fn_draw_spr(_showVer_spr, v, _showVer_x, _showVer_y, _showVer_color[v], _showVer_alpha);
}
if (global.config.vid.showFps.act == true) // Draws FPS
{
	var _showFps_text = $"{fps} FPS";
	var _showFps_width = fn_text_width(_showFps_text);
	var _showFps_x = (320 - 4 - _showFps_width);
	var _showFps_y = 2;
	var _showFps_color = [global.user.thm[global.user.thm_curr].color.whiteLight, global.user.thm[global.user.thm_curr].color.whiteDark];
	var _showFps_alpha = 0.5;
	fn_draw_text(_showFps_text, _showFps_x, _showFps_y, _showFps_color[0], _showFps_color[1], _showFps_alpha);
}
if (global.config.vid.showBdr.act == true) // Draws Border
{
	var _showBdr_spr = spr_config_vid_showBdr;
	var _showBdr_scale = 0.5;
	fn_draw_spr(_showBdr_spr, 0, 0, 0, , , _showBdr_scale, _showBdr_scale);
}




// oi bom noite !!!!!!
