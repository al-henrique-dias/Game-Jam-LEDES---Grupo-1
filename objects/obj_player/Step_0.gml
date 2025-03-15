//step da velocidade de x, a constante atribuição de x permite que o player pare de se mover quando não há input constante
x_speed = 0;
//step da velocidade de y, a constante adição em y simula a força da gravidade
y_speed += .1;

/*
Movimento
*/
sprite_index = spr_player_idle_t;
//os objetos passados nos place_meeting() são os limites da queda (movimento em y para baixo) do player
if place_meeting(x, y+1, obj_ground){
	y_speed = 0;
	//espaço = pular - move o player para cima 3px por frame (limitado pela gravidade: quanto maior velocidade, mais alto o pulo)
	//o pulo só é iniciado quando o player está colidindo com o chão
	if keyboard_check_pressed(vk_space){//se move apenas a cada acionamento de tecla
		y_speed -= 3
	}
}
if !place_meeting(x, y+1, obj_ground)
	sprite_index = spr_player_jump;
//D = andar para a direita - move o player para a direita 2.5px por frame
if keyboard_check(ord("D")) {//se move enquanto a tecla estiver pressionada
	sprite_index = spr_player_walk_t;
	x_speed += 1;
	image_xscale = 1;
	mask_index = spr_player_idle_t;//mantém a máscara de colisão (garante funcionamento de colisão com terreno)
}
//A = andar para a esquerda - move o player para a esquerda 2.5px por frame
if keyboard_check(ord("A")) {	
	sprite_index = spr_player_walk_t;
	x_speed -= 1;
	image_xscale = -1;
	mask_index = spr_player_idle_t;//mantém a máscara de colisão (garante funcionamento de colisão com terreno)
}
//determina o movimento do player em relação ao terreno (adiciona colisão horizontal com obj_ground)
move_and_collide(x_speed, y_speed, obj_ground);

/*Seleção de itens*/
if keyboard_check_pressed(vk_shift){
	if selected_item==3//se o item 3 estiver selecionado, o próximo será o item 1 (completando um loop)
		selected_item = 1;
	else
		selected_item++;//seleciona o próximo item
}