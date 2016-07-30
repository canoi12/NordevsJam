///kabuki_chase_state()
if (instance_exists(obj_ninja)) {
var dir = point_direction(x, y, obj_ninja.x, obj_ninja.y);
hspd = lengthdir_x(spd, dir);
vspd = lengthdir_y(spd, dir);

//change to the flying sprite
sprite_index = spr_kabuki;
//face the right direction
if (hspd != 0) image_xscale = sign(hspd);
//move
move_towards_point(obj_ninja.x, obj_ninja.y, 10);
}
