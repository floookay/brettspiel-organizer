include <config.scad>

$fn=200;

y_attacker = 130;
y_defender = box - y_attacker - 1;
w = 3.2;    // wall
b = 2;  // bottom
z = b + operator_h;
rl = 6;
c = 0.5;
or = operator_rn + c;
zl = 3.6;


module attacker() {
    difference() {
        cube_rounded(v=[box,y_attacker,z], r=rl);
        translate(v = [w,w,b+5]) cube_rounded(v=[box-2*w,y_attacker-2*w,z], r=rl-w);
        for (j = [0:1]) {
            for (i = [0:3]) {
                translate(v = [w+c+or,w+c+or,b]) translate(v = [j*2*operator_r,i*2*operator_r,0]) cylinder(h=operator_h, r=or);
            }
        }
        for (j = [0:4]) {
            for (i = [0:3]) {
                translate(v = [box/2-(4*2*operator_r)/2,w+c+or,b]) translate(v = [j*2*operator_r,i*2*operator_r,0]) cylinder(h=operator_h, r=or);
            }
        }
        for (j = [0:1]) {
            for (i = [0:3]) {
                translate(v = [box-(w+c+or)-2*operator_r,w+c+or,b]) translate(v = [j*2*operator_r,i*2*operator_r,0]) cylinder(h=operator_h, r=or);
            }
        }
    }
    attacker_grips();
}
module attacker_column() {
    for (i = [0:3]) {
        translate(v = [w+c+or+30,w+c+or,b]) translate(v = [j*2*operator_r,i*2*operator_r,0]) cylinder(h=operator_h, r=or);
    }
}
module attacker_grip(l=0) {
    hull() {
        cube([w+l,y_attacker,20]);
        translate(v = [0,(y_attacker)/2,b+operator_h+l])
        rotate(a=[0,90,0])
        cylinder(h = w+l, r = 20+l);
    }
}
module attacker_grips(l=0) {
    translate(v = [-4+w+c+or+operator_r*3.5-l/2,0,0]) attacker_grip(l);
    translate(v = [box-(-4+w+c+or+operator_r*3.5)-3-l/2,0,0]) attacker_grip(l);
}
module attacker_lid() {
    translate(v = [0,0,z])
    difference() {
        cube_rounded(v=[box,y_attacker,zl], r=rl);
        translate(v = [0,0,-z]) attacker_grips(0.5);
        for (j = [0:1]) {
            for (i = [0:3]) {
                translate(v = [w+c+or,w+c+or,zl-2]) translate(v = [j*2*operator_r,i*2*operator_r,0]) operator_token();
            }
            translate(v = [w+c+or+operator_r*2*j,w+c+or,zl-2]) translate(v = [-7.5,-10,0]) cube([15,y_attacker-20,10]);
        }
        for (j = [0:4]) {
            for (i = [0:3]) {
                translate(v = [box/2-(4*2*operator_r)/2,w+c+or,zl-2]) translate(v = [j*2*operator_r,i*2*operator_r,0]) operator_token();
            }
            translate(v = [box/2-(4*2*operator_r)/2+operator_r*2*j,w+c+or,zl-2]) translate(v = [-7.5,-10,0]) cube([15,y_attacker-20,10]);
        }
        for (j = [0:1]) {
            for (i = [0:3]) {
                translate(v = [box-(w+c+or)-2*operator_r,w+c+or,zl-2]) translate(v = [j*2*operator_r,i*2*operator_r,0]) operator_token();
            }
            translate(v = [box-(w+c+or)-operator_r*2*j,w+c+or,zl-2]) translate(v = [-7.5,-10,0]) cube([15,y_attacker-20,10]);
        }
    }
}
module operator_token() {
    t = 23.4;
    r = 3;
    translate(v = [-t/2,-t/2,0]) union() {
        cube([t,t,10]);
        translate(v = [r,r,-10]) cube([t-2*r,t-2*r,20]);
    }
}

// attacker();
// attacker_lid();

// intersection() {
//     cube([box/2,200,100]);
//     // attacker();
//     attacker_lid();
// }


module defender() {
    difference() {
        cube_rounded(v=[box,y_defender,z], r=rl);
        translate(v = [w,w,b+5]) cube_rounded(v=[box-2*w,y_attacker-2*w,z], r=rl-w);
        translate(v = [w,w,40]) cube_rounded(v=[box-2*w,y_defender-2*w,z], r=rl-w);
        for (j = [0:1]) {
            for (i = [0:3]) {
                translate(v = [w+c+or,w+c+or,b]) translate(v = [j*2*operator_r,i*2*operator_r,0]) cylinder(h=operator_h, r=or);
            }
            translate(v = [j*2*operator_r+w+or,or+y_attacker,b+30]) defender_token();
        }
        for (j = [0:4]) {
            for (i = [0:3]) {
                translate(v = [box/2-(4*2*operator_r)/2,w+c+or,b]) translate(v = [j*2*operator_r,i*2*operator_r,0]) cylinder(h=operator_h, r=or);
            }
            translate(v = [j*2*operator_r+box/2-(4*2*operator_r)/2,or+y_attacker,b+30]) defender_token();
        }
        for (j = [0:1]) {
            for (i = [0:3]) {
                translate(v = [box-(w+c+or)-2*operator_r,w+c+or,b]) translate(v = [j*2*operator_r,i*2*operator_r,0]) cylinder(h=operator_h, r=or);
            }
            translate(v = [box-(w+c+or)-2*operator_r+j*2*operator_r,or+y_attacker,b+30]) defender_token();
        }
        translate(v = [20,0,0]) 
        translate(v = [0,y_defender-25,0]) rotate(a = -45, v = [1,0,0]) cube([box/2-20,100,100]);
        translate(v = [box/2,0,0]) 
        translate(v = [0,y_defender-25,0]) rotate(a = -45, v = [1,0,0]) cube([box/2-20,100,100]);
    }
    attacker_grips();
}
module defender_token() {
    rotate(a = 90, v = [0,1,0]) hull() {
        cylinder(h = 2*10, r = (28+1)/2, center=true);
        translate(v = [-100,0,0]) cylinder(h = 2*10, r = (28+1)/2, center=true);
    }
    // cube([10*2,31,20], center=true);
}
module defender_column() {
    for (i = [0:3]) {
        translate(v = [w+c+or,w+c+or,b]) translate(v = [j*2*operator_r,i*2*operator_r,0]) cylinder(h=operator_h, r=or);
    }
}
module defender_lid() {
    translate(v = [0,0,z])
    difference() {
        cube_rounded(v=[box,y_defender,zl], r=rl);
        translate(v = [0,0,-z]) attacker_grips(0.5);
        for (j = [0:1]) {
            for (i = [0:3]) {
                translate(v = [w+c+or,w+c+or,zl-2]) translate(v = [j*2*operator_r,i*2*operator_r,0]) operator_token();
            }
            translate(v = [w+c+or+operator_r*2*j,w+c+or,zl-2]) translate(v = [-7.5,-10,0]) cube([15,y_defender-60,10]);
        }
        for (j = [0:4]) {
            for (i = [0:3]) {
                translate(v = [box/2-(4*2*operator_r)/2,w+c+or,zl-2]) translate(v = [j*2*operator_r,i*2*operator_r,0]) operator_token();
            }
            translate(v = [box/2-(4*2*operator_r)/2+operator_r*2*j,w+c+or,zl-2]) translate(v = [-7.5,-10,0]) cube([15,y_defender-60,10]);
        }
        for (j = [0:1]) {
            for (i = [0:3]) {
                translate(v = [box-(w+c+or)-2*operator_r,w+c+or,zl-2]) translate(v = [j*2*operator_r,i*2*operator_r,0]) operator_token();
            }
            translate(v = [box-(w+c+or)-operator_r*2*j,w+c+or,zl-2]) translate(v = [-7.5,-10,0]) cube([15,y_defender-60,10]);
        }
    }
}
// translate(v = [0,y_attacker,0]) defender();
// translate(v = [0,y_attacker,0]) defender_lid();

// intersection() {
//     // translate(v = [box/2,0,0])
//     cube([box/2,200,100]);
//     defender();
//     // defender_lid();
// }

module blocker() {
    z = 1.8;
    t = 23.4 - 0.5;
    r = 3;
    union() {
        translate(v = [0,0,z/2])cube([t,t,z], center=true);
        translate(v = [0,0,-z/2]) cube([t-2*r+0.5,t-2*r+0.5,z], center=true);
    }
}
blocker();