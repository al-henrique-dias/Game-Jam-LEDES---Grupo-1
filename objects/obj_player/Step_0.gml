/*Estados do Player*/
//no chão
is_on_ground = place_meeting(x, y+1, obj_ground);
//andando para a direita
is_going_right = keyboard_check(ord("D"));
//andando para a esquerda
is_going_left = keyboard_check(ord("A"));
//correndo
is_running = item_2;
//pulando
is_jumping = keyboard_check_pressed(vk_space);
//atacando
is_attacking = keyboard_check_pressed(ord("W"));
//step da velocidade de x, a constante atribuição de x permite que o player pare de se mover quando não há input constante
x_speed = 0;
//step da velocidade de y, a constante adição em y simula a força da gravidade
y_speed += .2;

sprite_index = spr_player_idle;//sprite de idle adivado por default

if item_3//o item 3 permite double jumps
	max_jumps = 2;

/*
Movimento
*/
//os objetos passados nos place_meeting() são os limites da queda (movimento em y para baixo) do player
if is_on_ground {//verifica se o player está no chão
	y_speed = 0;
	current_jumps = max_jumps;
}
//espaço = pular - move o player para cima 3px por frame (limitado pela gravidade: quanto maior velocidade, mais alto o pulo)
if is_jumping and current_jumps > 0 {//movimento para cada acionamento de tecla
	current_jumps--;
	y_speed -= 4;
}
if !is_on_ground//verifica se o player está no ar (não está no chão)
	if y_speed < 0
		sprite_index = spr_player_jump;//sprite de pulo ativa
	else
		sprite_index = spr_player_fall;//sprite de queda ativa
//D = andar para a direita - move o player para a direita (x_speed)px por frame
if is_going_right {//movimento para enquanto a tecla estiver pressionada
	if is_running {//o player só corre quando coletou o item 2
		if is_on_ground{//verifica se o player está no chão
			if is_attacking
				sprite_index = spr_player_attack;
			else
				sprite_index = spr_player_run;//sprite de correr ativa
			mask_index = spr_player_idle;//mantém a máscara de colisão (garante funcionamento de colisão com terreno)
		}
		x_speed += 3;
		image_xscale = 1;//inverte o sprite para a direita
	} else {//se não estiver correndo, vai apenas ander
		if is_on_ground{//verifica se o player está no chão
			if is_attacking
				sprite_index = spr_player_attack;
			else
				sprite_index = spr_player_walk;//sprite de andar ativa
			mask_index = spr_player_idle;//mantém a máscara de colisão (garante funcionamento de colisão com terreno)
		}
		x_speed += 1;
		image_xscale = 1;//inverte o sprite para a direita
	}
}
//A = andar para a esquerda - move o player para a esquerda (x_speed)px por frame
if is_going_left {//movimento para enquanto a tecla estiver pressionada
	if is_running {//o player só corre quando coletou o item 2
		if is_on_ground{
			if is_attacking
				sprite_index = spr_player_attack;
			else
				sprite_index = spr_player_run;//sprite de correr ativa
			mask_index = spr_player_idle;//mantém a máscara de colisão (garante funcionamento de colisão com terreno)
		}
		x_speed -= 3;
		image_xscale = -1;//inverte o sprite para a esquerda
	} else {//se não estiver correndo, vai apenas andar
		if is_on_ground{
			if is_attacking
				sprite_index = spr_player_attack;
			else
				sprite_index = spr_player_walk;//sprite de andar ativa
			mask_index = spr_player_idle;//mantém a máscara de colisão (garante funcionamento de colisão com terreno)
		}
		x_speed -= 1;
		image_xscale = -1;//inverte o sprite para a esquerda
	}
}

if !is_alive{
	x_speed = 0;
	y_speed = 0;
	sprite_index = spr_player_death;
	image_xscale = 1;
	image_speed = 0;
}
//determina o movimento do player em relação ao terreno (adiciona colisão horizontal com obj_ground)
move_and_collide(x_speed, y_speed, obj_ground);