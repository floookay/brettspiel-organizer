$fn = 20;

dice();
// ships();

module ships() {
    r=2;
    y=87;
    x=34;
    z=65;   // 69
    w=1.5;
    sz=100;
    sx=29;
    sy=28;
    difference() {
        hull() {
            translate([0,0,(z-2)/2+1]) cube_rounded([x,y,z-2], center=true,r=r);
            translate([0,0,z/2]) cube_rounded([x-2,y-2,z], center=true, r=r-1);
        }
        translate([-x/2+w,-y/2+sy/2+w,w]) ship(sx,sy,sz);
        translate([x/2-w,-sy/2+4.7,w]) rotate([0,0,180]) ship(sx,sy,sz);
        rotate([0,0,180]) translate([-x/2+w,-y/2+sy/2+w,w]) ship(sx,sy,sz);
        rotate([0,0,180]) translate([x/2-w,-sy/2+4.7,w]) rotate([0,0,180]) ship(sx,sy,sz);
    }
}
module ship(x,y,z) {
    translate([0,0,z/2]) union() {
        hull() {
            translate([8/2,0,0]) cube([8,y,z], center=true);
            translate([15/2,0,0]) cube([15,19,z], center=true);
        }
        translate([x/2,0,0]) cube([x,7,z], center=true);
        // translate([-10,0,20]) cube([30,y-8,z], center=true);
        translate([-10,0,20]) tray_rounded([30,y-8,z], center=true, r=10);
    }
}


module dice() {
    x=135;
    y=87;
    z=22;
    d=17;
    w=3;
    xd=w+d+w+d+w+d+w+d+w+d+w;
    yd=w+d*4+w;
    h=6;
    hd=d/2-1;
    difference() {
        union() {
            hull() {
                translate([0,0,(h-1)/2+1]) cube_rounded([x,y,h-1], center=true);
                translate([0,0,h/2]) cube_rounded([x-2,y-2,h], center=true, r=3-1);
            }
            hull() {
                translate([0,0,h/2]) cube_rounded([xd+w*2,yd+w*2,h], r=2, center=true);
                translate([0,0,hd/2]) cube_rounded([xd,yd,hd], r=1, center=true);
            }
            hull() {
                translate([0,0,h/2]) cube_rounded([x-12+w*2,30+w*2,h], r=2, center=true);
                translate([0,0,hd/2]) cube_rounded([x-12,30,hd], r=1, center=true);
            }
            translate([-x/2,-y/2,1]) cube_rounded([10,10,z/2-1]);
            translate([x/2-10,-y/2,1]) cube_rounded([10,10,z/2-1]);
            translate([-x/2,y/2-10,1]) cube_rounded([10,10,z/2-1]);
            translate([x/2-10,y/2-10,1]) cube_rounded([10,10,z/2-1]);
        }
        translate([0,0,d/2+2]) tray_rounded(v=[d,4*d,d], r=0.5, center=true);
        translate([w+d,0,d/2+2]) tray_rounded(v=[d,4*d,d], r=0.5, center=true);
        translate([w+d+w+d,0,d/2+2]) tray_rounded(v=[d,4*d,d], r=0.5, center=true);
        translate([-w-d,0,d/2+2]) tray_rounded(v=[d,4*d,d], r=0.5, center=true);
        translate([-w-d-w-d,0,d/2+2]) tray_rounded(v=[d,4*d,d], r=0.5, center=true);
        translate([-x/2+12.5+w-3,0,d/2+1]) tray_rounded(v=[10,21,d], r=0.5, center=true);
        translate([x/2-12.5-w+3,0,d/2+1]) tray_rounded(v=[10,21,d], r=0.5, center=true);

        translate([-x/2,-y/2,1]) translate([10/2,10/2,z/2-11])  cylinder(h=11, r=4.1/2);
        translate([x/2-10,-y/2,1]) translate([10/2,10/2,z/2-11])  cylinder(h=11, r=4.1/2);
        translate([-x/2,y/2-10,1]) translate([10/2,10/2,z/2-11])  cylinder(h=11, r=4.1/2);
        translate([x/2-10,y/2-10,1]) translate([10/2,10/2,z/2-11])  cylinder(h=11, r=4.1/2);

        linear_extrude(height = 1) text("H", size=40, font="Times New Roman:style=Bold", valign="center", halign="center");
    }
}






module cube_rounded(v, r=3, center=false){
    translate(center==true ? [r-v[0]/2,r-v[1]/2,-v[2]/2] : [r,r,0])
    union(){
        cylinder(h = v[2], r = r);
        translate(v = [0,v[1]-2*r,0]) cylinder(h = v[2], r = r);
        translate(v = [v[0]-2*r,v[1]-2*r,0]) cylinder(h = v[2], r = r);
        translate(v = [v[0]-2*r,0,0]) cylinder(h = v[2], r = r);
        translate(v = [-r,0,0]) cube([v[0],v[1]-2*r,v[2]]);
        translate(v = [0,-r,0]) cube([v[0]-2*r,v[1],v[2]]);
    }
}

module tray_rounded(v, r=3, center=false){
    translate(center==true ? [r-v[0]/2,r-v[1]/2,-v[2]/2] : [r,r,0])
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