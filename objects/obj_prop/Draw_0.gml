/* Self-drawing */
if (myself.active == true)
{
	if (myself.type == MYSELF_TYPE_ACTOR)
		myself.sprite = facing[facing_curr].sprite;
	if (myself.imageSpeed > 0 && global.config.access.reduceMotion.active == false)
		myself.image = (myself.image + myself.imageSpeed);
	myself.shake.offsetX = ((myself.shake.active == true && myself.shake.time > 0) ? (irandom(myself.shake.distance) * choose(-1, 1)) : 0);
	myself.shake.offsetY = ((myself.shake.active == true && myself.shake.time > 0) ? (irandom(myself.shake.distance) * choose(-1, 1)) : 0);
	myself.shake.time = ((myself.shake.time > 0) ? (myself.shake.time - 1) : 0);
	fn_draw_spr(myself.sprite, myself.image, (myself.x + myself.offsetX + myself.shake.offsetX), (myself.y + myself.offsetY + myself.shake.offsetY), image_blend, image_alpha, myself.scaleX, myself.scaleY, myself.angle);
}