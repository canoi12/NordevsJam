/// scr_move_state()


// Pulo
if(place_meeting(x, y + 1, obj_ground)){
    vspd = 0;
    ground = true;
    if(keyJump){
        vspd = -jumpForce;
        yscale = 1.33;
        xscale = 0.67;
    }
}
// Gravidade 
else {
    ground = false;
    if(vspd < 20){
        vspd += grav;
    }
    ground = false;
    if(!ground && !wall){
        sprite_index = spr_ninja_fall;
    }
}

// Parar aceleração
if(move == 0){
    moveAcc *= 0.75;
    if(ground && !wall){
       sprite_index = spr_ninja_idle; 
    }
} else {
    flip = move;
    if(ground && !wall){
        sprite_index = spr_ninja_walk;
    }
}

// Walljumps
if(move > 0){
    if (place_meeting(x+1, y, obj_ground) && !place_meeting(x, y+1, obj_ground)){
        wall = true;
        vspd *= 0.7;
        if(keyJumpPressed){
            if(wall){
                yscale = 1.33;
                xscale = 0.67;
            }
            wall = false;
            vspd = -jumpForce;
            move = -4;
        }
    } else {
        wall = false;
    }
}
else if(move < 0){
    if(place_meeting(x-1, y, obj_ground) && !place_meeting(x, y+1, obj_ground)){
        wall = true;
        vspd *= 0.7;
        if(keyJumpPressed){
            if(wall){
                yscale = 1.33;
                xscale = 0.67;
            }
             wall = false;
            vspd = (-jumpForce);
            move = 4;
        }
    } else {
        wall = false;
    }
}

if(wall)
    sprite_index = spr_ninja_wall;
    
dashCoolDown -= 0.1;
if(dashCoolDown <= 0){
    dashSpeed = 0;
} 
if(keyDash && dashCoolDown <= 0){
    dashSpeed = 10;
    dashCoolDown = 0.6;
    xscale = 1.33;
    yscale = 0.67;
} 

moveAcc += move * (moveSpeed * (delta_time/1000000)) + (sign(move)*dashSpeed);
// Aceleração
if(abs(moveAcc) >= (maxSpeed + dashSpeed)){
    moveAcc = move * (maxSpeed) + (sign(move)*dashSpeed);
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
        if(vspd >= 15){
            xscale = 1.33;
            yscale = 0.67;
        }
    }
    while(!place_meeting(x, y + sign(vspd), obj_ground)){
        y += sign(vspd);
    }
    ground = true;
    vspd = 0;
}


y += vspd;
