// Inicialização da grid
global.level_grid = ds_grid_create(74, 64); 
ds_grid_clear(global.level_grid, 0); // 0 = vazio

// Estrutura do nó BSP
function BSPNode(x, y, width, height) constructor {
    self.x = x;           // Posição X em células
    self.y = y;           // Posição Y em células
    self.width = width;   // Largura em células
    self.height = height; // Altura em células
    self.left = -1;       // Filho esquerdo
    self.right = -1;      // Filho direito
    self.room = -1;       // Sala (se for folha)
}

// Função para dividir o nó
function divide_node(node) {
    // Critério de parada: se o retângulo for muito pequeno, crie uma sala
    if (node.width < 10 || node.height < 10) {
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

// Função para criar uma sala com portas
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
    
    // Adicionar pelo menos uma porta (neste caso, uma no lado leste e uma no oeste)
    var door1_x = room_x;                     // Porta oeste
    var door1_y = room_y + irandom(room_height_ - 1);
    global.level_grid[# door1_x, door1_y] = 4; // 4 = porta
    
    var door2_x = room_x + room_width_ - 1;   // Porta leste
    var door2_y = room_y + irandom(room_height_ - 1);
    global.level_grid[# door2_x, door2_y] = 4;
    
    // Retornar informações da sala, incluindo portas
    return {
        x: room_x, 
        y: room_y, 
        width: room_width_, 
        height: room_height_, 
        doors: [[door1_x, door1_y], [door2_x, door2_y]]
    };
}

// Função para coletar todas as salas folhas
function get_leaf_rooms(node) {
    if (node.room != -1) {
        return [node.room];
    }
    var left_rooms = get_leaf_rooms(node.left);
    var right_rooms = get_leaf_rooms(node.right);
    return array_concat(left_rooms, right_rooms);
}

// Função para conectar salas
function connect_rooms(node) {
    if (node.left != -1 && node.right != -1) {
        var left_rooms = get_leaf_rooms(node.left);
        var right_rooms = get_leaf_rooms(node.right);
        
        // Escolher uma sala aleatória de cada subárvore
        var room1 = left_rooms[irandom(array_length(left_rooms) - 1)];
        var room2 = right_rooms[irandom(array_length(right_rooms) - 1)];
        
        // Conectar as duas salas usando portas
        connect_two_rooms(room1, room2);
        
        // Recursão para os filhos
        connect_rooms(node.left);
        connect_rooms(node.right);
    }
}

// Função para conectar duas salas específicas
function connect_two_rooms(room1, room2) {
    // Escolher uma porta de cada sala
    var door1 = room1.doors[irandom(array_length(room1.doors) - 1)];
    var door2 = room2.doors[irandom(array_length(room2.doors) - 1)];
    
    var x1 = door1[0];
    var y1 = door1[1];
    var x2 = door2[0];
    var y2 = door2[1];
    
    // Criar corredor em L: horizontal primeiro, depois vertical (ou vice-versa)
    if (irandom(1) == 0) {
        create_horizontal_corridor(x1, x2, y1);
        create_vertical_corridor(y1, y2, x2);
    } else {
        create_vertical_corridor(y1, y2, x1);
        create_horizontal_corridor(x1, x2, y2);
    }
}

// Função para criar corredor horizontal
function create_horizontal_corridor(x1, x2, y) {
    var min_x = min(x1, x2);
    var max_x = max(x1, x2);
    for (var i = min_x; i <= max_x; i++) {
        if (global.level_grid[# i, y] != 1 && global.level_grid[# i, y] != 4) { // Evitar sobrescrever chão ou portas
            global.level_grid[# i, y] = 3; // Chão do corredor
        }
    }
}

// Função para criar corredor vertical
function create_vertical_corridor(y1, y2, x) {
    var min_y = min(y1, y2);
    var max_y = max(y1, y2);
    for (var j = min_y; j <= max_y; j++) {
        if (global.level_grid[# x, j] != 1 && global.level_grid[# x, j] != 4) { // Evitar sobrescrever chão ou portas
            global.level_grid[# x, j] = 3; // Chão do corredor
        }
    }
}