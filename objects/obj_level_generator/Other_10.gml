// Limpar instâncias existentes
with (obj_enemy) instance_destroy();
with (obj_item_1) instance_destroy();
with (obj_item_2) instance_destroy();
with (obj_item_3) instance_destroy();
with (obj_floor) instance_destroy(); // Limpa o chão, se aplicável

// Garantir aleatoriedade única
randomize();

// Criar o grid do nível
if (ds_exists(global.level_grid, ds_type_grid)) ds_grid_destroy(global.level_grid); // Destroi o grid antigo
global.level_grid = ds_grid_create(64, 64); // Grid 64x64
ds_grid_clear(global.level_grid, 0); // Limpa o grid
global.root = new BSPNode(0, 0, 64, 64); // Estrutura BSP para divisão do mapa
divide_node(global.root); // Divide o mapa em salas
connect_rooms(global.root); // Conecta as salas com corredores

// Instanciar o chão no grid
for (var i = 0; i < ds_grid_width(global.level_grid); i++) {
    for (var j = 0; j < ds_grid_height(global.level_grid); j++) {
        var cell_type = global.level_grid[# i, j];
        var pos_x = i * 32; // Cada célula tem 32 pixels
        var pos_y = j * 32;
        if (cell_type == 2) { // Chão visível
            instance_create_layer(pos_x, pos_y, "Instances", obj_floor);
        }
    }
}

// Criar lista de posições válidas para spawn
var valid_positions = ds_list_create();
for (var i = 0; i < ds_grid_width(global.level_grid); i++) {
    for (var j = 0; j < ds_grid_height(global.level_grid); j++) {
        var cell_type = global.level_grid[# i, j];
        if (cell_type == 1 || cell_type == 3) { // Chão de sala ou corredor
            var pos_x = i * 32;
            var pos_y = j * 32;
            ds_list_add(valid_positions, [pos_x, pos_y]); // Adiciona posição como array
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
    camera_set_view_target(global.camera, player_instance); // Câmera segue o jogador
}

// Spawnar inimigos 
var num_enemies = 10;
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

// Spawnar itens 
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

// Limpar memória
ds_list_destroy(valid_positions);