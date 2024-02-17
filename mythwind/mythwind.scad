$fn=200;

x=254-1;
y=227-1;
z=20;
b=0.6;
w=8;
r=2;

cy=88;
cx=58;
cw=1.6;

module cube_rounded(v, r=3, center=false){
    translate([r,r,0])
    minkowski(){
        cube([v[0]-(2*r), v[1]-(2*r), v[2]-r], center);
        cylinder(r,r,r);
    }
}

module cards() {
    difference() {
        cube_rounded(v = [x/2,w+cy+cw,z],r=r);
        translate(v = [cw,cw,b]) cube_rounded(v = [cx,cy,z],r=r);
        translate(v = [cw+cx+cw,cw,b]) cube_rounded(v = [cx,cy,z],r=r);
        translate(v = [cw+cx/2,0,0]) cylinder(h=z,r=20);
        translate(v = [cw+cx/2+cw+cx,0,0]) cylinder(h=z,r=20);
        translate(v = [cw+cx/2,w+cy+cw,0]) cylinder(h=z,r=20);
        translate(v = [cw+cx/2+cw+cx,w+cy+cw,0]) cylinder(h=z,r=20);
    }
}

c2y = y-(w+cy+cw);
c2x = w+cy+cw;
module cards2() {
    difference() {
        cube_rounded(v = [c2x,c2y,z],r=r);
        translate(v = [w,c2y-cw-cx,b]) cube_rounded(v = [cy,cx,z],r=r);
        translate(v = [w,c2y-cw-cx-cw-cx,b]) cube_rounded(v = [cy,cx,z],r=r);
        translate(v = [0,c2y-cw-cx/2,0]) cylinder(h=z,r=20);
        translate(v = [0,c2y-cw-cx/2-cw-cx,0]) cylinder(h=z,r=20);
        translate(v = [w+cy+cw,c2y-cw-cx/2,0]) cylinder(h=z,r=20);
        translate(v = [w+cy+cw,c2y-cw-cx/2-cw-cx,0]) cylinder(h=z,r=20);
        translate(v = [c2x-5,3.5,z-2]) rotate(a=90) cylinder(h=10, r=3, $fn=3);
        translate(v = [4,c2y-4,z-2]) rotate(a=90) cylinder(h=10, r=3, $fn=5);
    }
}

module minis() {
    leeway_x=1;
    difference() {
        cube_rounded(v = [x-c2x-leeway_x,c2y,z], r=r);
        translate(v = [cw,w,b]) cube_rounded(v = [x-c2x-cw-w,c2y-w-cw,z], r=r);
        translate(v = [cw,w,0]) cube_rounded(v = [x-c2x-cw-w,c2y-w-cw-40,z], r=r);
        translate(v = [5,3.5,z-2]) rotate(a=90) cylinder(h=10, r=3, $fn=3);
        translate(v = [x-c2x-4,c2y-4,z-2]) rotate(a=45) cylinder(h=10, r=3, $fn=4);
    }
}

module cards_small() {
    csw=7.6; // for stability
    xb=51;
    yb=51;
    xg=45;
    yg=68;
    xs=cw+yg+csw+xb+cw;
    ys=cw+yb+cw+yb+cw;
    zs=11.6;
    difference() {
        cube_rounded(v = [xs,ys,zs],r=r);
        translate(v = [xs-xb-cw,cw,b]) cube_rounded(v = [xb,yb,zs], r=r);
        translate(v = [xs-xb-cw,cw+yb+cw,b]) cube_rounded(v = [xb,yb,zs], r=r);
        translate(v = [cw,cw+yb+cw+(yb/2-xg/2),b]) cube_rounded(v = [yg,xg,zs], r=r);
        translate(v = [cw,cw+(yb/2-xg/2),b]) cube_rounded(v = [yg,xg,zs], r=r);

        translate(v = [xs,cw+yb/2,0]) cylinder(h=zs+1,r=20);
        translate(v = [xs,cw+yb+cw+yb/2,0]) cylinder(h=zs+1,r=20);
        translate(v = [0,cw+yb+cw+(yb/2-xg/2)+xg/2,0]) cylinder(h=zs+1,r=20);
        translate(v = [0,cw+(yb/2-xg/2)+xg/2,0]) cylinder(h=zs+1,r=20);
    }
}

// translate(v = [x/2,0,0]) difference() {
//     cards();
//     translate(v = [x/2-4,4,z-2]) rotate(a=45) cylinder(h=10, r=3, $fn=4);
//     translate(v = [4,w+cy+cw-4,z-2]) rotate(a=90) cylinder(h=10, r=3, $fn=50);
// }
// translate(v = [x/2,0,0]) mirror(v = [1,0,0]) difference() {
//     cards();
//     translate(v = [x/2-4,4,z-2]) rotate(a=90) cylinder(h=10, r=3, $fn=5);
//     translate(v = [4,w+cy+cw-4,z-2]) rotate(a=90) cylinder(h=10, r=3, $fn=50);
// }
// translate(v = [0,-c2y,0]) cards2();
// translate(v = [c2x,-c2y,0]) minis();

translate(v = [1.5*x,-c2y,0]) cards_small();