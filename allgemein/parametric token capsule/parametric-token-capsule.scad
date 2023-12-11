$fn=200;

/**
* This is an OpenSCAD remix of Grandfather1314's awesome Bullet♥ Token Holder Blueprint
* @source <https://boardgamegeek.com/filepage/232215/diy-token-holder-3d-printing>
* @author floookay <info@floookay.de>
*/

// * Please note: keep your desired layer height in mind when adjusting height parameters!

// mode
generate_ring = true;
generate_back = true;
generate_token = false;

// printer config
ring_back_interference = 0.1;

// token config
token_diameter = 25;
token_height = 2;

// capsule config
capsule_height = 6;

// ring config
ring_wall_thickness = 2;
ring_ledge_margin = 1.5;
ring_ledge_height= 0.6;

// back config
back_plate_height = 1.2;
back_ring_thickness = 3.5;

// dimensions
ring_ledge_diameter = token_diameter - ring_ledge_margin;
ring_inner_diameter = token_diameter;
ring_outer_diameter = ring_inner_diameter + ring_wall_thickness;
ring_height = capsule_height - back_plate_height;

back_plate_diameter = ring_outer_diameter;
back_ring_outer_diameter = ring_inner_diameter + ring_back_interference;
back_ring_inner_diameter = back_ring_outer_diameter - back_ring_thickness;
back_ring_height = capsule_height - token_height - back_plate_height - ring_ledge_height;

// modules
module back_plate() {
    cylinder(back_plate_height,back_plate_diameter/2,back_plate_diameter/2);
}
module back_ring() {
    difference() {
        cylinder(back_ring_height,back_ring_outer_diameter/2,back_ring_outer_diameter/2);
        cylinder(back_ring_height,back_ring_inner_diameter/2,back_ring_inner_diameter/2); 
    }
}
module back() {
    back_plate();
    translate([0,0,back_plate_height]) back_ring();
}
module ring() {
    difference() {
        cylinder(ring_height,ring_outer_diameter/2,ring_outer_diameter/2);
        cylinder(ring_height - ring_ledge_height,ring_inner_diameter/2,ring_inner_diameter/2);
        cylinder(ring_height,ring_ledge_diameter/2,ring_ledge_diameter/2); 
    }
}
module token() {
    color([1,1,1]) cylinder(token_height,token_diameter/2,token_diameter/2);
}

// generation
if(generate_back) {
    back();
}
if(generate_ring) {
    if(generate_back) {
        translate([0,0,back_plate_height]) ring();
    } else {
        translate([0,0,ring_height]) rotate([180,0,0]) ring();
    }
}
if(generate_back && generate_token) {
    translate([0,0,back_ring_height+back_plate_height]) token();
}
