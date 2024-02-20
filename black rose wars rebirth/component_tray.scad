$fn = 200;

bx = 298;
by = 298;
bz = 57;
cy = 242.624;
w = 2;
b = 1.2;

module tray_left() {
    xo = 97;
    x = bx/2;
    z = bz/2;
    y = by-cy;
    yo = y+29;
    difference() {
        union() {
            cube_rounded(v = [x,y,z]);
            translate(v = [xo,0,0]) cube_rounded(v = [x-xo,yo,z]);
        }
        tx = (x-w)/4 - w;
        for(i = [0:3]) {
            translate(v = [(i+1)*w+i*tx,w,b]) tray_rounded(v = [tx,y-2*w,z], r=6);
        }
        r = 40;
        translate(v = [x-3,y+r,0]) cylinder(h=z,r=r);
        translate(v = [x-3,y,0]) cube([10,29,z]);
        translate(v = [x-3,y-3,0]) difference() {
            cube([3,3,z]);
            cylinder(h = z, r = 3);
        }
    }
}

zrt=40;
module tray_right_bottom() {
    xo = 95;
    x = bx/2;
    z = bz-zrt;
    y = by-cy;
    yo = y+29;
    difference() {
        union() {
            cube_rounded(v = [x,y,z]);
            cube_rounded(v = [x-xo,yo,z]);
        }
        tx = (x-w)/2 - w;
        for(i = [0:1]) {
            translate(v = [(i+1)*w+i*tx,w,b]) tray_rounded(v = [tx,y-2*w,z], r=6);
        }
        r = 40;
        translate(v = [3,y+r,0]) cylinder(h=z,r=r);
        translate(v = [-10+3,y,0]) cube([10,29,z]);
        translate(v = [0,y-3,0]) difference() {
            cube([3,3,z]);
            translate(v = [3,0,0]) cylinder(h = z, r = 3);
        }
    }
}
module tray_right_top() {
    xo = 95;
    x = bx/2;
    z = zrt;
    y = by-cy;
    yo = y+29;
    difference() {
        union() {
            cube_rounded(v = [x,y,z]);
            cube_rounded(v = [x-xo,yo,z]);
        }
        r = 40;
        translate(v = [3,y+r,0]) cylinder(h=z,r=r);
        translate(v = [-10+3,y,0]) cube([10,29,z]);
        translate(v = [0,y-3,0]) difference() {
            cube([3,3,z]);
            translate(v = [3,0,0]) cylinder(h = z, r = 3);
        }
        mt = 25;
        translate(v = [w,w,z/2]) tray_rounded(v = [mt,y-2*w,z], r=6);
        translate(v = [x-mt-w,w,z/2]) tray_rounded(v = [mt,y-2*w,z], r=6);
        translate(v = [w+mt+w,w,20]) cube_rounded(v=[x-4*w-mt-mt,y-2*w,z], r=6);
        ct = 9;
        ctx = x-4*w-mt-mt-40;
        translate(v = [w+mt+w+40+ctx/2-ct/2,y/2-ct/2+10,20-4]) cube(ct);
        translate(v = [w+mt+w+40+ctx/2-ct/2+10,y/2-ct/2-10,20-4]) cube(ct);
        translate(v = [w+mt+w+40+ctx/2-ct/2-10,y/2-ct/2-10,20-4]) cube(ct);
        translate(v = [w+mt+w,w,7]) cube_rounded(v=[40,y-2*w,z], r=6);
        translate(v = [w+mt+w+40/2,y/2,2]) cylinder(h=20,r=28/2);
    }
}

translate([-bx/2,0,0]) tray_left();
translate([-bx/2,0,bz/2]) tray_left();
tray_right_bottom();
translate(v = [0,0,bz-zrt]) tray_right_top();




module cube_rounded(v, r=3, center=false){
    translate(center==true ? [r-v[0]/2,r-v[1]/2,v[2]/2] : [r,r,0])
    hull(){
        cylinder(h = v[2], r = r);
        translate(v = [0,v[1]-2*r,0]) cylinder(h = v[2], r = r);
        translate(v = [v[0]-2*r,v[1]-2*r,0]) cylinder(h = v[2], r = r);
        translate(v = [v[0]-2*r,0,0]) cylinder(h = v[2], r = r);
    }
}
module tray_rounded(v, r=3, center=false){
    translate(center==true ? [r-v[0]/2,r-v[1]/2,v[2]/2] : [r,r,0])
    translate(v = [0,0,r]) hull(){
        cylinder(h = v[2]-r, r = r);
        sphere(r = r);
        translate(v = [0,v[1]-2*r,0]) cylinder(h = v[2]-r, r = r);
        translate(v = [0,v[1]-2*r,0]) sphere(r = r);
        translate(v = [v[0]-2*r,v[1]-2*r,0]) cylinder(h = v[2]-r, r = r);
        translate(v = [v[0]-2*r,v[1]-2*r,0]) sphere(r = r);
        translate(v = [v[0]-2*r,0,0]) cylinder(h = v[2]-r, r = r);
        translate(v = [v[0]-2*r,0,0]) sphere(r = r);
    }
}