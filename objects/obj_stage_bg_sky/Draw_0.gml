
var _loop = sky.loop;
var _move = sky.loop.move;

// Movement
if (_move.xDur > 0 && _move.yDur > 0 && global.config.access.rdcdMot.act == false)
{
	sky.xOfs += ((_loop.xDist * _move.xSign) / _move.xDur); 
	if (abs(sky.x + sky.xOfs) >= _loop.xDist)
		sky.xOfs -= (_loop.xDist * _move.xSign);
	
	sky.yOfs += ((_loop.yDist * _move.ySign) / _move.yDur);
	if (abs(sky.y + sky.yOfs) >= _loop.yDist)
		sky.yOfs -= (_loop.yDist * _move.ySign);
}

// Draws the sky background
for (var w = 0; w < _loop.xLen; w++)
{
	for (var h = 0; h < _loop.yLen; h++)
	{
		var _loop_xAdd = (_loop.xDist * (w - _loop.xLenOUT));
		var _loop_yAdd = (_loop.yDist * (h - _loop.yLenOUT));
		fn_draw_spr_stretch(sky.spr, sky.img, (sky.x + sky.xOfs + _loop_xAdd), (sky.y + sky.yOfs + _loop_yAdd), sky.w, sky.h, sky.col, sky.alp);
	}
}

