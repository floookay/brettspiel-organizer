$fn = 100;

x1 = 73;
y1 = 110;

x2 = 100;
y2 = 68.5;

zc = 70;

cmin = 67.5;
w = 1.6;

module main_cards() {
    difference() {
        cube_rounded([x1,y1,zc]);
        translate([1.5*w,w,w]) scheren([0,0.5,4]) cube([x1-3*w,y1-12.5,zc]);
        // feet
        rf=8.5/2;
        fo=10;
        translate([fo,0.8,zc-fo]) rotate([90,0,0]) cylinder(h=2, r=rf);
        translate([x1-fo,0.8,zc-fo]) rotate([90,0,0]) cylinder(h=2, r=rf);
        translate([x1-fo,0.8,fo]) rotate([90,0,0]) cylinder(h=2, r=rf);
        translate([fo,0.8,fo]) rotate([90,0,0]) cylinder(h=2, r=rf);
    }
}
main_cards();

t3=55;
module treasure(t=5) {
    difference() {
        cube_rounded([t3+2*w,t3+2*w,2*t+w]);
        translate([w,w,w]) cube_rounded([t3,t3,2*t+w], r=2-w);
    }
}
module treasure_lid(t=5) {
    s=0.5;
    // translate([-(t3+2*w+s+2*w)/2,-(t3+2*w+s+2*w)/2,-0.8]) cube_rounded([t3+2*w+s+2*w,t3+2*w+s+2*w,0.8]);
    difference() {
        translate([-(t3+2*w+s+2*w)/2,-(t3+2*w+s+2*w)/2,0]) difference() {
            cube_rounded([t3+2*w+s+2*w,t3+2*w+s+2*w,2*t+w+w]);
            translate([w,w,w]) cube_rounded([t3+2*w+s,t3+2*w+s,2*t+w+1], r=2-w);
        }
        translate([-30/2,-(t3+2*w+s+2*w)/2-1,w]) union() {
            cube_rounded2([30,100,30]);
            translate([-2,100,2*t+w-2]) rotate([90,0,0]) difference() {
                cube([3,3,100]);
                cylinder(h=100,r=2);
            }
            translate([30+2,100,2*t+w-2]) rotate([90,0,0]) difference() {
                translate([-3,0,0]) cube([3,3,100]);
                cylinder(h=100,r=2);
            }
        }
        rotate([0,0,90]) translate([-30/2,-(t3+2*w+s+2*w)/2-1,w]) union() {
            cube_rounded2([30,100,30]);
            translate([-2,100,2*t+w-2]) rotate([90,0,0]) difference() {
                cube([3,3,100]);
                cylinder(h=100,r=2);
            }
            translate([30+2,100,2*t+w-2]) rotate([90,0,0]) difference() {
                translate([-3,0,0]) cube([3,3,100]);
                cylinder(h=100,r=2);
            }
        }
    }
}
// treasure_lid();

module cube_rounded2(v, r=2, center=false){
    translate([0,v[1],0]) rotate([90,0,0]) cube_rounded([v[0],v[2],v[1]], r = r);
}

module cube_rounded(v, r=2, center=false){
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

module scheren(v) {
    multmatrix([[1,0,v[0]/v[2],0],[0,1,v[1]/v[2],0],[0,0,1,0]]) children();
}