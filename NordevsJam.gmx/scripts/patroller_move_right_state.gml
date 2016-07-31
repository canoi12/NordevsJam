///patroller_move_right_state
//var wall_at_right = place_meeting(x+1, y, obj_ground);
var ledge_at_right = position_meeting(bbox_right+10, bbox_bottom+10, obj_ground_invisivel);
if (ledge_at_right) {
    state = patroller_move_left_state;
}
//control the snake sprite
image_xscale = 1;

//move the snake
x += 1;
//wall_at_right
