/* Self-drawing */
if (myself.active == true)
{
	myself.image = ((myself.imageSpeed > 0 && global.config.access.reduceMotion.active == true) ? (myself.image + myself.imageSpeed) : 0);
	myself.shake.xOffset = ((myself.shake.active == true && myself.shake.time > 0) ? (irandom(myself.shake.distance) * choose(-1, 1)) : 0);
	myself.shake.xOffset = ((myself.shake.active == true && myself.shake.time > 0) ? (irandom(myself.shake.distance) * choose(-1, 1)) : 0);
	myself.shake.time = ((myself.shake.time > 0) ? (myself.shake.time - 1) : 0);
	fn_draw_spr(sprite_index, myself.image, (myself.x + myself.xOffset + myself.shake.xOffset), (myself.y + myself.yOffset + myself.shake.yOffset), image_blend, image_alpha, myself.xScale, myself.yScale, myself.angle);
}