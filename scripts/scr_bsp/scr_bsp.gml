function BSPNode(x, y, width, height) constructor {
    self.x = x;           // Posição X do retângulo
    self.y = y;           // Posição Y do retângulo
    self.width = width;   // Largura em células
    self.height = height; // Altura em células
    self.left = -1;       // Filho esquerdo (outro nó)
    self.right = -1;      // Filho direito (outro nó)
    self.room = -1;       // Sala (se for uma folha)
}

function divide_node(node) {
    // Critério de parada: se o retângulo for muito pequeno, crie uma sala
    if (node.width < 8 || node.height < 8) {
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
    return {x: room_x, y: room_y, width: room_width_, height: room_height_};
}

function connect_rooms(node) {
    if (node.left != -1 && node.right != -1) {
        var room1 = get_leaf_room(node.left);
        var room2 = get_leaf_room(node.right);
        // Conecta os centros das salas (simplificado)
        var x1 = room1.x + room1.width / 2;
        var y1 = room1.y + room1.height / 2;
        var x2 = room2.x + room2.width / 2;
        var y2 = room2.y + room2.height / 2;
        // Aqui você pode criar tiles ou objetos para o corredor 
        connect_rooms(node.left);
        connect_rooms(node.right);
    }
}

function get_leaf_room(node) {
    if (node.room != -1) return node.room;
    return get_leaf_room(node.left); // Simplificado, pode precisar ajustes
}