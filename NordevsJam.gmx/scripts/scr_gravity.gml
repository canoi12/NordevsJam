/// scr_gravity()

if(place_meeting(x, y + 1, obj_ground)){
    vspd = 0;
    ground = true;
}
// Gravidade 
else {
    ground = false;
    if(vspd < 20){
        vspd += grav;
    }
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
    if(vspd >= 15){
        xscale = 1.33;
        yscale = 0.67;
    }
    while(!place_meeting(x, y + sign(vspd), obj_ground)){
        y += sign(vspd);
    }
    ground = true;
    vspd = 0;
}

y += vspd;
