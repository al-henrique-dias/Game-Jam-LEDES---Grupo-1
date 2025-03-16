randomize();
global.level_grid = ds_grid_create(32, 24); // Grid de 32x24 células
ds_grid_clear(global.level_grid, 0);
global.root = new BSPNode(0, 0, 32, 24); // Exemplo de algoritmo BSP
divide_node(global.root); // Divide os nós
connect_rooms(global.root); // Conecta as salas

// Instanciar objetos
for (var i = 0; i < ds_grid_width(global.level_grid); i++) {
    for (var j = 0; j < ds_grid_height(global.level_grid); j++) {
        var cell_type = global.level_grid[# i, j];
        var pos_x = i * 32;
        var pos_y = j * 32;
        if (cell_type == 1 || cell_type == 3) {
            instance_create_layer(pos_x, pos_y, "Instances", obj_wall);
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
            var pos_x = i * 32; // Multiplica por 32 para converter de células para pixels
            var pos_y = j * 32;
            ds_list_add(valid_positions, [pos_x, pos_y]); // Adiciona a posição como um array [x, y]
        }
    }
}

// Spawnar o player
if (ds_list_size(valid_positions) > 0) {
    var index = irandom(ds_list_size(valid_positions) - 1); // Escolhe um índice aleatório
    var pos = valid_positions[| index]; // Pega a posição correspondente
    var player_x = pos[0];
    var player_y = pos[1];
    instance_create_layer(player_x, player_y, "Instances", obj_player); // Cria o player
    ds_list_delete(valid_positions, index); // Remove a posição usada
}

// Spawnar inimigos (exemplo: 3 inimigos)
var num_enemies = 3;
for (var k = 0; k < num_enemies; k++) {
    if (ds_list_size(valid_positions) > 0) {
        var index = irandom(ds_list_size(valid_positions) - 1);
        var pos = valid_positions[| index];
        var enemy_x = pos[0];
        var enemy_y = pos[1];
        instance_create_layer(enemy_x, enemy_y, "Instances", obj_enemy); // Cria o inimigo
        ds_list_delete(valid_positions, index); // Remove a posição usada
    }
}

// Spawnar itens (exemplo: 3 itens)
var num_items = 3;
for (var k = 0; k < num_items; k++) {
    if (ds_list_size(valid_positions) > 0) {
        var index = irandom(ds_list_size(valid_positions) - 1);
        var pos = valid_positions[| index];
        var item_x = pos[0];
        var item_y = pos[1];
        instance_create_layer(item_x, item_y, "Instances", obj_item_1); // Cria o item (ajuste o nome)
        ds_list_delete(valid_positions, index); // Remove a posição usada
    }
}
// Destruir a lista para evitar vazamento de memória
ds_list_destroy(valid_positions);