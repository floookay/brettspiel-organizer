$fn = 200;

deckel_x=445;
deckel_z=316;

tray_y=45;
trayslot_b=6;
trayslot_x=deckel_x/2;

minitray_x=trayslot_x-trayslot_b;
minitray_z=4;

magnet_z=5;

// minitray(left=false);
doublerail();

module minitray(a=6,left=true) {
    o=2;
    difference() {
        union() {
            cube_rounded([minitray_x,tray_y,minitray_z]);
            translate(v = [trayslot_b/2+o,0,0]) cube_rounded([minitray_x-trayslot_b-o*2,4,minitray_z+4]);
        }
        d=(minitray_x-trayslot_b-o*2)/a;
        for (i=[1:a]) {
            translate(v = [trayslot_b/2+o+(i-0.5)*d,25,minitray_z-2]) rotate([0,0,180]) slot();
        }
        if(!left)
        {
            cube([trayslot_b/2+o/2,11,10]);
        }
        else {
            translate(v = [minitray_x-(trayslot_b/2+o/2),0,0]) cube([trayslot_b/2+o/2,11,10]);
        }
    }
}

module rail() {
    difference() {
        // cube([trayslot_b,tray_y,deckel_z]);
        translate(v = [trayslot_b,0,0]) rotate([0,-90,0]) cube_rounded([deckel_z,tray_y,trayslot_b]);
        d=(deckel_z)/5.3;
        for (i=[0:4]) {
            translate(v = [trayslot_b/2,-1,i*d]) cube([10,tray_y+2,minitray_z+0.4]);
        }
    }
}
module doublerail() {
    difference() {
        union() {
            rail();
            mirror([1,0,0]) rail();
            translate(v = [trayslot_b,-10,0]) rotate([0,-90,0]) cube_rounded([deckel_z,10,2*trayslot_b]);
        }
        translate(v = [-20,-1,-1]) cube([40,11,deckel_z+2]);
        d=(deckel_z)/5.3;
        for (i=[0:4]) {
            translate(v = [-10,-2,i*d+30]) cube([20,11+2,magnet_z]);
        }
    }
}



module slot() {
    r1=30/2;
    a=76;
    h=2;
    r2=r1 - h/tan(a);
    hull() {
        cylinder(h=h, r1=r1, r2=r2);
        translate(v = [0,-30,0]) cylinder(h=h, r1=r1, r2=r2);
    }
    hull() {
        cylinder(h=10, r=r2);
        translate(v = [0,-30,0]) cylinder(h=10, r=r2);
    }
}
module tester() {
    difference() {
        translate([-20,-20,-0.6]) cube_rounded([40,40,4]);
        slot();
    }
}



module cube_rounded(v, r=1, center=false, rc=0){
    translate(center==true ? [r-v[0]/2,r-v[1]/2,-v[2]/2+rc] : [r,r,rc])
    union(){
        cylinder(h = v[2]-rc, r = r);
        translate(v = [0,v[1]-2*r,0]) cylinder(h = v[2]-rc, r = r);
        translate(v = [v[0]-2*r,v[1]-2*r,0]) cylinder(h = v[2]-rc, r = r);
        translate(v = [v[0]-2*r,0,0]) cylinder(h = v[2]-rc, r = r);
        translate(v = [-r,0,0]) cube([v[0],v[1]-2*r,v[2]-rc]);
        translate(v = [0,-r,0]) cube([v[0]-2*r,v[1],v[2]-rc]);
        if(rc > 0)
        {
            translate(v = [0,0,-rc]) hull() {
                cylinder(h = rc, r2 = r, r1 = r-rc);
                translate(v = [0,v[1]-2*r,0]) cylinder(h = rc, r2 = r, r1 = r-rc);
                translate(v = [v[0]-2*r,v[1]-2*r,0]) cylinder(h = rc, r2 = r, r1 = r-rc);
                translate(v = [v[0]-2*r,0,0]) cylinder(h = rc, r2 = r, r1 = r-rc);
            }
        }
    }
}