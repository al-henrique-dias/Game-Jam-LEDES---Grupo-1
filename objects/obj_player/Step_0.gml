//step da velocidade de x, a constante atribuição de x permite que o player pare de se mover quando não há input constante
x_speed = 0;
//step da velocidade de y, a constante adição em y simula a força da gravidade
y_speed += .1;

/*
Movimento
*/
//os objetos passados nos place_meeting() são os limites da queda (movimento em y para baixo) do player
if place_meeting(x, y+1, obj_ground){
	y_speed = 0;
}
//espaço = pular - move o player para cima 2px por frame (limitado pela gravidade: quanto maior velocidade, mais alto o pulo)
if keyboard_check_pressed(vk_space)
	y_speed -= 3
//D = andar para a direita - move o player para a direita 1px por frame
if keyboard_check(ord("D")) or keyboard_check(vk_right){
	x_speed += 2.5;
}
//A = andar para a esquerda - move o player para a esquerda 1px por frame
if keyboard_check(ord("A")) or keyboard_check(vk_left){	
	x_speed -= 2.5;
}
//determina o movimento do player em relação ao terreno (adiciona colisão horizontal com obj_ground)
move_and_collide(x_speed, y_speed, obj_ground);