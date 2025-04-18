$fn = 200;

box=285;
boxz=72;

rules=10;
boards=20;

cardl=88;
cardw=53;

w_min=1.6;
cardsy=w_min+cardl+w_min;
cardsx=200;
cardsz=boxz-rules-boards;
echo(cardsz);

miscy=108;
miscx=box-cardsx-1;
miscz=70;
miscxi=miscx-w_min*2-0.2;
misczi=miscz-w_min-0.2;
miscyi=miscy-w_min*2-0.8;

magnetz=2;
magnetr=10.2/2;

module box() {
    color("grey") difference() {
        translate([-1,-1,-1]) cube([box+2,box+2,boxz+1]);
        cube([box,box,boxz+1]);
    }
}
// box();

module cards_full_placeholder(y) {
    color("lightblue") cube([cardsx,y,cardsz]);
}
// translate([box-cardsx,box-cardsy,0]) cards_full_placeholder(cardsy);
// translate([box-cardsx,box-cardsy-0.5-cardsy,0]) cards_full_placeholder(cardsy);
// translate([box-cardsx,box-cardsy-0.5-cardsy-0.5-cardsy,0]) cards_full_placeholder(cardsy);

module misc_drawer() {
    color("lightyellow") difference() {
        cube_rounded([miscx,miscy,miscz], r=1);
        translate([w_min,w_min,w_min]) cube([miscx-w_min*2,miscy-w_min*2,miscz]);
        translate([miscx/2,w_min,0]) rotate([-90,0,0]) cylinder(h=miscy-2*w_min, r=20);
    }
}
// misc_drawer();

miscz_player = 15;
miscz_duell = 19;
miscz_token = 20;
miscz_eggs = miscyi-miscz_player-miscz_duell-miscz_token;

module misc_player() {
    color("lightgreen") difference() {
        cube_rounded([miscxi,misczi,miscz_player], r=1);
        xtray=(miscxi-4*w_min)/3;
        ytray=(misczi-3*w_min)/2;
        for (i = [0:2]) {
            for (j = [0:1]) {
                translate([w_min+i*(xtray+w_min),w_min+j*(ytray+w_min),w_min]) tray_rounded([xtray,ytray,20],r=5);
            }
        }
        xicon=(miscxi-30)/6;
        cubex=5;
        for (i=[0:5]) {
            translate([w_min+15+cubex/2+i*xicon,-cubex/2+0.8,miscz_player/2]) cube(cubex, center=true);
            translate([w_min+15+cubex/2+i*xicon,misczi+cubex/2-0.8,miscz_player/2]) cube(cubex, center=true);
        }
    }
}
// translate([0,miscz_player,0])
// translate([w_min,w_min,w_min]) rotate([90,0,0])
// misc_player();

module misc_duell() {
    color("white") difference() {
        cube_rounded([miscxi,misczi,miscz_duell], r=1);
        offset=2;
        yingyangr=misczi-2*w_min-offset;
        translate([miscxi/2+offset*3,misczi/2,w_min+offset]) ying_yang(yingyangr,20);
        translate([miscxi/2-offset*3,misczi/2,w_min+offset]) rotate([0,0,180]) ying_yang(yingyangr,20);
        iconr=10;
        translate([miscxi/2+2,0.8,miscz_duell/2]) rotate([90,0,0]) ying_yang(iconr,iconr);
        translate([miscxi/2-2,0.8,miscz_duell/2]) rotate([90,0,0]) rotate([0,0,180]) ying_yang(iconr,iconr);
        translate([0,misczi+iconr-2*0.8,0]) translate([miscxi/2+2,0.8,miscz_duell/2]) rotate([90,0,0]) ying_yang(iconr,iconr);
        translate([0,misczi+iconr-2*0.8,0]) translate([miscxi/2-2,0.8,miscz_duell/2]) rotate([90,0,0]) rotate([0,0,180]) ying_yang(iconr,iconr);
    }
}
module ying_yang(r,h){
    rotate([0,0,90]) linear_extrude(h){
        union(){
            difference(){
                difference(){
                    circle(r=r/2);
                    translate([-r/2,0]) square([r,r/2]);
                }
                translate([-r/4,0]) circle(r=r/4);
            }
            translate([r/4,0]) circle(r=r/4);
        }
    }
}
// translate([0,miscz_player+miscz_duell,0])
// translate([w_min,w_min,w_min]) rotate([90,0,0])
// misc_duell();

module misc_tokens(){
    color("yellow") difference() {
        cube_rounded([miscxi,misczi,miscz_token], r=1);
        translate([w_min,w_min,w_min]) tray_rounded([miscxi-2*w_min,misczi-2*w_min,miscz_token]);
        xicon=(miscxi-30)/6;
        cubex=10;
        translate([miscxi/2,-cubex/2+0.8,miscz_token/2]) icontoken(cubex);
        translate([miscxi/2,misczi+cubex/2-0.8,miscz_token/2]) icontoken(cubex);
    }
}
module icontoken(x) {
    rotate([90,0,0]) difference() {
        cube(x, center=true);
        translate(v = [0,0,-x/2+0.2]) difference() {
            cube([x,x,0.4], center=true);
            rotate([0,0,45]) cube([x,x,0.4],center=true);
        }
        translate(v = [0,0,x/2-0.2]) difference() {
            cube([x,x,0.4], center=true);
            rotate([0,0,45]) cube([x,x,0.4],center=true);
        }
    }
}
// translate([0,miscz_player+miscz_duell+miscz_token,0])
// translate([w_min,w_min,w_min]) rotate([90,0,0])
// misc_tokens();

module misc_eggs(){
    color("orange") difference() {
        cube_rounded([miscxi,misczi,miscz_eggs], r=1);
        translate([w_min,w_min,w_min]) tray_rounded([miscxi-2*w_min,misczi-2*w_min,miscz_eggs]);
        xicon=(miscxi-30)/6;
        cubex=10;
        translate([miscxi/2,0.8,miscz_eggs/2]) rotate([90,0,0]) linear_extrude(height = cubex) scale(0.06) import("./svg/egg.svg",center=true);
        translate([miscxi/2,misczi+cubex-0.8,miscz_eggs/2]) rotate([90,0,0]) linear_extrude(height = cubex) scale(0.06) import("./svg/egg.svg",center=true);
        // translate([miscxi/2,misczi+cubex/2-0.8,miscz_token/2]) icontoken(cubex);
    }
}
translate([0,miscz_player+miscz_duell+miscz_token+miscz_eggs,0])
translate([w_min,w_min,w_min]) rotate([90,0,0])
misc_eggs();


// helpers
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
    translate(center==true ? [r-v[0]/2,r-v[1]/2,v[2]/2] : [r,r,0])
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