$fn=200;

x=296;
px=202;
z=47;

w=1.6;

cardy=49;


xd=(x-px-1)/2;
yd=x-cardy;

r=40.8/2;

module dresser() {
    union() {
        difference() {
            cube([xd,yd,z]);
            translate([w,w,1]) cube([(xd-3*w)/2,yd-2*w,z]);
            translate([w+(xd-3*w)/2+w,w,1]) cube([(xd-3*w)/2,yd-2*w,z]);
            translate(v = [-1,(yd-2*w)/2,0]) rotate([0,90,0]) cylinder(r=20,h=50);
        }
        translate([xd,yd-(w+30.5+w),0]) difference() {
            union() {
                cube([r*2+w,w+30.5+w,z-r]);
                hull() {
                    translate([0,30.5-43,0]) cube([r*2+w,43,2]);
                    cube([r*2+w,30.5,13]);
                }
            }
            translate([r,w,z-r]) rotate([-90,0,0]) cylinder(h=30.5, r=r);
        }
    }
}
mirror([1,0,0]) dresser();


dt1=63;
dt2=84;
dto=yd-2*w-0.4-(w+dt1+w+dt2+w)-w;
module drawer_tiles() {
    difference() {
        cube_rounded([z-1-0.4,yd-2*w-0.4,(xd-3*w)/2-0.4]);
        translate([w,w,1]) cube_rounded2([(z-1-0.4)-2*w,dt1,100]);
        translate([w,w+dt1+w,1]) cube_rounded2([(z-1-0.4)-2*w,dt2,100]);
        translate([w,w+dt1+w+dt2+w,1]) cube_rounded2([(z-1-0.4)-2*w,dto,100]);
        // test
        translate([0,30,0]) sphere(r = 10);
        translate([0,yd-2*w-30,0]) sphere(r = 10);
        translate([0,(yd-2*w)/2,0]) sphere(r = 10);
    }
}
// drawer_tiles();

module cube_rounded2(v, r=10, center=false){
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