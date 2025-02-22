$fn = 50;

// magnet
mz=2;
mr=5 + 0.1;

// rubber bumper
rbr=(20+1)/2;
rbh=1;
rbo=15;

// heroine/action boards
bx=128;
by=210; // max bed size
// by=227.85;
bz=mz + 0.4;
br=3;

// sight board
sbx=160;

// general
module magnet_row(bullets = 5, gap = 30, height = 5) {
    for (i = [0:bullets - 1]) {
        translate(v = [i*gap, 0, 0]) cylinder(h = height, r = mr);
    }
}
module screw(){
    union(){
        cylinder(h=6, r=3/2);
        cylinder(h=6/2, r1=6/2, r2=0);
    }
}
module board_screw() {
    translate(v = [0,0,bz]) rotate(a=180, v=[1,0,0]) screw();
}
module rubber_bumper() {
    cylinder(h = rbh, r = rbr);
}


module action_board() {
    gy = 176/7;
    oy = 131/3;
    h = 10;
    oz = 0.4; 
    so = 10;
    difference() {
        cube([bx,by,bz]);
        translate(v = [16,202,-h+bz-oz]) rotate(a = -90, v = [0,0,1]) magnet_row(bullets = 8, gap = gy, height = h);
        for(i = [0:3]) {
            translate(v = [53, 191-i*oy, -h+bz-oz]) magnet_row(bullets = 2, gap = 43, height = h);
        }
        translate(v = [so,so,0]) board_screw();
        translate(v = [bx-so,so,0]) board_screw();
        translate(v = [bx-so,by-so,0]) board_screw();
    }
}
// translate(v=[bx+sbx,0,0]) action_board();
translate(v=[bx+sbx,0,0]) bottom_piece(bx);


module sight_board() {
    ox = 22.5 + 1;
    gx = 113.2/4;
    oy = 141/5;
    h = 10;
    oz = 0.4;
    so = 10;
    difference() {
        cube([sbx,by,bz]);
        for(i = [0:5]) {
            translate(v = [ox, 189-i*oy, -h+bz-oz]) magnet_row(bullets = 5, gap = gx, height = h);
        }
        translate(v = [ox, 17.5, -h+bz-oz]) magnet_row(bullets = 5, gap = gx, height = h);
        translate(v = [so,so,0]) board_screw();
        translate(v = [sbx-so,so,0]) board_screw();
        translate(v = [so,by-so,0]) board_screw();
        translate(v = [sbx-so,by-so,0]) board_screw();
    }
}
// translate(v=[bx,0,0]) sight_board();
translate(v=[bx,0,0]) bottom_piece(sbx);

module heroine_board() {
    ox = 25.8;
    gx = 78.5/6;
    h = 10;
    oz = 0.4;
    so = 10;
    difference() {
        cube([bx,by,bz]);
        translate(v = [ox, 17, -h+bz-oz]) magnet_row(bullets = 7, gap = gx, height = h);
        translate(v = [so,so,0]) board_screw();
        translate(v = [bx-so,so,0]) board_screw();
        translate(v = [so,by-so,0]) board_screw();
        translate(v = [bx-so,by-so,0]) board_screw();
        translate(v = [bx-20,189,-h+bz-oz]) rotate(a = -90, v = [0,0,1]) magnet_row(bullets = 6, gap = 141/5, height = h);
    }
}
// heroine_board();
bottom_piece(bx);

module bottom_piece(x) {
    wz = 16;
    y = 8;
    oy = 1.4;
    uy = 25;
    z = bz + wz + bz + oy;
    t = 50;
    so = 10;
    intersection() {
        translate(v = [0,20,-sqrt(2*t^2)/2-(wz+bz-z/2)]) rotate(a = 45, v = [1,0,0]) cube([x,t,t]);
        difference() {
            union() {
                translate(v = [0,-y,-wz-bz]) cube([x,y + oy,z]);
                translate(v = [0,-y,-wz-bz]) cube([x,y + uy,z-bz-oy]);
            }
            cube([x,oy+10,bz]);
            translate(v = [0,0,-wz]) cube([x,uy+10,wz]);
            translate(v = [0,0,bz]) rotate(a = 45, v = [1,0,0]) translate(v = [0,0,-bz]) cube([x,oy+10,bz]);
            translate(v = [x/2,so,-wz-bz]) screw();
            translate(v = [rbo,uy/2-2,-wz-bz]) rubber_bumper();
            translate(v = [x-rbo,uy/2-2,-wz-bz]) rubber_bumper();
        }
    }
}