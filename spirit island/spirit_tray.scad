$fn=50;

x=282;
y=210;
zb=4.4;
z=25;

module senkloch() {
    h=4.4;
    r=6/2;
    union() {
        cylinder(h=h, r = r/2);
        translate([0,0,h-r]) cylinder(h=r, r1=0, r2=r);
        translate([0,0,h]) cylinder(h=h, r = r);
    }
}
module cube_rounded(v, r=3, center=false){
    translate([r,r,0])
    minkowski(){
        cube([v[0]-(2*r), v[1]-(2*r), v[2]-r], center);
        cylinder(r,r,r);
    }
}
module spirits() {
    difference() {
        union() {
            cube_rounded(v = [x/3,y,zb]);
            translate(v = [0,10,0]) cube_rounded(v = [x/3,y-2*10,z]);
        }
        translate(v = [10,5,0]) senkloch();
        translate(v = [x/3-10,5,0]) senkloch();
        translate(v = [10,y-5,0]) senkloch();
        translate(v = [x/3-10,y-5,0]) senkloch();
        for (i=[0:16]) {
            translate(v = [1.8,10+5+10*i,0]) rotate([0,0,10]) cube_rounded(v = [92.5,5,30],r=0.5);
        }
    }
}
// spirits();


module panels() {
    xp=230;
    yp=153;
    w=4;
    difference() {
        cube_rounded(v = [xp+2*w,yp+2*w,z], r=w+5);
        translate(v = [w,w,zb]) cube_rounded(v = [xp,yp,z], r=5);
        translate(v = [10,10,0]) senkloch();
        translate(v = [xp+2*w-10,10,0]) senkloch();
        translate(v = [10,yp+2*w-10,0]) senkloch();
        translate(v = [xp+2*w-10,yp+2*w-10,0]) senkloch();
        translate(v = [xp/2+w,0,0]) cylinder(h=30, r=60);
        translate(v = [xp/2+w,yp+2*w,0]) cylinder(h=30, r=60);
        translate(v = [0,yp/2+w,0]) cylinder(h=30, r=30);
        translate(v = [xp+2*w,yp/2+w,0]) cylinder(h=30, r=30);
    }
}
// panels();

module aspects() {
    ya=153+2*4;
    xa=x-(230+2*4);
    w=4;
    difference() {
        union() {
            cube_rounded(v = [xa,ya,zb]);
            translate(v = [0,10,0]) cube_rounded(v = [xa,ya-2*10,z]);
        }
        translate(v = [10,5,0]) senkloch();
        translate(v = [xa-10,5,0]) senkloch();
        translate(v = [10,ya-5,0]) senkloch();
        translate(v = [xa-10,ya-5,0]) senkloch();
        // intersection() {
        //     translate(v = [w,10+w,0]) cube(size = [xa-2*w,ya-2*w-2*10,30]);
        //     translate(v = [0,7,0]) rotate([0,0,acos((xa-2*w)/94.7)]) cube(size = [200,20,30]);
        // }
        xac = 21;
        translate(v = [xa-xac-w,(ya-92.5)/2,0]) cube_rounded(v=[xac,92.5,30],r=0.5);
        translate(v = [0,ya/2,0]) scale(v = [1,2,1]) cylinder(h=30, r=15);
    }
}
aspects();
