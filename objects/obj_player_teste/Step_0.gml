var _tile = layer_tilemap_get_id("Fase");

var _chao = place_meeting(x, y+1, _tile);

var _right =  keyboard_check(vk_right);
var _left =  keyboard_check(vk_left);
var _jump =  keyboard_check_pressed(vk_space);

velh = (_right - _left) * velh_max;

//gravidade
if (!_chao)
{
	velv += grav;
}
else
{
	velv = 0;
	if(_jump)
	{
		velv = -velv_max;
	}
}
//movendo horizontal
move_and_collide(velh, 0, _tile);

//movendo na vertical
move_and_collide(0, velv, _tile, 12);

