// $fn = 100;   // for rendering
$fn = 20;   // for previewing
assembly=true;

double_layer=true;

// cards
card_w = 64;
card_h = 89;
card_clearance_w = 1.5;
// box
box_w = 191;
box_l = 240;
box_clearance_l = 1.5;
box_clearance_w = 2;
// printer
layer_height = 0.2;
nozzle = 0.4;
walls_lanes = 3;
bottom_layers = 4;
walls = walls_lanes*nozzle;
bottom = bottom_layers*layer_height;

// helper modules
preview_adjustment = 1;
module cube_rounded(v, r=3, center=false){
    translate([r,r,0])
    minkowski(){
        cube([v[0]-(2*r), v[1]-(2*r), v[2]-r], center);
        cylinder(r,r,r);
    }
}

// card_box
card_box_l = box_l - box_clearance_l;
card_box_w = card_h + card_clearance_w + 2*walls;
card_box_h = 52;
card_box_corners = 2;
card_box_handle_h = card_box_h + 20;
card_box_hole_r = 20;
card_box_hole_offset = 15;
module card_box(){
    difference(){
        union(){
            cube_rounded([card_box_l,card_box_w,card_box_h], card_box_corners);
            translate([0,card_box_w/2,card_box_h-card_box_hole_offset]) rotate([0,90,0]) cylinder(h=card_box_l,r=card_box_hole_r+12);
        }
        translate([-preview_adjustment,card_box_w/2,card_box_h-card_box_hole_offset]) rotate([0,90,0]) cylinder(h=card_box_l+2*preview_adjustment,r=card_box_hole_r);
        translate([walls, walls, bottom]) cube([card_box_l - 2*walls,card_box_w-2*walls,2*card_box_h]);
    }
}

// resource trays
resource_w = box_w - box_clearance_w - card_box_w;
resource_l = 70;
resource_clearance = 1;
resource_h_bronze = 7.3;
resource_h_silver = 8.2;
resource_h_gold = 10.3;
resource_cavetto_r = 10;
resource_pattern_l_count = 3;
resource_pattern_w_count = 5;
function resource_tray_height(h,c=1) = h*c + bottom + resource_clearance;
module resource_tray(h,c=1){
    difference(){
        cube_rounded([resource_l, resource_w, resource_tray_height(h,c)]);
        translate([walls+resource_cavetto_r, walls+resource_cavetto_r, bottom+resource_cavetto_r]) minkowski(){
            cube([resource_l-2*(walls+resource_cavetto_r), resource_w-2*(walls+resource_cavetto_r), resource_tray_height(h,c)]);
            sphere(r=resource_cavetto_r);
        }
        translate([
            (resource_l - h*resource_pattern_l_count - h/2*(resource_pattern_l_count-1))/2,
            (resource_w - h*resource_pattern_w_count - h/2*(resource_pattern_w_count-1))/2,
            bottom - layer_height
        ]) resource_tray_pattern(h);
    }
}
module resource_tray_pattern(h){
    for (i=[0:resource_pattern_l_count-1]){
        for (j=[0:resource_pattern_w_count-1]){
            translate([i*(h+h/2), j*(h+h/2), 0]) cube_rounded([h,h,h],0.5);
        }
    }
}
module resource_tray_pattern_random(h){
    // scratched idea, didn't like the look
    for (i=[0:9]){
        random_y = rands(0,resource_w-2*(walls+resource_cavetto_r),1);
        random_x = rands(0,resource_l-2*(walls+resource_cavetto_r),1);
        translate([random_x[0], random_y[0], 0]) cube([h,h,h]);
    }
}
module resource_tray_bronze(){
    resource_tray(resource_h_bronze, 2);
}
module resource_tray_silver(){
    resource_tray(resource_h_silver);
}
module resource_tray_gold(){
    resource_tray(resource_h_gold);
}

// symbol tray
symbol_d = 9.72;
symbol_pattern_l_count = 3;
symbol_pattern_w_count = 5;
symbol_tray_h = card_box_h - (resource_tray_height(resource_h_gold)+resource_tray_height(resource_h_silver)+resource_tray_height(resource_h_bronze,2));
module symbol_tray(){
    difference(){
        cube_rounded([resource_l, resource_w, symbol_tray_h]);
        translate([walls+resource_cavetto_r, walls+resource_cavetto_r, bottom+resource_cavetto_r]) minkowski(){
            cube([resource_l-2*(walls+resource_cavetto_r), resource_w-2*(walls+resource_cavetto_r), symbol_tray_h]);
            sphere(r=resource_cavetto_r);
        }
        translate([
            (resource_l - symbol_d*symbol_pattern_l_count - symbol_d/2*(symbol_pattern_l_count-1))/2,
            (resource_w - symbol_d*symbol_pattern_w_count - symbol_d/2*(symbol_pattern_w_count-1))/2,
            bottom - layer_height
        ]) symbol_tray_pattern(symbol_d);
    }
}
module symbol_tray_pattern(d){
    for (i=[0:symbol_pattern_l_count-1]){
        for (j=[0:symbol_pattern_w_count-1]){
            translate([d/2,d/2,0]) translate([i*(d+d/2), j*(d+d/2), 0]) cylinder(10,r=d/2);
        }
    }
}

// player tray
player_cube = 8;
player_colors = 6;
player_tray_h = card_box_h;
player_tray_w = box_w - box_clearance_w - card_box_w;
player_tray_l = 40;
player_offset = player_cube + 10;
player_rim = walls;
player_notch = 5;
clear_cube = 10.2;
module player_tray(){
    difference(){
        d = 2.6*player_cube;
        cube_rounded([player_tray_l, player_tray_w, player_tray_h]);
        offset_y = (player_tray_w-2*player_rim)/(player_colors/2 + 0.5);
        for (i=[0:player_colors/2-1]){
            translate([d/2,d/2,player_offset]) translate([player_rim, player_rim+i*(offset_y), 0]) union(){
                cylinder(player_tray_h-player_offset + preview_adjustment, r=d/2);
                sphere(r=d/2);
                translate([-d/2-player_notch-preview_adjustment,-player_notch/2,0]) cube([player_notch*2,player_notch,player_tray_h-player_offset + preview_adjustment]);
            }
        }
        for (i=[0:player_colors/2-1]){
            translate([d/2,d/2,player_offset]) translate([player_tray_l-player_rim-d, player_rim+(i+0.5)*(offset_y), 0]) union(){
                cylinder(player_tray_h-player_offset + preview_adjustment, r=d/2);
                sphere(r=d/2);
                translate([d/2-player_notch+preview_adjustment,-player_notch/2,0]) cube([player_notch*2,player_notch,player_tray_h-player_offset + preview_adjustment]);
            }
        }
        // marker
        d_clear = clear_cube * 1.2;
        translate([player_rim+2, player_tray_w-player_rim-d_clear, player_tray_h-clear_cube*3]) minkowski(){
            cube([d_clear-2, d_clear-2, clear_cube*3]);
            sphere(r=2);
        }
    }
}

// crisis trays
vp_3 = 24.8;
vp_1 = 14.7;
crisis_d = 14.7;
damage_w = 26.6;
damage_l = 50;
damage_t = 2;
damage_clearance = 1.5;
ocean_hex = 33.5;
ocean_hex_r = ((ocean_hex/2)/cos(30));
ocean_hex_h=18.3;
ocean_hex_clearance = 1.5;
crisis_tray_l = card_box_l-resource_l-player_tray_l;
crisis_vp_tray_l = (crisis_tray_l+walls)/2;
crisis_tray_w = box_w - box_clearance_w - card_box_w;
crisis_tray_h = ocean_hex_h + ocean_hex_clearance + bottom;
vp_3_w= 55;
vp_1_w= 33;
finger = 25/2;
module crisis_tray(){
    difference(){
        cube_rounded([crisis_tray_l, crisis_tray_w, crisis_tray_h]);
        minko_vp_3_w = vp_3_w-2*(walls+resource_cavetto_r);
        minko_vp_3_l = crisis_vp_tray_l-2*(walls+resource_cavetto_r);
        // vp 3
        translate([crisis_tray_l-crisis_vp_tray_l+walls+resource_cavetto_r, walls+resource_cavetto_r, bottom+resource_cavetto_r]) union(){
            minkowski(){
                cube([minko_vp_3_l, minko_vp_3_w, crisis_tray_h]);
                sphere(r=resource_cavetto_r);
            }
            translate([vp_3/2 + (minko_vp_3_l - vp_3)/2,minko_vp_3_w/2,-resource_cavetto_r-layer_height]) crisis_vp_tray_pattern(vp_3,1);
        }
        // vp 1
        minko_vp_1_w = vp_1_w-2*(walls+resource_cavetto_r);
        minko_vp_1_l = crisis_vp_tray_l-2*(walls+resource_cavetto_r);
        translate([walls+resource_cavetto_r, resource_cavetto_r+walls, bottom+resource_cavetto_r]) union(){
            minkowski(){
                cube([minko_vp_1_l, minko_vp_1_w, crisis_tray_h]);
                sphere(r=resource_cavetto_r);
            }
            translate([vp_1/2 + (minko_vp_1_l - (2*vp_1 + 1*vp_1/6))/2,minko_vp_1_w/2,-resource_cavetto_r-layer_height]) crisis_vp_tray_pattern(vp_1,2);
        }
        // crisis marker
        minko_cm_1_w = minko_vp_1_w;
        minko_cm_1_l = minko_vp_1_l;
        translate([walls+resource_cavetto_r, minko_vp_1_w+3*resource_cavetto_r+2*walls, bottom+resource_cavetto_r]) union(){
            minkowski(){
                cube([minko_cm_1_l, minko_cm_1_w, crisis_tray_h]);
                sphere(r=resource_cavetto_r);
            }
            translate([vp_1/2 + (minko_cm_1_l - (2*vp_1 + 1*vp_1/6))/2,minko_cm_1_w/2,-resource_cavetto_r-layer_height]) crisis_cm_tray_pattern(vp_1,2);
        }
        // damage
        translate([(crisis_vp_tray_l-damage_l)/2-walls+damage_clearance, crisis_tray_w-damage_w-walls-damage_clearance, crisis_tray_h-(damage_t*3+damage_clearance)]) union(){
            minkowski(){
                cube([damage_l, damage_w, damage_t*3+damage_clearance]);
                sphere(r=damage_clearance);
            }
        }
        translate([crisis_vp_tray_l/2,crisis_tray_w,-preview_adjustment]) cylinder(crisis_tray_h+2*preview_adjustment,r=finger);
        // ocean hexes
        translate([crisis_tray_l-crisis_vp_tray_l+crisis_vp_tray_l/2,crisis_tray_w-walls-ocean_hex/2-ocean_hex_clearance,bottom+ocean_hex_clearance]) union(){
            minkowski(){
                cylinder(r=ocean_hex_r, h=20, $fn=6);
                sphere(r=ocean_hex_clearance);
            }
        }
        translate([crisis_tray_l-crisis_vp_tray_l+crisis_vp_tray_l/2,crisis_tray_w,-preview_adjustment]) cylinder(crisis_tray_h+2*preview_adjustment,r=finger);
    }
}
module crisis_vp_tray_pattern(d, count=1){
    for (i=[0:count-1]){
        translate([i*(d+d/6), 0, 0]) cylinder(10,r=d/2);
    }
}
module crisis_cm_tray_pattern(d, count=1){
    for (i=[0:count-1]){
        difference(){
            translate([i*(d+d/6), 0, 0]) cylinder(10,r=d/2);
            translate([i*(d+d/6), 0, 0]) rotate(90) cylinder(10,d/2,d/2,$fn=3);
        }
    }
}

// phase tray
phase = 47.5 + 1.5;
phase_cavetto_r = 1;
phase_tray_l = phase + 2*walls + 2*phase_cavetto_r;
phase_tray_w = box_w - box_clearance_w - card_box_w;
phase_tray_h = ocean_hex_h + ocean_hex_clearance + bottom;
module phase_tray(){
    difference(){
        cube_rounded([phase_tray_l, phase_tray_w, phase_tray_h]);
        minko_3_l = phase_tray_l-2*(walls+phase_cavetto_r);
        // phase marker
        translate([walls+phase_cavetto_r, walls+phase_cavetto_r, bottom+phase_cavetto_r]) union(){
            minkowski(){
                cube([minko_3_l, minko_3_l, phase_tray_h]);
                sphere(r=phase_cavetto_r);
            }
        }
        translate([phase_tray_l/2,0,-preview_adjustment]) cylinder(phase_tray_h+2*preview_adjustment,r=finger);
        // ocean hexes
        translate([phase_tray_l/2,phase_tray_w-walls-ocean_hex/2-ocean_hex_clearance,bottom+ocean_hex_clearance]) union(){
            minkowski(){
                cylinder(r=ocean_hex_r, h=20, $fn=6);
                sphere(r=ocean_hex_clearance);
            }
        }
        translate([phase_tray_l/2,phase_tray_w,-preview_adjustment]) cylinder(phase_tray_h+2*preview_adjustment,r=finger);
    }
}

// discovery tray
milestone_symbol_l = 55;
milestone_symbol_w = 14.9;
milestone_symbol_w_d = 17;
award_symbol_l1 = 44;
award_symbol_l1_5 = 35;
award_symbol_l2 = 27;
award_symbol_w1 = 8;
award_symbol_w2 = 31.5;
award_symbol_w3 = 34;
award_symbol_w_d = milestone_symbol_w_d;
discovery_cavetto_r = 5;
discovery_ratio = 0.5;
discovery_tray_l = card_box_l-resource_l-player_tray_l-phase_tray_l;
discovery_tray_w = box_w - box_clearance_w - card_box_w;
discovery_tray_h = phase_tray_h;
module discovery_tray(){
    difference(){
        cube_rounded([discovery_tray_l, discovery_tray_w, discovery_tray_h]);
        minko_3_l = discovery_tray_l-2*(walls+discovery_cavetto_r);
        // award marker
        award_w = discovery_tray_w*(1-discovery_ratio)-2*walls-2*discovery_cavetto_r;
        translate([walls+discovery_cavetto_r, walls+discovery_cavetto_r, bottom+discovery_cavetto_r]) minkowski(){
            cube([discovery_tray_l-2*(walls+discovery_cavetto_r), award_w, discovery_tray_h]);
            sphere(r=discovery_cavetto_r);
        }
        translate([discovery_tray_l/2-award_symbol_l2/2, (award_w+2*walls+2*discovery_cavetto_r-award_symbol_w3)/2, bottom - layer_height]) award_pattern();
        // milestone marker
        milestone_w = discovery_tray_w*discovery_ratio-walls-2*discovery_cavetto_r;
        translate([walls+discovery_cavetto_r, discovery_tray_w-milestone_w-walls-discovery_cavetto_r, bottom+discovery_cavetto_r]) minkowski(){
            cube([discovery_tray_l-2*(walls+discovery_cavetto_r), milestone_w, discovery_tray_h]);
            sphere(r=discovery_cavetto_r);
        }
        translate([(discovery_tray_l-milestone_symbol_l)/2, discovery_tray_w-(milestone_w-walls-2*discovery_cavetto_r)-milestone_symbol_w/2, bottom - layer_height]) milestone_pattern();
    }
}
module award_pattern(){
    translate([0,0,0]) union(){
        cube_rounded([award_symbol_l2,award_symbol_w2,10], 2);
        translate([(award_symbol_l2-award_symbol_l1)/2,award_symbol_w2-award_symbol_w1,0]) intersection(){
            translate([0,-10,0]) cube([award_symbol_l1,award_symbol_w1+10,10]);
            translate([0,-award_symbol_w1+7.5,0]) cube_rounded([award_symbol_l1,award_symbol_w1+10,10],3);
        }
        translate([(award_symbol_l1_5-award_symbol_l1)/2,award_symbol_w2-13,0]) cube_rounded([award_symbol_l1_5,13,10],3);
        translate([award_symbol_l2/2,award_symbol_w2+(award_symbol_w3-award_symbol_w2)-award_symbol_w_d/2,0]) cylinder(h=10, r=award_symbol_w_d/2);
    }
}
module milestone_pattern(){
    union(){
        cube_rounded([milestone_symbol_l,milestone_symbol_w,10],1);
        translate([milestone_symbol_l/2,milestone_symbol_w/2,0]) cylinder(h=10,r=milestone_symbol_w_d/2);
    }
}

// forest tray
forest_hex_5 = 24.75;
forest_hex_5_r = ((forest_hex_5/2)/cos(30));
forest_hex_1 = 19.70;
forest_hex_1_r = ((forest_hex_1/2)/cos(30));
forest_cavetto_r = 5;
forest_ratio = 0.5;
forest_tray_l = card_box_l-resource_l-player_tray_l;
forest_tray_w = box_w - box_clearance_w - card_box_w;
forest_tray_h = card_box_h - phase_tray_h - discovery_tray_h;
module forest_tray(){
    difference(){
        cube_rounded([forest_tray_l, forest_tray_w, forest_tray_h]);
        minko_3_l = forest_tray_l-2*(walls+forest_cavetto_r);
        // forest 5 marker
        forest_5_w = forest_tray_w*(1-forest_ratio)-walls-2*forest_cavetto_r;
        translate([walls+forest_cavetto_r, walls+forest_cavetto_r, bottom+forest_cavetto_r]) minkowski(){
            cube([forest_tray_l-2*(walls+forest_cavetto_r), forest_5_w, forest_tray_h]);
            sphere(r=forest_cavetto_r);
        }
        forest_hex_5_l = 3*2.5*forest_hex_5_r - forest_hex_5_r/2;
        translate([(forest_tray_l-forest_hex_5_l)/2 + forest_hex_5_r, (forest_5_w+walls+2*forest_cavetto_r)/2, bottom - layer_height]) forest_hex_5_pattern();
        // forest 1 marker
        forest_1_w = forest_tray_w*forest_ratio-2*walls-2*forest_cavetto_r;
        translate([walls+forest_cavetto_r, forest_tray_w-forest_1_w-walls-forest_cavetto_r, bottom+forest_cavetto_r]) minkowski(){
            cube([forest_tray_l-2*(walls+forest_cavetto_r), forest_1_w, forest_tray_h]);
            sphere(r=forest_cavetto_r);
        }
        forest_hex_1_l = 3*2.5*forest_hex_1_r - forest_hex_1_r/2;
        translate([(forest_tray_l-forest_hex_1_l)/2 + forest_hex_1_r, discovery_tray_w-(forest_1_w+walls+2*forest_cavetto_r)/2, bottom - layer_height]) forest_hex_1_pattern();
    }
}
module forest_hex_5_pattern(){
    for (i=[0:2]){
        translate([i*2.5*forest_hex_5_r, 0, 0]) cylinder(r=forest_hex_5_r, h=10, $fn=6);;
    }
}
module forest_hex_1_pattern(){
    for (i=[0:2]){
        translate([i*2.5*forest_hex_1_r, 0, 0]) cylinder(r=forest_hex_1_r, h=10, $fn=6);;
    }
}

module lid(doublelayer=true) {
    h = doublelayer ? 1 : 18.5-12.5;
    lid_h = 17 + h;
    lid_w = resource_w;
    lid_l = box_l-box_clearance_l;
    difference() {
        union() {
            v = [lid_l, lid_w, h];
            r = 3;
            translate([r,r,0])
            union(){
                cylinder(h = v[2], r = r);
                translate(v = [0,v[1]-2*r,0]) cylinder(h = v[2], r = r);
                translate(v = [v[0]-2*r,v[1]-2*r,0]) cylinder(h = v[2], r = r);
                translate(v = [v[0]-2*r,0,0]) cylinder(h = v[2], r = r);
                translate(v = [-r,0,0]) cube([v[0],v[1]-2*r,v[2]]);
                translate(v = [0,-r,0]) cube([v[0]-2*r,v[1],v[2]]);
            }
            cube_rounded(v = [34,lid_w,lid_h-5]);
            cube_rounded(v = [34,lid_w-45,lid_h]);
            translate(v = [0,lid_w-45,0]) cube_rounded(v = [lid_l,45,lid_h-5]);
        }
        translate(v = [2,2,4]) cube_rounded(v = [34-2*2,lid_w-45-2*2,lid_h]);
    }
}

// assembly
if(assembly){
    color("darkorange") card_box();
    color("gold") translate([card_box_l-resource_l,card_box_w,0]) resource_tray_gold();
    color("silver") translate([card_box_l-resource_l,card_box_w,resource_tray_height(resource_h_gold)]) resource_tray_silver();
    color("peru") translate([card_box_l-resource_l,card_box_w,resource_tray_height(resource_h_gold)+resource_tray_height(resource_h_silver)]) resource_tray_bronze();
    color("plum") translate([card_box_l-resource_l,card_box_w,resource_tray_height(resource_h_gold)+resource_tray_height(resource_h_silver)+resource_tray_height(resource_h_bronze,2)]) symbol_tray();
    color("turquoise") translate([card_box_l-resource_l-player_tray_l,card_box_w,0]) player_tray();
    color("crimson") translate([0,card_box_w,0]) crisis_tray();
    color("midnightblue") translate([card_box_l-resource_l-player_tray_l-phase_tray_l,card_box_w,crisis_tray_h]) phase_tray();
    color("khaki") translate([card_box_l-resource_l-player_tray_l-phase_tray_l-discovery_tray_l,card_box_w,crisis_tray_h]) discovery_tray();
    color("salmon") translate([card_box_l-resource_l-player_tray_l-phase_tray_l-discovery_tray_l,card_box_w,crisis_tray_h+discovery_tray_h]) forest_tray();
    color("green") translate([0,card_box_w,card_box_h]) lid(double_layer);
}