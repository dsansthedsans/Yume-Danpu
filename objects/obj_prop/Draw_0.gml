
// Myself
if (myself.shake.act == true && myself.shake.durCurr > 0 && global.config.access.rdcdMot.act == false)
{
	myself.xOfs += (irandom(myself.shake.dist) * choose(-1, 1));
	myself.yOfs += (irandom(myself.shake.dist) * choose(-1, 1));
	myself.shake.durCurr -= 1;
}

if (myself.draw.act == true)
{
	if (myself.imgSpd > 0)
	{
		image_index += myself.imgSpd;
		if (global.config.access.rdcdMot.act == true)
			image_index = 0;
	}
		
	fn_draw_spr(sprite_index, image_index, (myself.x + myself.xOfs), (myself.y + myself.yOfs), image_blend, image_alpha, myself.xSc, myself.ySc, myself.ang, false);
}
