// Arnak
// $fn = 100;
$fn = 20;
bottom = 1;
wall = 1.2;
box_length = 359 - 3;
box_width = 251 - 3;
height = 72 + 1;
tray_r = 1;

sleeved_card_w = 66;
sleeved_card_l = 91;
sleeved_card_c = 1;
bottom_card_trays = (height - sleeved_card_w)/2;

module cube_rounded(v, r=3, center=false){
    translate([r,r,0])
    minkowski(){
        cube([v[0]-(2*r), v[1]-(2*r), v[2]-r], center);
        cylinder(r,r,r);
    }
}
module tray_rounded(v, r=3, center=false, notop = true){
    union() {
        if(notop){
            translate([0, 0, v[2]-r-1])
            cube_rounded([v[0], v[1], r+1], r);
        }
        translate([r,r,r])
        minkowski(){
            cube([v[0]-(2*r), v[1]-(2*r), v[2]-(2*r)], center);
            sphere(r);
        }
    }
}


x_player_tray_cards = 22;
x_player_tray_token = 60;
x_player_tray = wall + x_player_tray_cards + wall + x_player_tray_token + wall;
y_card_tray = wall + sleeved_card_l + sleeved_card_c + wall;
module player_tray() {
    x = x_player_tray;
    y = y_card_tray;
    z = height;
    difference() {
        cube_rounded([x,y,z], tray_r);
        // card tray
        translate([wall, wall, bottom_card_trays]) cube([x_player_tray_cards, sleeved_card_l + sleeved_card_c, z]);
        translate([0, y/2, z]) rotate([0, 90, 0]) cylinder(wall + x_player_tray_cards + wall, r = 20);
        // token tray
        translate([wall + x_player_tray_cards + wall, wall, bottom_card_trays]) tray_rounded([x_player_tray_token, y - 2*wall, z], 5);
    }
}
player_tray();


x_card_tray_fear = 11;
x_card_tray_artifact = 30;
x_card_tray_item = 36;
x_card_tray = wall + x_card_tray_fear + wall + x_card_tray_artifact + wall + x_card_tray_item + wall;
module card_tray() {
    x = x_card_tray;
    y = y_card_tray;
    z = height;
    difference() {
        cube_rounded([x,y,z], tray_r);
        // fear card tray
        translate([wall, wall, bottom_card_trays]) cube([x_card_tray_fear, sleeved_card_l + sleeved_card_c, z]);
        // artifact card tray
        translate([wall + x_card_tray_fear + wall, wall, bottom_card_trays]) cube([x_card_tray_artifact, sleeved_card_l + sleeved_card_c, z]);
        // item card tray
        translate([wall + x_card_tray_fear + wall + x_card_tray_artifact + wall, wall, bottom_card_trays]) cube([x_card_tray_item, sleeved_card_l + sleeved_card_c, z]);
        translate([0, y/2, z]) rotate([0, 90, 0]) cylinder(x_card_tray, r = 20);
    }
}
translate([x_player_tray, 0, 0]) card_tray();


x_big_tile_tray = box_length - x_player_tray - x_card_tray;
x_campaign_tray = wall + 89 + wall;
y_tiles = wall + 77 + wall;
module big_tile_tray() {
    x = x_big_tile_tray;
    yc = y_card_tray;
    yt = y_tiles;
    z = height;
    s = wall + 45 + wall;
    difference() {
        union() {
            translate([s, 0, 0]) cube_rounded([x-x_campaign_tray-s-1,yc,z], tray_r);
            translate([s, 0, 0]) cube_rounded([x-s,yt,z], tray_r);
            cube_rounded([s + 20, yc, z-30], tray_r);
        }
        // 6 lvl tiles
        translate([x_big_tile_tray - wall - 39, 0, z - 60 - 1]) lvl_tile(39, 68, 77, wall, 60);
        // guardian tiles
        translate([x_big_tile_tray - wall - 39 - wall - 47, (yt - 72.5)/2, 0]) guardian_tile(47, 72.5);
        // translate([x_big_tile_tray - wall - 39 - wall - 47, - wall + (yt - 76)/2, 0]) lvl_tile(47, 65, 76, wall, 72);    // also works
        translate([x_big_tile_tray - wall - 39 - wall - 47, yt/2, z]) hull() {
            sphere(r = 20);
            translate([x_campaign_tray, 0, 0]) sphere(r = 20);
        }
        // 10 lvl tiles
        translate([s+wall, - wall + (yc - 84)/2, z - 72 - 1]) lvl_tile(21, 73, 84, wall, 72);
        translate([s+wall, yc/2, z]) hull() {
            sphere(r = 20);
            translate([21, 0, 0]) sphere(r = 20);
        }
        translate([s+wall+21, yc/2, z]) hull() {
            translate([0, 0, 0]) sphere(r = 20);
            translate([x-s-(wall+21)-(wall+39+wall+47), -(yc-yt)/2, 0]) sphere(r = 20);
        }
        // solo cards
        translate([wall, wall, bottom]) cube([45, 21, 50]);
        translate([(45-43.5)/2+wall, yc-wall-29.5, bottom]) cube([43.5, 29.5, 50]);
        // waves
        translate([(45-43.5)/2+wall, wall + 21 + wall, bottom]) tray_rounded([43.5, yc - (wall + 29.5 + wall + wall + 21 + wall), 50]);
    }
}
module lvl_tile(x_tile, yb_tile, ym_tile, w, h) {
    y = w + ym_tile + w;
    hull() {
        translate([0, (y-yb_tile)/2, 0]) cube([x_tile, yb_tile, 1]);
        translate([0, (y-ym_tile)/2, h/2]) cube([x_tile, ym_tile, h]);
    }
    // translate([-w, y/2, height]) rotate([0, 90, 0]) cylinder(w + x_tile + w, r = 20);
}
module guardian_tile(x, y) {
    z = height;
    o = 6.5;
    oy = 53;
    difference() {
        translate([0,0,0]) cube([x,y,z]);
        translate([0,(y-oy)/2,0]) cube([x,oy,o]);
    }
}
translate([x_player_tray + x_card_tray, 0, 0]) big_tile_tray();

// disclaimer: this tray is a little botched and may need adjustments when you modify the parameters 
module campaign_tray() {
    x = x_campaign_tray;
    y = wall + 123 + wall;
    z = height;
    o = 11;
    xc = y_card_tray;
    yc = 33;
    b = 40-(x-83);
    difference() {
        union() {
            difference() {
                union() {
                    cube_rounded([x,y+20,z], tray_r);
                    translate([x-xc, 206-y_tiles, 0]) cube_rounded([xc,box_width-y-y_tiles,z], tray_r);
                }
                cube_rounded([x,y+20,o], tray_r);
                translate([(x-83)/2, (x-83)/2, o + bottom]) cube([83, 123, 90]);

                translate([b/2, b/2 + 3, 0]) cube_rounded([x-b,y-b,o + bottom], 5);
                // cards
                translate([x/2, y, z]) rotate([-90, 0, 0]) cylinder(x_card_tray, r = 20);
            }
            cube_rounded([x,y_card_tray - y_tiles - 1,o], tray_r);
            translate([x-xc, 206-y_tiles, 0]) cube_rounded([xc,box_width-y-y_tiles,o], tray_r);
        }
        translate([x-xc+wall, 206-y_tiles+5.5, bottom_card_trays]) cube([sleeved_card_l + sleeved_card_c, yc, 90]);
        translate([-20,wall+y-20+4, 0]) cube_rounded([20, 20, 19], 0.5);
    }
}
translate([box_length - x_campaign_tray, wall + 77 + wall, 0]) campaign_tray();


x_token = (box_length - (wall + sleeved_card_l + sleeved_card_c + wall) - 1);
module token_tray(factor = 0.5) {
    y = 39;
    x = x_token * factor;
    z = height/3;
    r = tray_r;
    union() {
        difference() {
            translate([r,r,0]) minkowski(){
                difference() {
                    cube([x-(2*r), y-(2*r), z-r]);
                    translate([x-(1*r), (y-(2*r))/2, 0]) cylinder(z, r=15);
                }
                cylinder(r,r,r);
            }
            translate([wall, wall, bottom]) tray_rounded([x-2*wall-15+r, y - 2*wall, z], 5);
        }
        // for glueing, comment out if you'd rather keep the trays seperate
        translate([x-10, 0, 0]) cube([10, (y-2*15+2*r)/2, z]);
        translate([x-10, y-(y-2*15+2*r)/2, 0]) cube([10, (y-2*15+2*r)/2, z]);
    }
}
y_token = 39;
module double_token_tray(factor = 0.5) {
    y = y_token;
    x = x_token;
    z = height/3;
    r = tray_r;
    difference() {
        translate([r,r,0]) minkowski(){
            cube([x-(2*r), y-(2*r), z-r]);
            cylinder(r,r,r);
        }
        translate([wall, wall, bottom]) tray_rounded([factor*x-2*wall-15+r, y - 2*wall, z], 5);
        translate([factor*x, y/2, 0]) cylinder(z, r=15-r);
        translate([x-((1-factor)*x-2*wall-15)-wall-r, wall, bottom]) tray_rounded([(1-factor)*x-2*wall-15+r, y - 2*wall, z], 5);
    }
}
translate([0,box_width-y_token,0]) token_tray();
translate([x_token*2*0.5,box_width-y_token,0]) mirror([1,0,0]) token_tray();
// translate([0,box_width-y_token,0]) double_token_tray(0.5);
translate([0,box_width-y_token,height/3]) token_tray(0.5);
translate([x_token*2*0.5,box_width-y_token,height/3]) mirror([1,0,0]) token_tray();
translate([0,box_width-y_token,2*height/3]) token_tray();
translate([x_token*2*0.5,box_width-y_token,2*height/3]) mirror([1,0,0]) token_tray();

x_temple_tray = wall + 150 + wall;
module temple_tray() {
    x = x_temple_tray;
    // y = box_width - y_token - y_card_tray - 1;
    y = 115;
    z = 39;
    b = y-105;
    difference() {
        cube_rounded([x, y, z]);
        translate([wall,wall,2]) cube_rounded([x-2*wall, y-2*wall, z]);
        translate([b+wall,b+wall,0]) cube_rounded([x-2*(b+wall), y-2*(b+wall), z], 5);
    }
}
translate([0,y_card_tray,height-39]) temple_tray();

x_assistant_research_tray = box_length - x_temple_tray - 1 - y_card_tray;
echo(y_tiles);
// x_assistant_research_tray = 265 - x_temple_tray;
module assistant_research_tray() {
    x = x_assistant_research_tray;
    // y = box_width - y_token - y_card_tray - 1;
    y = 115;
    z = 39;
    // xa = 53;
    xa = (x-3*wall)/2;
    difference() {
        cube_rounded([x, y, z]);
        translate([wall,wall,2]) tray_rounded([xa, y-2*wall, z]);
        translate([wall + xa + wall,wall,2]) tray_rounded([xa, y-2*wall, z]);
    }
}
translate([x_temple_tray,y_card_tray,height-39]) assistant_research_tray();
