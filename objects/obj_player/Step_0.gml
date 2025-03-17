 
 var _tile = layer_tilemap_get_id("Fase")
 move_and_collide(x_speed, y_speed, obj_solid);
 
// Estados existentes
is_on_ground = place_meeting(x, y + 1, obj_solid); // Agora verifica obj_solid
is_going_right = keyboard_check(ord("D"));
is_going_left = keyboard_check(ord("A"));
is_running = item_2;
is_jumping = keyboard_check_pressed(vk_space);

// Início do ataque especial com a tecla "F"
if (keyboard_check_pressed(ord("F")) && is_on_ground && !is_special_attacking) {
    is_special_attacking = true;
    special_attack_timer = 0; // Inicia em 0 para permitir a animação
    sprite_index = spr_player_attack;
    image_index = 0; // Reinicia a animação
    // Cria o obj_rastro à frente do jogador
    rastro_instance = instance_create_layer(x + image_xscale * 32, y, "Instances", obj_rastro);
    rastro_instance.image_xscale = image_xscale; // Mantém a direção do jogador
    rastro_instance.sprite_index = spr_rastro;   // Sprite do rastro
}

x_speed = 0;
y_speed += .2;

if (item_3) {
    max_jumps = 2;
}

// Detectar parede
var wall_direction = 0;
if (place_meeting(x + 1, y, obj_solid)) { // Verifica obj_solid
    wall_direction = 1;
} else if (place_meeting(x - 1, y, obj_solid)) { // Verifica obj_solid
    wall_direction = -1;
}

is_wall_grabbing = false;
if (!is_on_ground && y_speed > 0 && wall_direction != 0) {
    is_wall_grabbing = true;
    y_speed = 0.4;
    current_jumps = 1;
    sprite_index = spr_player_hold;
    image_xscale = wall_direction;
}

/*
Movimento
*/
if (is_on_ground) {
    y_speed = 0;
    current_jumps = max_jumps;
}

if (is_jumping && current_jumps > 0) {
    current_jumps--;
    y_speed -= 4;
    if (is_wall_grabbing) {
        x_speed = -wall_direction * 3;
    }
}

// Controlar o ataque especial
if (is_special_attacking) {
    special_attack_timer++;
    x_speed = 0; // Bloqueia o movimento do jogador
    y_speed = 0;
    sprite_index = spr_player_attack; // Mantém o sprite de ataque
    if (special_attack_timer >= special_attack_duration) {
        is_special_attacking = false;
        if (rastro_instance != noone) {
            // Teletransporta o jogador para a posição do rastro
            x = rastro_instance.x;
            y = rastro_instance.y;
            // Destroi o obj_rastro
            instance_destroy(rastro_instance);
            rastro_instance = noone; // Reseta a variável
        }
        sprite_index = spr_player_idle; // Volta ao idle após o ataque
    }
} else {
    // Define sprites fora do ataque especial
    if (!is_on_ground) {
        if (y_speed < 0) {
            sprite_index = spr_player_jump;
        } else {
            sprite_index = spr_player_fall;
        }
    } else {
        sprite_index = spr_player_idle; // Sprite padrão no chão
    }

    // Movimento para a direita
    if (is_going_right) {
        if (is_running) {
            if (is_on_ground) {
                sprite_index = spr_player_run;
                mask_index = spr_player_idle;
            }
            x_speed += 3;
            image_xscale = 1;
        } else {
            if (is_on_ground) {
                sprite_index = spr_player_walk;
                mask_index = spr_player_idle;
            }
            x_speed += 1;
            image_xscale = 1;
        }
    }

    // Movimento para a esquerda
    if (is_going_left) {
        if (is_running) {
            if (is_on_ground) {
                sprite_index = spr_player_run;
                mask_index = spr_player_idle;
            }
            x_speed -= 3;
            image_xscale = -1;
        } else {
            if (is_on_ground) {
                sprite_index = spr_player_walk;
                mask_index = spr_player_idle;
            }
            x_speed -= 1;
            image_xscale = -1;
        }
    }
}

if (!is_alive) {
    x_speed = 0;
    y_speed = 0;
    sprite_index = spr_player_death;
    image_xscale = 1;
    image_speed = 0;
}

move_and_collide(x_speed, y_speed, obj_solid);

if (instance_exists(obj_player)) {
    var player_x = obj_player.x;
    var player_y = obj_player.y;
    
    // Posição desejada da câmera (centralizada no jogador)
    var target_x = player_x - camera_get_view_width(global.camera) / 2;
    var target_y = player_y - camera_get_view_height(global.camera) / 2;
    
    // Obter a posição atual da câmera
    var current_x = camera_get_view_x(global.camera);
    var current_y = camera_get_view_y(global.camera);
    
    // Interpolar suavemente para a posição desejada
    var new_x = lerp(current_x, target_x, 0.1); // 0.1 é a velocidade de suavização (ajuste conforme necessário)
    var new_y = lerp(current_y, target_y, 0.1);
    
    // Atualizar a posição da câmera
    camera_set_view_pos(global.camera, new_x, new_y);
}