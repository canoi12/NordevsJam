/// scr_move_state()

if(moveAcc != 0){
    flip = sign(moveAcc);
}

// Ataques
if(keyAttack && !attack){
    image_index = 0;
    if(ground && !wall && dashSpeed <= 0 && move == 0){
        attack = true;
        sprite_index = spr_ninja_idle_attack;
    }
    else if(!ground && !wall && dashSpeed <= 0){
        attack = true;
        sprite_index = spr_ninja_jump_attack;
    } else if(!wall && dashSpeed > 0){
        attack = true;
        sprite_index = spr_ninja_dash_attack;        
    }
}

if(sprite_index == spr_ninja_jump_attack && ground){
    attack = false;
}

// Pulo
if(place_meeting(x, y + 1, obj_ground)){
    vspd = 0;
    ground = true;
    if(keyJump && !attack){
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
    if(!ground && !wall && !attack){
        sprite_index = spr_ninja_fall;
    }
    if(wall){
        if(flip == -1){
            part_emitter_region(ps, pe, x-16, x-16, y, y+24, ps_shape_rectangle, ps_distr_linear);
            part_emitter_burst(ps, pe, pt, 1);
        }
        else {
            part_emitter_region(ps, pe, x+16, x+16, y, y+24, ps_shape_rectangle, ps_distr_linear);
            part_emitter_burst(ps, pe, pt, 1);
        }
    }
}

// Parar aceleração
if(move == 0){
    moveAcc *= 0.1;
    if(ground && !wall && !attack){
       sprite_index = spr_ninja_idle; 
    }
} else {
    if(ground && !wall && !attack){
        sprite_index = spr_ninja_walk;
    }
}

// Walljumps
//if(move > 0){
    if (place_meeting(x+1, y, obj_ground) && !ground){
        wall = true;
        vspd *= 0.7;
        if(keyDown){
            wall = false;
            move = -1;
        }
        if(keyJumpPressed){
            if(wall){
                yscale = 1.33;
                xscale = 0.67;
            }
            vspd = -jumpForce;
            move = -4;
            wall = false;
        }
    } /*else {
        wall = false;
    }*/
//}
//else if(move < 0){
    else if(place_meeting(x-1, y, obj_ground) && !ground){
        wall = true;
        vspd *= 0.7;
        if(keyDown){
            wall = false;
            move = 1;
        }
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
/*}
else {
    wall = false;
}*/

if(wall)
    sprite_index = spr_ninja_wall;
    
dashCoolDown -= 0.1;
if(dashCoolDown <= 0 && (ground || wall)){
    dashSpeed = 0;
} 
if(keyDash && dashCoolDown <= 0){
    if(dashSpeed <= 0 && !ground){
        vspd = -jumpForce/2;
    }
    dashSpeed = dashMaxSpeed;
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
    knock = 0;
    moveAcc = 0;
}

if(damage){
    moveAcc = knock;
    sprite_index = spr_ninja_damage;
}

x += moveAcc;

// Colisão Vertical
if(place_meeting(x, y + vspd, obj_ground)){
    // Tentativa de animação dinâmica
    //if(!ground){
        if(vspd >= 15){
            xscale = 1.33;
            yscale = 0.67;
        }
        if(vspd >= 0){
            part_emitter_region(ps, pe, x-16, x+16, y+40, y+40, ps_shape_rectangle, ps_distr_linear);
            part_emitter_burst(ps, pe, pt, 10);
        }
        
    //}
    while(!place_meeting(x, y + sign(vspd), obj_ground)){
        y += sign(vspd);
    }
    ground = true;
    vspd = 0;
}

if(keyLeft && move > 0)
    move = 0;
if(keyRight && move < 0)
    move = 0;


y += vspd;
