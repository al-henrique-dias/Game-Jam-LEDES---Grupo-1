
global.level_grid = ds_grid_create(32, 32); 
ds_grid_clear(global.level_grid, 0); // 0 = vazio
function BSPNode(x, y, width, height) constructor {
    self.x = x;           // Posição X em células
    self.y = y;           // Posição Y em células
    self.width = width;   // Largura em células
    self.height = height; // Altura em células
    self.left = -1;       // Filho esquerdo
    self.right = -1;      // Filho direito
    self.room = -1;       // Sala (se for folha)
}

function divide_node(node) {
    // Critério de parada: se o retângulo for muito pequeno, crie uma sala
    if (node.width < 9 || node.height < 8) {
        node.room = create_room(node.x, node.y, node.width, node.height);
        return;
    }
    
    // Decide se divide horizontalmente ou verticalmente
    if (irandom(1) == 0 && node.height >= 10) { // Divisão horizontal
        var split = irandom_range(4, node.height - 4);
        node.left = new BSPNode(node.x, node.y, node.width, split);
        node.right = new BSPNode(node.x, node.y + split, node.width, node.height - split);
    } else if (node.width >= 10) { // Divisão vertical
        var split = irandom_range(4, node.width - 4);
        node.left = new BSPNode(node.x, node.y, split, node.height);
        node.right = new BSPNode(node.x + split, node.y, node.width - split, node.height);
    } else {
        node.room = create_room(node.x, node.y, node.width, node.height);
        return;
    }
    
    // Divide os filhos
    divide_node(node.left);
    divide_node(node.right);
}

function create_room(x, y, width, height) {
    var room_width_ = irandom_range(max(4, width - 4), width - 2);
    var room_height_ = irandom_range(max(4, height - 4), height - 2);
    var room_x = x + irandom_range(1, width - room_width_ - 1);
    var room_y = y + irandom_range(1, height - room_height_ - 1);
    
    // Marcar células da sala na grid
    for (var i = room_x; i < room_x + room_width_; i++) {
        for (var j = room_y; j < room_y + room_height_; j++) {
            if (i == room_x || i == room_x + room_width_ - 1 || j == room_y || j == room_y + room_height_ - 1) {
                global.level_grid[# i, j] = 2; // Parede
            } else {
                global.level_grid[# i, j] = 1; // Chão
            }
        }
    }
    return {x: room_x, y: room_y, width: room_width_, height: room_height_};
}

function connect_rooms(node) {
    if (node.left != -1 && node.right != -1) {
        var room1 = get_leaf_room(node.left);
        var room2 = get_leaf_room(node.right);
        var x1 = room1.x + room1.width / 2;
        var y1 = room1.y + room1.height / 2;
        var x2 = room2.x + room2.width / 2;
        var y2 = room2.y + room2.height / 2;
        
        // Corredor horizontal
        if (y1 == y2) {
            var min_x = min(x1, x2);
            var max_x = max(x1, x2);
            for (var i = min_x; i <= max_x; i++) {
                global.level_grid[# i, y1] = 3; // Chão do corredor
            }
        }
        // Corredor vertical
        else if (x1 == x2) {
            var min_y = min(y1, y2);
            var max_y = max(y1, y2);
            for (var j = min_y; j <= max_y; j++) {
                global.level_grid[# x1, j] = 3; // Chão do corredor
            }
        }
        // Recursão para os filhos
        connect_rooms(node.left);
        connect_rooms(node.right);
    }
}

function get_leaf_room(node) {
    if (node.room != -1) return node.room;
    return get_leaf_room(node.left); // Simplificado, pode precisar ajustes
}
