 /*Coletar item 1*/
if keyboard_check_pressed(ord("S")){
	global.items_collected += 1; // Incrementa a contagem
	obj_player.item_1 = true;//determina se o player coletou o item, declarando que ele agora o possui
	instance_destroy();//destrói o a instância do item na fase (remove o sprite) 
}