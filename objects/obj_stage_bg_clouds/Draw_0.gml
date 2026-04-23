
var _loop = clouds.loop;
var _move = clouds.loop.move;

// Movement
if (_move.xTime > 0 && _move.yTime > 0)
{
	clouds.xOffset += ((_loop.xDist * _move.xSign) / _move.xTime);
	if (abs(clouds.x + clouds.xOffset) >= _loop.xDist)
		clouds.xOffset -= (_loop.xDist * _move.xSign);
	clouds.yOffset += ((_loop.yDist * _move.ySign) / _move.yTime);
	if (abs(clouds.y + clouds.yOffset) >= _loop.yDist)
		clouds.yOffset -= (_loop.yDist * _move.ySign);
}
// Drawings
for (var w = 0; w < _loop.xLength; w++)
{
	for (var h = 0; h < _loop.yLength; h++)
	{
		var _loop_xAdd = (_loop.xDist * (w - _loop.xLength_outsideRoom));
		var _loop_yAdd = (_loop.yDist * (h - _loop.yLength_outsideRoom));
		fn_draw_spr(clouds.sprite, clouds.image, (clouds.x + (clouds.xOffset * (global.config.access.rdcdMot.act == false)) + _loop_xAdd), (clouds.y + (clouds.yOffset * (global.config.access.rdcdMot.act == false)) + _loop_yAdd), clouds.color, clouds.alpha, clouds.xScale, clouds.yScale, clouds.angle);
	}
}
