$fn=200;

// TODO tolerances need to be worked on!!

/**
* This is an OpenSCAD remix of Grandfather1314's awesome Bullet♥ Token Holder Blueprint
* @source <https://boardgamegeek.com/filepage/232215/diy-token-holder-3d-printing>
* @author floookay <info@floookay.de>
*/

// * Please note: keep your desired layer height in mind when adjusting height parameters!

// mode
generate_tile = false;
generate_back = true;
generate_token = false;

// printer config
tile_back_interference = 0.2;

// token config
token_size = 38;
token_radius = 2;
token_height = 2;

// capsule config
capsule_height = 6;

// tile config
tile_wall_thickness = 2;
tile_ledge_margin = 1.5;
tile_ledge_height= 0.6;

// back config
back_plate_height = 1.2;
back_tile_thickness = 3.5;

// dimensions
tile_ledge_size = token_size - tile_ledge_margin;
tile_inner_size = token_size;
tile_outer_size = tile_inner_size + tile_wall_thickness;
tile_height = capsule_height - back_plate_height;
tile_radius = token_radius + tile_wall_thickness;

back_plate_size = tile_outer_size;
back_tile_outer_size = tile_inner_size + tile_back_interference;
back_tile_inner_size = back_tile_outer_size - back_tile_thickness;
back_tile_height = capsule_height - token_height - back_plate_height - tile_ledge_height;

// modules
module back_plate() {
    cube_rounded([back_plate_size,back_plate_size,back_plate_height], r=tile_radius);
}
module back_tile() {
    difference() {
        cube_rounded([back_tile_outer_size,back_tile_outer_size,back_tile_height], r=tile_radius);
        cube_rounded([back_tile_inner_size,back_tile_inner_size,back_tile_height], r=token_radius);
    }
}
module back() {
    back_plate();
    translate([0,0,back_plate_height]) back_tile();
}
module tile() {
    difference() {
        cube_rounded([tile_outer_size,tile_outer_size,tile_height], r=tile_radius);
        cube_rounded([tile_inner_size,tile_inner_size,tile_height - tile_ledge_height], r=token_radius);
        cube_rounded([tile_ledge_size,tile_ledge_size,tile_height], r=token_radius);
    }
}
module token() {
    color([1,1,1]) cube_rounded([token_size,token_size,token_height], r=token_radius);
}

// generation
if(generate_back) {
    back();
}
if(generate_tile) {
    if(generate_back) {
        translate([0,0,back_plate_height]) tile();
    } else {
        translate([0,0,tile_height]) rotate([180,0,0]) tile();
    }
}
if(generate_back && generate_token) {
    translate([0,0,back_tile_height+back_plate_height]) token();
}

module cube_rounded(v, r=3, center=true){
    translate(center==true ? [r-v[0]/2,r-v[1]/2,0] : [r,r,0])
    hull(){
        cylinder(h = v[2], r = r);
        translate(v = [0,v[1]-2*r,0]) cylinder(h = v[2], r = r);
        translate(v = [v[0]-2*r,v[1]-2*r,0]) cylinder(h = v[2], r = r);
        translate(v = [v[0]-2*r,0,0]) cylinder(h = v[2], r = r);
    }
}
