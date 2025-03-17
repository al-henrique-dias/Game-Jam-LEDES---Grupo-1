function generate_new_map() {
    // Limpar instâncias existentes
    with (obj_enemy) instance_destroy();
    with (obj_item_1) instance_destroy();
    with (obj_item_2) instance_destroy();
    with (obj_item_3) instance_destroy();
    with (obj_floor) instance_destroy(); // Limpa o chão, se necessário

    // Garante aleatoriedade diferente a cada execução
    randomize();

    // Criar o grid do nível
    if (ds_exists(global.level_grid, ds_type_grid)) ds_grid_destroy(global.level_grid); // Destroi o grid antigo, se existir
    global.level_grid = ds_grid_create(64, 64);
    ds_grid_clear(global.level_grid, 0);
    global.root = new BSPNode(0, 0, 64, 64);
    divide_node(global.root); // Divide os nós
    connect_rooms(global.root); // Conecta as salas

    // Instanciar objetos no grid
    for (var i = 0; i < ds_grid_width(global.level_grid); i++) {
        for (var j = 0; j < ds_grid_height(global.level_grid); j++) {
            var cell_type = global.level_grid[# i, j];
            var pos_x = i * 32;
            var pos_y = j * 32;
            if (cell_type == 1 || cell_type == 3) {
                // Chão da sala ou corredor (não cria nada aqui ainda)
            } else if (cell_type == 2) {
                instance_create_layer(pos_x, pos_y, "Instances", obj_floor);
            }
        }
    }

    // Criar uma lista para armazenar posições válidas
    var valid_positions = ds_list_create();

    // Percorrer o grid para encontrar células de chão
    for (var i = 0; i < ds_grid_width(global.level_grid); i++) {
        for (var j = 0; j < ds_grid_height(global.level_grid); j++) {
            var cell_type = global.level_grid[# i, j];
            if (cell_type == 1 || cell_type == 3) { // Chão da sala ou corredor
                var pos_x = i * 32;
                var pos_y = j * 32;
                ds_list_add(valid_positions, [pos_x, pos_y]); // Adiciona a posição como array [x, y]
            }
        }
    }

    // Reposicionar o jogador
    if (ds_list_size(valid_positions) > 0) {
        var index = irandom(ds_list_size(valid_positions) - 1);
        var pos = valid_positions[| index];
        var player_x = pos[0];
        var player_y = pos[1];
        if (!instance_exists(obj_player)) {
            var player_instance = instance_create_layer(player_x, player_y, "Instances", obj_player);
        } else {
            obj_player.x = player_x;
            obj_player.y = player_y;
            var player_instance = obj_player;
        }
        ds_list_delete(valid_positions, index);
        
        // Configurar a câmera para seguir o jogador
        camera_set_view_target(global.camera, player_instance);
    }

    // Spawnar inimigos (exemplo: 3 inimigos)
    var num_enemies = 3;
    for (var k = 0; k < num_enemies; k++) {
        if (ds_list_size(valid_positions) > 0) {
            var index = irandom(ds_list_size(valid_positions) - 1);
            var pos = valid_positions[| index];
            var enemy_x = pos[0];
            var enemy_y = pos[1];
            instance_create_layer(enemy_x, enemy_y, "Instances", obj_enemy);
            ds_list_delete(valid_positions, index);
        }
    }

    // Spawnar itens (3 itens diferentes)
    var num_items = 3;
    var item_objects = [obj_item_1, obj_item_2, obj_item_3];
    for (var k = 0; k < num_items; k++) {
        if (ds_list_size(valid_positions) > 0) {
            var index = irandom(ds_list_size(valid_positions) - 1);
            var pos = valid_positions[| index];
            var item_x = pos[0];
            var item_y = pos[1];
            var item_obj = item_objects[k];
            instance_create_layer(item_x, item_y, "Instances", item_obj);
            ds_list_delete(valid_positions, index);
        }
    }

    // Destruir a lista para evitar vazamento de memória
    ds_list_destroy(valid_positions);
}