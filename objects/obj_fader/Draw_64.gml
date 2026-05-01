
// Transition of type Fade
if (type.fade.active == true)
	// Draws fade
	fn_draw_rect(0, 0, global.config.video.resolution[0].width, global.config.video.resolution[0].height, type.fade.colors, type.fade.alpha);
