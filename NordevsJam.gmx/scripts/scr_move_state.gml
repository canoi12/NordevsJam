/// scr_move_state()

if(place_meeting(x, y + 1, obj_ground)){
    vspd = 0;
    
    if(keyJump){
        vspd = -jumpForce;
    }
} else {
    if(vspd < 15){
        vspd += grav;
    }
}

if(move == 0){
    moveAcc *= 0.2;
}


if(move > 0){
    if (place_meeting(x+1, y, obj_ground) && !place_meeting(x, y+1, obj_ground)){
        vspd = vspd/2;
        if(keyboard_check_pressed(vk_up)){
            vspd = -jumpForce;
            move = -2;
        }
    }
}
else if(move < 0){
    if(place_meeting(x- 1, y, obj_ground) && !place_meeting(x, y+1, obj_ground)){
        vspd = vspd/2;
        if(keyboard_check_pressed(vk_up)){
            vspd = (-jumpForce);
            move = 2;
        }
    }
}


if(abs(moveAcc) < maxSpeed){
    moveAcc += move * (moveSpeed * (delta_time/1000000));
}

if(place_meeting(x + moveAcc, y, obj_ground)){
    while(!place_meeting(x + sign(moveAcc), y, obj_ground)) {
        x += sign(moveAcc);
    }
    moveAcc = 0;
}

x += moveAcc;

if(place_meeting(x, y + vspd, obj_ground)){
    while(!place_meeting(x, y + sign(vspd), obj_ground)){
        y += sign(vspd);
    }
    vspd = 0;
}

y += vspd;
