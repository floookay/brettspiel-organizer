$fn = 100;
tw=69;
th=40;
tl=150;

cw=42;
cl=64;

w=1.2;
mr=3.2/2;
ml=3;

sheath(true);
rotate([0,180,0]) translate([-2*(w+cl/2),0,5]) sheath(false);


module sheath(first=true) {
    difference() {
        union() {
            translate([0,-5,0]) magnet(12,(5+w)/2);    // magnet
            translate([0,0*(w+cw+w),0]) box(cl,cw,12);    // enemy heroes
            translate([0,1*(w+cw+w),0]) box(cl,cw,18);    // traits
            translate([0,2*(w+cw+w),0]) box(cl,cw,14);    // bystanders
            translate([0,3*(w+cw+w),0]) box(cl,cw,20);    // enemies
            translate([0,4*(w+cw+w),0]) magnet(20,(5-w)/2);    // magnets
        }
        translate(v = [first ? w+cl/2 : 0,-10,0]) cube([w+cl/2,1000,1000]);
    }

}

module magnet(h,o)
{
    difference() {
        cube([w+cl+w,5,w+h+w]);
        translate([3,o,w+h+w-ml]) cylinder(h = ml, r = mr);
        translate([w+cl+w-3,o,w+h+w-ml]) cylinder(h = ml, r = mr);
        translate([(w+cl+w)/2-ml,o,(w+h+w)/2]) rotate([0,90,0]) cylinder(h = 2*ml, r = mr);
    }
}
module box(x,y,z)
{
    difference() {
        cube([w+x+w,w+y+w,w+z+w]);
        translate([w,w,w]) cube([x,y,z]);
    }
}