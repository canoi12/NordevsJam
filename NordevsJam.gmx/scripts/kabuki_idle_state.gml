///kabuki_idle_state()
image_index = spr_kabuki_idle;
//procurar jogador
if (instance_exists(obj_ninja)) {
var dis = point_distance(x, y, obj_ninja.x, obj_ninja.y);

if (dis < sight) {
state = kabuki_chase_state;
}
}
