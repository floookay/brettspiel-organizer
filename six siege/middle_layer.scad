include <config.scad>

$fn=20; // increase for rendering

z = b + 50 + 2;
rl = 6;
c = 0.5;
or = operator_rn + c;
zl = 3.6;

operator_profiles();
translate(v = [x_op,box-y_pt,0]) player_tray();
translate(v = [x_op,0,0]) setup_defender();
translate(v = [-xl,0,0]) mission_prep();
translate(v = [-xl,0,z_mp]) general_prep();
translate(v = [-xl,y_mp,0]) smoke_gas_fire_standees();

// intersection() {
//     translate(v = [0,box/2,0])
//     cube([200,box/2,100]);
//     operator_profiles();
// }
// translate(v = [x_op,box-y_pt,0]) cube_rounded(v=[xr,y_pt,z/2], r=rl);    // player tray dummy cube

x_op = w+120+1+w;
module operator_profiles() {
    y = 90*3 + 1;
    difference() {
        cube_rounded(v=[x_op,box,z], r=rl);
        translate(v = [w,(box-y)/2,b]) cube([x_op-2*w,y,z]);
        // liner cutout
        translate(v = [w,-1,b+46]) cube([20.5,box+2,z]);
        // bottom holes
        translate(v = [w+120/2,(box-y)/2+90/2,-1]) cylinder(h = 2*b, r = 35);
        translate(v = [w+120/2,(box-y)/2+90/2+90+90+1,-1]) cylinder(h = 2*b, r = 35);
    }
}

xr = 228-x_op-0.5;
echo(xr);
xl = box-x_op-xr;
y_pt = w+140+w+10+w;   // w+y_lt+w+y_at+w
xro_grab = xr/2-2.5;
module player_tray() {
    difference() {
        cube_rounded(v=[xr,y_pt,z/2], r=rl);
        // bottom cutout
        x_bc = 156.9-x_op-0.5;
        translate(v = [x_bc,y_pt-80-54,-1]) cube([3.2+1,54,18]);
        // activation token
        o_at = y_pt-10-w;
        translate(v = [w,o_at,b]) cube_rounded([xr-2*w,10,30], r=2);
        translate(v = [(xr-25)/2,o_at,-1]) cube([25,20,30]);
        // leaning token
        x_lt = 28;
        y_lt = 140;
        translate(v = [xr-w-x_lt,o_at-y_lt-w,b]) union() {
            translate(v = [0,0,8]) cube([x_lt,y_lt,30]);
            for (i = [0:4]) {
                translate(v = [0,i*(y_lt/5),0]) union() {
                    cube([x_lt,2.5,30]);
                    translate(v = [0,0,3]) rotate(a = 20, v = [1,0,0]) cube([x_lt,15,10]);
                }
            }
        }
        // damage token
        y_dt = 62;
        translate(v = [w,o_at-y_dt-w,b]) tray_rounded(v = [xr-3*w-x_lt,y_dt,40], r=15);
        // overwatch token
        y_ot = y_pt-(w+y_dt+w+10+w)-w;
        translate(v = [w,w,10]) tray_rounded(v=[x_bc-w-w,y_ot,30], r=5);
        // stunned/located token
        x_st = 29.3;
        y_st = 25;
        translate(v = [0,y_ot-(y_st*2+w),0]) union() {
            translate(v = [xr-x_lt-w-w-x_st,w,12]) tray_rounded(v=[x_st,y_st,30], r=5);
            translate(v = [xr-x_lt-w-w-x_st,w+y_st+w,12]) tray_rounded(v=[x_st,y_st,30], r=5);
            // reroll token slot
            translate(v = [x_bc,w+y_st+w/2,30]) rotate(a = 90, v = [0,1,0]) cylinder(h = 3.2+1, r = 38/2, $fn=6);
        }
        // grab
        translate(v = [xro_grab,w,-1]) cylinder(h = 100, r = r_grab);
    }
    // fix bottom side piece
    difference() {
        cube_rounded(v=[xr,y_pt,z/2], r=rl);
        translate(v = [-1,w,-1]) cube([xr+2,y_pt,z/2+2]);
    }
}

module setup_defender() {
    y = box-y_pt;
    difference() {
        union() {
            difference() {
                cube_rounded(v=[xr,y,z/2], r=rl);
                translate(v = [w,w,b]) cube_rounded([xr-2*w,y-2*w,z/2], r=rl-w);
                // grab
                translate(v = [xro_grab,y-w,-1]) cylinder(h = z/2+2, r = r_grab);
            }
            // grab
            translate(v = [xro_grab,y-w,0]) difference() {
                cylinder(h = z/2, r = r_grab+w);
                cylinder(h = z/2, r = r_grab);
                translate(v = [-r_grab-10,0,0]) cube([r_grab*2+20,r_grab+10,z/2]);
            }
            // fix top side piece
            difference() {
                cube_rounded(v=[xr,y,z/2], r=rl);
                translate(v = [-1,-w,-1]) cube([xr+2,y,z/2+2]);
            }
        }
        // bottom cutout
        x_bc = 156.9-x_op-0.5;
        translate(v = [x_bc,38,-1]) cube([3.2+1,54,16+1]);
    }
}

module setup_attacker() {
    setup_defender();
}

xlo_grab = xl/2;
y_mp = 163.5;
z_mp = 33;
module mission_prep() {
    difference() {
        cube_rounded(v=[xl,y_mp,z], r=rl);
        // translate(v = [-1,-1,z_mp]) cube([xl+2,y_mp-r_grab-w*2+2,z-z_mp+1]);
        translate(v = [0,0,z_mp]) cube_rounded([xl,y_mp-r_grab-w*2,z-z_mp+1], r=rl-1);
        // bottom cutout
        translate(v = [xl-3.2-1,38,-1]) cube([3.2+1+1,54,40]);
        // bombs
        translate(v = [w,w,b]) cube_rounded(v = [61.5,65,50], r=rl-w);
        // hostage
        translate(v = [w,w+65+w,b]) cube_rounded([32,39,50], r=rl-w);
        // round marker
        translate(v = [w+32+w,w+65+w+39-12,b]) cube_rounded([30,12,50], r=rl-w);
        translate(v = [w+32+w+(30-20.5)/2,w+65+w,b+12]) cube_rounded([20.5,39,50], r=rl-w);
        // control tokens
        translate(v = [w,w+65+w+39+w,b]) cube_rounded(v=[22,22,50], r=1);
        translate(v = [-1,w+65+w+39+w+22/2-15/2,-1]) cube_rounded([(22+w)/3*2+1,15,50], r=1);
        // action tokens
        translate(v = [w+22+w,w+65+w+39+w,b]) cube_rounded(v=[xl-(w+22+w)-w,22,50], r=1);
        // grab
        translate(v = [xlo_grab,y_mp-w,-1]) cylinder(h = 100, r = r_grab);
    }
    // fix top side piece
    difference() {
        cube_rounded(v=[xl,y_mp,z], r=rl);
        translate(v = [-1,-w,-1]) cube([xl+2,y_mp,z+2]);
    }
    // fixation
    translate(v = [w+32+w+0.8,w+65+w+1,z_mp]) cylinder(h = 3, r = 3.8);
}


module general_prep() {
    y = y_mp-r_grab-w*2;
    difference() {
        cube_rounded([xl,y,z-z_mp], r=rl);
        // !dice
        translate(v = [w,w,b]) hull() {
            cube_rounded(v = [xl-2*w,50,50], r=rl-w);
            translate(v = [0,50,0]) rotate(a = -40, v = [1,0,0]) translate(v = [0,-50,0]) cube_rounded(v = [xl-2*w,50,50], r=rl-w);
        }
        // charge cubes
        translate(v = [w,w+50+w+16,b]) tray_rounded([xl-2*w,y-(w+50+w+w+16),50], r=15);
        // fixation
        hull() {
            translate(v = [w+32+w+0.8,w+65+w+1,0]) cylinder(h = 4, r = 4);
            translate(v = [xl-(w+32+w+0.8),y-(w+65+w+1),0]) cylinder(h = 4, r = 4);
        }
    }
}

y_sgfs = box-y_mp;
module smoke_gas_fire_standees() {
    xsgfs = 70;
    difference() {
        union() {
            difference() {
                cube_rounded(v=[xl,y_sgfs,z], r=rl);
                // standees
                translate(v = [w,w,b]) cube_rounded([xl-w-w-(3.2+1+1),y_sgfs-2*w,z], r=rl-w);
                translate(v = [w,w+54+w,b]) cube_rounded([xl-w-w,y_sgfs-(w+54+w)-w,z], r=rl-w);
                translate(v = [w,w,16+1+w]) cube_rounded([xl-w-w,y_sgfs-(w+54+w)-w,z], r=rl-w);
                // translate(v = [xlo_grab-r_grab,w,-1]) cube_rounded([r_grab*2,y_sgfs-2*w,b+2], r=1);
                // grab
                translate(v = [xlo_grab,w,-1]) cylinder(h = z+2, r = r_grab);
            }
            // grab
            translate(v = [xlo_grab,w,0]) difference() {
                cylinder(h = z, r = r_grab+w);
                cylinder(h = z, r = r_grab);
                translate(v = [-r_grab-10,-r_grab-10,0]) cube([r_grab*2+20,r_grab+10,z]);
            }
            // fix bottom side piece
            difference() {
                cube_rounded(v=[xl,y_sgfs,z], r=rl);
                translate(v = [-1,w,-1]) cube([xl+2,y_sgfs,z+2]);
            }
        }
        // bottom cutout
        translate(v = [xl-3.2-1,0,-1]) cube([3.2+1+1,54+w,18]);
    }
}
