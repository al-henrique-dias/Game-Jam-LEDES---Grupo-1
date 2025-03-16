//previne que o player fique preso na parede ao mudar de direção
if keyboard_check(ord("D")) or keyboard_check(vk_right)
	obj_player.x += 1;
//previne que o player fique preso na parede ao mudar de direção
if keyboard_check(ord("A")) or keyboard_check(vk_left)
	obj_player.x -= 1;