$fn = 100;

module cube_rounded(v, r=3, center=false){
    translate([r,r,0])
    minkowski(){
        cube([v[0]-(2*r), v[1]-(2*r), v[2]-r], center);
        cylinder(r,r,r);
    }
}

// intersection() {
//     union() {
//         translate([0,0,12]) import("hegra_terrain.stl");
//         cube([200,40,13]);
//     }
//     cube_rounded(v = [200,29,50],r=2);
// }

difference() {
    union() {
        cube_rounded(v = [90,29,20], r=3);
        cube_rounded(v = [29,165,20], r=3);
    }
    translate(v = [29/2,29/2,0]) cylinder(r=10, h=30);
}