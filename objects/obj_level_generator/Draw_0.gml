
function draw_node(node) {
    if (node.room != -1) {
        draw_rectangle(node.room.x * 32, node.room.y * 32,
                       (node.room.x + node.room.width) * 32,
                       (node.room.y + node.room.height) * 32, true);
    }
    if (node.left != -1) draw_node(node.left);
    if (node.right != -1) draw_node(node.right);
}
draw_node(global.root);

