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
	//espaço = pular - move o player para cima 3px por frame (limitado pela gravidade: quanto maior velocidade, mais alto o pulo)
	//o pulo só é iniciado quando o player está colidindo com o chão
	if keyboard_check_pressed(ord("W"))//se move apenas a cada acionamento de tecla
		y_speed -= 3
}
//D = andar para a direita - move o player para a direita 2.5px por frame
if keyboard_check(ord("D")) {//se move enquanto a tecla estiver pressionada
	x_speed += 2.5;
	image_xscale = 1;
}
//A = andar para a esquerda - move o player para a esquerda 2.5px por frame
if keyboard_check(ord("A")) {	
	x_speed -= 2.5;
	image_xscale = -1;
}
//determina o movimento do player em relação ao terreno (adiciona colisão horizontal com obj_ground)
move_and_collide(x_speed, y_speed, obj_ground);