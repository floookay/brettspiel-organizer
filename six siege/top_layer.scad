include <config.scad>

$fn=200;

b = 2;
z = b + 22;
w = 3.2;
rl = 6;

xf = 20;
yf = 3;

r_grab = 18.6;


module two_standees(height_standee_plus=26, width_standee_plus=26.5, border_mode=false) {
    r0 = 0.5;
    b = 2;
    r = border_mode ? r0+b : r0;
    xo = border_mode ? (width_standee_plus-xf)/2-b : (width_standee_plus-xf)/2;
    yo = border_mode ? -b : 0;
    x = border_mode ? xf + 2*b : xf;
    y = border_mode ? yf + 2*b : yf;
    z = border_mode ? 4 : 30;
    translate(v = [xo,yo,0]) union() {
        cube_rounded(v = [x, y, z], r=r);
        translate(v = [0,height_standee_plus,0]) cube_rounded(v = [x, y, z], r=r);
    }
    // union() {
    //     cube([x,2.5,30]);
    //     translate(v = [0,0,3]) rotate(a = 20, v = [1,0,0]) cube([x,15,10]);
    // }
}

x_b = 106;  // slightly shorter 0.4mm
module breach_standees() {
    bo=4;
    pairs = 4;
    x1u = 31;
    y1u = 32;
    x2u = 61;
    y2u = y1u;

    m = 2;
    x = w+m+x1u+m+m+x2u+m+w; // x_b
    echo(x);
    y = w+m+pairs*(y1u+yf+m)+w;
    // echo(y);

    difference() {
        union() {
            difference() {
                cube_rounded(v=[x,y,z], r=rl);
                translate(v = [w,w,b]) cube_rounded(v=[x-2*w,y-2*w,z], r=rl-w);
            }
            // 1u breach
            for (i = [0:pairs-1]) {
                translate(v = [0,i*(y1u+yf+m),0])
                translate(v = [w+m,w+m,b])
                two_standees(height_standee_plus=y1u, width_standee_plus=x1u,border_mode=true);
            }
            // 2u breach
            for (i = [0:pairs-1]) {
                translate(v = [x1u+m+m,0,0]) 
                translate(v = [0,i*(y2u+yf+m),0])
                translate(v = [w+m,w+m,b])
                two_standees(height_standee_plus=y2u, width_standee_plus=x2u,border_mode=true);
            }
        }

        // 1u breach
        for (i = [0:pairs-1]) {
            translate(v = [0,i*(y1u+yf+m),0])
            translate(v = [w+m,w+m,b])
            two_standees(height_standee_plus=y1u, width_standee_plus=x1u);
        }
        // 2u breach
        for (i = [0:pairs-1]) {
            translate(v = [x1u+m+m,0,0]) 
            translate(v = [0,i*(y2u+yf+m),0])
            translate(v = [w+m,w+m,b])
            two_standees(height_standee_plus=y2u, width_standee_plus=x2u);
        }
    }
}
// translate(v = [x_rs,0,0]) breach_standees();

x_rs = box-x_b;
y_rs = 127;
module reinforcement_standees() {
    y = y_rs;
    x1u = 28;
    y1u = 31.8;
    x2u = 53;
    y2u = 51;
    m = 2;
    union() {
        difference() {
            cube_rounded(v=[x_rs,y,z], r=rl);
            translate(v = [w,w,b]) cube_rounded(v=[x_rs-2*w,y-2*w,z], r=rl-w);
        }
        
        // 6 1x2 reinforcement
        difference() {
            for (i = [0:2]) {
                translate(v = [i*(x1u+m),0,0])
                translate(v = [w+m,w+m,b])
                two_standees(height_standee_plus=y2u, width_standee_plus=x1u,border_mode=true);
            }
            for (i = [0:2]) {
                translate(v = [i*(x1u+m),0,0])
                translate(v = [w+m,w+m,b])
                two_standees(height_standee_plus=y2u, width_standee_plus=x1u,border_mode=false);
            }
        }
        translate(v = [0,y,0]) rotate(a = -90, v = [0,0,1])
        union() {
            // 8 1x1 reinforcements
            difference() {
                for (i = [0:1]) {
                    translate(v = [i*(x1u+m),0,0])
                    translate(v = [w+m,w+m,b])
                    two_standees(height_standee_plus=y1u, width_standee_plus=x1u,border_mode=true);
                }
                for (i = [0:1]) {
                    translate(v = [i*(x1u+m),0,0])
                    translate(v = [w+m,w+m,b])
                    two_standees(height_standee_plus=y1u, width_standee_plus=x1u,border_mode=false);
                }
            }
            y_8_1x1 = y1u + yf + m;
            difference() {
                for (i = [0:1]) {
                    translate(v = [i*(x1u+m),y_8_1x1,0])
                    translate(v = [w+m,w+m,b])
                    two_standees(height_standee_plus=y1u, width_standee_plus=x1u,border_mode=true);
                }
                for (i = [0:1]) {
                    translate(v = [i*(x1u+m),y_8_1x1,0])
                    translate(v = [w+m,w+m,b])
                    two_standees(height_standee_plus=y1u, width_standee_plus=x1u,border_mode=false);
                }
            }
            // 2 1x2 reinforcement + 2 1x1 reinforcement
            translate(v = [0,y_8_1x1*2,0]) difference() {
                for (i = [0:1]) {
                    translate(v = [i*(x1u+m),0,0])
                    translate(v = [w+m,w+m,b])
                    if(i==0) {
                        // 2x1
                        two_standees(height_standee_plus=y2u, width_standee_plus=x1u,border_mode=true);
                    } else {
                        // 1x1
                        two_standees(height_standee_plus=y1u, width_standee_plus=x1u,border_mode=true);
                    }
                }
                for (i = [0:1]) {
                    translate(v = [i*(x1u+m),0,0])
                    translate(v = [w+m,w+m,b])
                    if(i==0) {
                        // 2x1
                        two_standees(height_standee_plus=y2u, width_standee_plus=x1u,border_mode=false);
                    } else {
                        // 1x1
                        two_standees(height_standee_plus=y1u, width_standee_plus=x1u,border_mode=false);
                    }
                }
            }
            // 4 2x2 reinforcement
            translate(v = [(y-2*(w+x2u+m))/2,y_8_1x1*2+y2u + yf + m,0]) difference() {
                for (i = [0:1]) {
                    translate(v = [i*(x2u+m),0,0])
                    translate(v = [w+m,w+m,b])
                    two_standees(height_standee_plus=y2u, width_standee_plus=x2u,border_mode=true);
                }
                for (i = [0:1]) {
                    translate(v = [i*(x2u+m),0,0])
                    translate(v = [w+m,w+m,b])
                    two_standees(height_standee_plus=y2u, width_standee_plus=x2u,border_mode=false);
                }
            }
            // 2 2x1 reinforcment
            translate(v = [y-x2u-10.5,y_8_1x1*2+y2u-y1u,0]) difference() {
                translate(v = [w+m,w+m,b])
                two_standees(height_standee_plus=y1u, width_standee_plus=x2u,border_mode=true);

                translate(v = [w+m,w+m,b])
                two_standees(height_standee_plus=y1u, width_standee_plus=x2u,border_mode=false);
            }
            
        }
    }
}
// reinforcement_standees();

module defender_operators() {
    x = x_rs;
    y = box-y_rs;
    x_sfo = 35;
    x_lfo = 55;
    y_lfo = y-w-x_sfo-w-w;
    y2u = 51;
    union() {
        difference() {
            cube_rounded(v=[x,y,z], r=rl);
            // small figures
            y_sf = 140;
            translate(v = [w,w,b]) difference() {
                translate(v = [0,0,0]) cube_rounded(v=[y_sf,x_sfo,z], r=rl-w);
                translate(v = [3,3,0]) cube_rounded(v=[y_sf-2*3,x_sfo-2*3,6], r=1);
            }
            // large figures
            translate(v = [w,w+x_sfo+w,b]) union() {
                difference() {
                    translate(v = [0,0,0]) cube_rounded(v=[x_lfo,y_lfo,z], r=rl-w);
                    translate(v = [3,3,0]) cube_rounded(v=[x_lfo-2*3,y_lfo-2*3,6], r=1);
                }
            }
            // castle standees
            y_cs = y2u+3+2+2;
            translate(v = [w+x_lfo+w,w+x_sfo+w,b]) cube_rounded(v=[y_sf-w-x_lfo,y_cs,z], r=rl-w);
            // shield standees
            x_s=x-w-y_sf-w-w;    // 40;
            translate(v = [w+y_sf+w,w,b]) tray_rounded([x_s,x_s,z],r=rl-w);
            // wall reinforcements and holes
            // echo((x_s-w)/2);
            // echo(y_lfo-2*w-w-x_s);
            translate(v = [w+y_sf+w,w+x_s+w,16]) tray_rounded([(x_s-w)/2,y_lfo-2*w-w-x_s,z],r=rl-w);
            translate(v = [w+y_sf+w+w+(x_s-w)/2,w+x_s+w,18]) tray_rounded([(x_s-w)/2,y_lfo-2*w-w-x_s,z],r=rl-w);

            // special gadgets
            x_wsg = 9+32+9;
            x_osg1 = y-x_wsg+9+9;
            x_osg2 = x_osg1-w-x_wsg;
            y_osg = y-w-32;
            translate(v = [x_osg1,y_osg,z-5]) union() {
                translate(v = [9,32/2,5]) sphere(r = 9);
                translate(v = [9,0,0]) cube_rounded(v = [32,32,z], r=1);
                translate(v = [9+32,32/2,5]) sphere(r = 9);
            }
            translate(v = [x_osg2,y_osg,z-5]) union() {
                translate(v = [9,32/2,5]) sphere(r = 9);
                translate(v = [9,0,0]) cube_rounded(v = [32,32,z], r=1);
                translate(v = [9+32,32/2,5]) sphere(r = 9);
            }
            translate(v = [w+x_lfo+w+20/2+0.5+1,w+x_sfo+w+y_cs+54,z])
            translate(v=[0,0,-2-3]) difference() {
                cylinder(h = 6, r = 20/2+0.5);
                difference() {
                    cylinder(h = 2, r = 20/2+0.5-3);
                    translate(v = [-20,5,0]) cube([40,20,20]);
                }
            }
            x_rook = 23;
            translate(v = [w+x_lfo+w+x_rook/2,w+x_sfo+w+y_cs+23.5+2,z])
            translate(v=[0,0,-7]) union() {
                hull() {
                    translate(v = [-x_rook/2,0,0]) cube([x_rook,8,20]);
                    translate(v = [0,-3,0]) difference() {
                        cylinder(h=20, r=x_rook/2);
                        translate(v = [-x_rook/2,0,0]) cube([x_rook,x_rook,20]);
                    }
                    translate(v = [0,-25+1+8,0]) cylinder(h=20, r=1);
                }
                translate(v = [-x_rook/2,0,-2]) cube([x_rook,8,2]);
            }
            // grab hole
            translate(v = [114,118.6,-1]) difference() {
                union() {
                    cylinder(h = z+2, r = r_grab-3);
                    translate(v = [w,0,0]) cylinder(h = z+2, r = r_grab-3);
                }
                translate(v = [0,-20,0]) cube([w,40,z+2]);
            }
        }
        // castle standees
        x1u = 28;
        y1u = 31.8;
        x2u = 53;
        y2u = 51;
        m = 2;
        translate(v = [w+x_lfo+w,w+x_sfo+w,0])
        union() {
            translate(v = [0,2,b]) difference() {
                two_standees(height_standee_plus=y2u, width_standee_plus=x2u,border_mode=true);
                two_standees(height_standee_plus=y2u, width_standee_plus=x2u,border_mode=false);
            }
            translate(v = [x2u,2,b]) difference() {
                two_standees(height_standee_plus=y2u, width_standee_plus=x1u,border_mode=true);
                two_standees(height_standee_plus=y2u, width_standee_plus=x1u,border_mode=false);
            }
        }
    }
}
// translate(v = [0,y_rs,0]) defender_operators();

y_b=156;    // slightly shorter 0.4mm
module attacker_operators() {
    x = x_b;
    y = box-y_b-1;
    x_lfo = 55;
    y_lfo = 45;
    x_gs = 33;
    y_gs = x-w-x_lfo-w-2*2;
    difference() {
        cube_rounded(v=[x,y,z], r=rl);
        // translate(v = [w,w,b]) cube_rounded(v=[x-2*w,y-2*w,z], r=rl-w);
        translate(v = [w,w,b]) union() {
            difference() {
                translate(v = [0,0,0]) cube_rounded(v=[x_lfo,y_lfo,z], r=rl-w);
                translate(v = [3,3,0]) cube_rounded(v=[x_lfo-2*3,y_lfo-2*3,6], r=1);
            }
        }
        // special gadgets
        x_wsg = 32;
        x_osg1 = w;
        x_osg2 = x_osg1+w+x_wsg;
        x_osg3 = x_osg2+w+x_wsg;
        y_osg1 = y-w-32-9;
        y_osg2 = w+y_lfo+w+9;
        translate(v = [x_osg1,y_osg1,z-5]) union() {
            translate(v = [32/2,32,5]) sphere(r = 9);
            translate(v = [0,0,0]) cube_rounded(v = [32,32,z], r=1);
            translate(v = [32/2,0,5]) sphere(r = 9);
        }
        translate(v = [x_osg2,y_osg1,z-5]) union() {
            translate(v = [32/2,32,5]) sphere(r = 9);
            translate(v = [0,0,0]) cube_rounded(v = [32,32,z], r=1);
            translate(v = [32/2,0,5]) sphere(r = 9);
        }
        translate(v = [x_osg1,y_osg2,z-5]) union() {
            translate(v = [32/2,32,5]) sphere(r = 9);
            translate(v = [0,0,0]) cube_rounded(v = [32,32,z], r=1);
            translate(v = [32/2,0,5]) sphere(r = 9);
        }
        hull() {
            translate(v = [x_osg1,y_osg1,z-5]) translate(v = [32/2,0,5]) sphere(r = 9);
            translate(v = [x_osg1,y_osg2,z-5]) translate(v = [32/2,32,5]) sphere(r = 9);
        }
        // round special tokens
        y_st = 53;
        xo_st = -20;
        translate(v=[x-w-x_hw-w-20/2-0.5,80,z-2-3]) difference() {
            cylinder(h = 6, r = 20/2+0.5);
            difference() {
                cylinder(h = 2, r = 20/2+0.5-3);
                translate(v = [-20,5,0]) cube([40,20,20]);
            }
        }
        translate(v=[w+32+w+(20/2+0.5),w+y_lfo+w+(20/2+0.5),z-2-3]) difference() {
            cylinder(h = 6, r = 20/2+0.5);
            difference() {
                cylinder(h = 2, r = 20/2+0.5-3);
                translate(v = [-20,5,0]) cube([40,20,20]);
            }
        }
        // holed walls
        x_hw = 20.6;
        y_hw = 74.4;
        translate(v = [x-w-x_hw,y-w-y_hw,16]) tray_rounded([x_hw,y_hw,z],r=rl-w);
        // gravel standees
        translate(v = [w+x_lfo+w,w,b]) cube_rounded(v = [x-w-x_lfo-w-w,x_gs,z], r=rl-w);
        // grab hole
        translate(v = [w+x_lfo+w+y_gs/2,w+x_gs+w,-1]) difference() {
            cylinder(h = z+2, r = r_grab);
            translate(v = [-20,-40,0]) cube([40,40,z+2]);
        }
    }
    // gravel standees
    translate(v = [w+x_lfo+w+2,x_gs+w,b]) rotate(a = -90, v = [0,0,1]) difference() {
        two_standees(height_standee_plus=y_gs-2*2-2, width_standee_plus=x_gs,border_mode=true);
        two_standees(height_standee_plus=y_gs-2*2-2, width_standee_plus=x_gs,border_mode=false);
    }
}
translate(v = [x_rs,y_b,0]) attacker_operators();