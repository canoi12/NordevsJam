/// scr_move_state()


// Pulo
if(place_meeting(x, y + 1, obj_ground)){
    vspd = 0;
    
    if(keyJump){
        vspd = -jumpForce;
    }
}
// Gravidade 
else {
    if(vspd < 20){
        vspd += grav;
    }
    ground = false;
}

// Parar aceleração
if(move == 0){
    moveAcc *= 0.2;
} else {
    flip = move;
}

// Walljumps
if(move > 0){
    if (place_meeting(x+1, y, obj_ground) && !place_meeting(x, y+1, obj_ground)){
        wall = true;
        vspd = vspd/2;
        if(keyboard_check_pressed(vk_up)){
            if(wall){
                wall = false;
                yscale = 1.33;
                xscale = 0.67;
            }
            vspd = -jumpForce;
            move = -2;
        }
    } else {
        wall = false;
    }
}
else if(move < 0){
    if(place_meeting(x- 1, y, obj_ground) && !place_meeting(x, y+1, obj_ground)){
        wall = true;
        vspd = vspd/2;
        if(keyboard_check_pressed(vk_up)){
            if(wall){
                wall = false;
                yscale = 1.33;
                xscale = 0.67;
            }
            vspd = (-jumpForce);
            move = 2;
        }
    } else {
        wall = false;
    }
}

// Aceleração
if(abs(moveAcc) < maxSpeed){
    moveAcc += move * (moveSpeed * (delta_time/1000000));
}

// Colisão Horizontal
if(place_meeting(x + moveAcc, y, obj_ground)){
    while(!place_meeting(x + sign(moveAcc), y, obj_ground)) {
        x += sign(moveAcc);
    }
    moveAcc = 0;
}


x += moveAcc;

// Colisão Vertical
if(place_meeting(x, y + vspd, obj_ground)){
    // Tentativa de animação dinâmica
    if(!ground){
        ground = true;
        if(vspd >= 15){
            yscale = 1.33;
            xscale = 0.67;
        }
    }
    while(!place_meeting(x, y + sign(vspd), obj_ground)){
        y += sign(vspd);
    }
    vspd = 0;
}


y += vspd;
