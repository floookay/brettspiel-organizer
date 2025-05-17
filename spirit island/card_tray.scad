$fn = 200;

z=47;
x=282;
y=450;

x_tray = 91.7+1.6*2;
echo(x_tray*3);
// y_tray = (y-2*10-1)/2;
y_tray = (y-2*10-1)/2 - 30; //* for shorter

b=1.2;

magnet_h = 2;
magnet_r = 10.2/2;
magnet_z = 10+magnet_r;
magnet_zs = magnet_z+10;
magnet_x = magnet_z;
magnet_y = magnet_z;

guard_y = 10;
guard_x = x_tray*3;
guard_z = magnet_z + magnet_r + 3;

cylinder_r = 15;
cylinder_h = 3;

module tray() {
    difference() {
        // translate([x_tray,0,0]) rotate([0,0,90]) import("./stl/card_tray/card-tray-vanilla.stl");
        translate([x_tray,0,0]) rotate([0,0,90]) import("./stl/card_tray/card-tray-shorter-vanilla.stl");
        // front
        translate([magnet_x,0,magnet_z]) rotate([-90,0,0]) cylinder(h=magnet_h, r=magnet_r);
        translate([x_tray-magnet_x,0,magnet_z]) rotate([-90,0,0]) cylinder(h=magnet_h, r=magnet_r);
        // back
        translate([magnet_x,y_tray-magnet_h,magnet_z]) rotate([-90,0,0]) cylinder(h=magnet_h, r=magnet_r);
        translate([x_tray-magnet_x,y_tray-magnet_h,magnet_z]) rotate([-90,0,0]) cylinder(h=magnet_h, r=magnet_r);
        // left
        translate([0,magnet_y,magnet_zs]) rotate([0,0,-90]) rotate([-90,0,0]) cylinder(h=magnet_h, r=magnet_r);
        translate([0,y_tray-magnet_y,magnet_zs]) rotate([0,0,-90]) rotate([-90,0,0]) cylinder(h=magnet_h, r=magnet_r);
        // right
        translate([x_tray-magnet_h,magnet_y,magnet_zs]) rotate([0,0,-90]) rotate([-90,0,0]) cylinder(h=magnet_h, r=magnet_r);
        translate([x_tray-magnet_h,y_tray-magnet_y,magnet_zs]) rotate([0,0,-90]) rotate([-90,0,0]) cylinder(h=magnet_h, r=magnet_r);
        // bottom
        translate([x_tray/2,y_tray-cylinder_r-10,0]) cylinder(h=cylinder_h+0.4, r=cylinder_r+0.4);
    }
}
// tray();
module tray_small_cards() {
    difference() {
        cube_rounded([x_tray,y_tray,z-10]);
        // cards
        w=1.6;
        b=1.2;
        cx=72.5;
        cyb=38;
        cy=31;
        // translate([magnet_h+w,w,b]) card_compartment(cy);
        //cube([cx,cyb,z]);
        // translate([x_tray-cx-w-magnet_h,y_tray-w-cy-15.7,b+3]) card_compartment();
        //cube([cx,cyb,z]);
        for (i=[0:4]) {
            xo = i%2==1 ? magnet_h+w : x_tray-cx-w-magnet_h;
            yo = i * (cy + w);
            translate([xo,magnet_h+w+yo,b]) card_compartment();
            //cube([cx,cy,z]);
        }
        // front
        translate([magnet_x,0,magnet_z]) rotate([-90,0,0]) cylinder(h=magnet_h, r=magnet_r);
        translate([x_tray-magnet_x,0,magnet_z]) rotate([-90,0,0]) cylinder(h=magnet_h, r=magnet_r);
        // back
        translate([magnet_x,y_tray-magnet_h,magnet_z]) rotate([-90,0,0]) cylinder(h=magnet_h, r=magnet_r);
        translate([x_tray-magnet_x,y_tray-magnet_h,magnet_z]) rotate([-90,0,0]) cylinder(h=magnet_h, r=magnet_r);
        // left
        translate([0,magnet_y,magnet_zs]) rotate([0,0,-90]) rotate([-90,0,0]) cylinder(h=magnet_h, r=magnet_r);
        translate([0,y_tray-magnet_y,magnet_zs]) rotate([0,0,-90]) rotate([-90,0,0]) cylinder(h=magnet_h, r=magnet_r);
        // right
        translate([x_tray-magnet_h,magnet_y,magnet_zs]) rotate([0,0,-90]) rotate([-90,0,0]) cylinder(h=magnet_h, r=magnet_r);
        translate([x_tray-magnet_h,y_tray-magnet_y,magnet_zs]) rotate([0,0,-90]) rotate([-90,0,0]) cylinder(h=magnet_h, r=magnet_r);
        // bottom
        // translate([x_tray/2,y_tray-cylinder_r-10,0]) cylinder(h=cylinder_h+0.4, r=cylinder_r+0.4);
        translate([x_tray/2,-10,0]) rotate([-90,0,0]) cylinder(h=y_tray+20, r=37/2);
    }
}
tray_small_cards();
// translate([0,-20,0]) guard();

csl=72.5;	// card size length (with leeway)
csw=49;	// card size width (with leeway)
// basic parameters
r=3;	// radius of the corners of the holder 
b=1.2;	// height of the bottom
lw=5;	// extra thickness on the front and back walls
wt=1.6;	// thickness of the holder side walls (must be a multiple of the nozzle size)
cutout = true;	// cutout at the bottom for card retrieval

// length of the holder - set either variable
lh=(450-2*10-1)/2;	// total length of the holder (space for cards will be calculated)
lc=0;	// space for the cards (total length of the holder will be calculated)
lfd=[];	// spacing between the fixed parameters (height of the card stack on a desk (with leeway))

// width of the holder - optional
wh=0;	// total width of the holder

// height of the holder - set either variable
hh=47;	// total height of the holder
ha=0;	// angle of the cards in the holder (in degrees, over 45 degrees for)
h = hh > 0 ? hh : sin(ha)*csw+b;	// calculated total height of the holder
a = ha > 0 ? ha : asin((h-b)/csw);	// calculated angle for the cards (based on the available vertical space)
l = lh > 0	// calculated total length of the holder
	? lh
	: lc > 0
		? lw+lc+cos(a)*csw+lw
		: lw+([for(p=lfd) 1]*lfd)/sin(a)+(len(lfd)-1)*d+cos(a)*csw+lw;
w = wh > 0 ? wh : wt+csl+wt;	// calculated total width of the holder
ww = wh == 0 ? wt : (wh-csl)/2;	// calculated wall thickness for the sides
cl = 31;	// calculated total length of the card compartment
xs = cos(a)*csw;	// x shift for the upper edges of the card compartment
zt = sin(a)*csw;	// card compartment height
rhombus_faces = [[0,1,2,3],[4,5,1,0],[7,6,5,4],[5,6,2,1],[6,7,3,2],[7,4,0,3]];	// faces for the rhombus polyhedrons
card_compartment_points = [
	[0,0,0],[cl,0,0],[cl,csl,0],[0,csl,0],	// bottom points
	[xs,0,zt],[cl+xs,0,zt],[cl+xs,csl,zt],[xs,csl,zt] // shifted top points
];
module card_compartment(cy) {
	translate([csl,0,0]) rotate([0,0,90]) polyhedron(points=card_compartment_points, faces=rhombus_faces);
}
// card_compartment();

module cyl() {
    difference() {
        cylinder(h = cylinder_h-0.4, r = cylinder_r);
        translate([0,0,-1.4]) senkloch();
    }
}
// cyl();

module guard() {
    difference() {
        cube_rounded([guard_x,guard_y,guard_z],r=2);
        for (i = [0:5]) {
            o = i % 2 == 0 ? i*x_tray/2 + magnet_x : (i+1)*x_tray/2 - magnet_x;
            translate([o,guard_y-magnet_h,magnet_z]) rotate([-90,0,0]) cylinder(h=magnet_h, r=magnet_r);
        }

        for (i = [0:3]) {
            o = i % 2 == 0 ? i*y_tray/3 + 20 : (i+1)*y_tray/3 - 20;
            translate([o,guard_y/2,0]) cylinder(h=10, r = 4/2);    // M3 insert
        }
    }
}






module senkloch() {
    h=4.4;
    r=6/2;
    union() {
        cylinder(h=h, r = r/2);
        translate([0,0,h-r]) cylinder(h=r, r1=0, r2=r);
        translate([0,0,h]) cylinder(h=h, r = r);
    }
}
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



/* card-tray-vanilla see card-tray.scad:
//* front card trays are 30mm shorter!


csl=91.7;	// card size length (with leeway)
csw=67;	// card size width (with leeway)

// basic parameters
r=3;	// radius of the corners of the holder 
b=1.2;	// height of the bottom
lw=5;	// extra thickness on the front and back walls
wt=1.6;	// thickness of the holder side walls (must be a multiple of the nozzle size)
cutout = true;	// cutout at the bottom for card retrieval

// length of the holder - set either variable
lh=(450-2*10-1)/2;	// total length of the holder (space for cards will be calculated)
lc=0;	// space for the cards (total length of the holder will be calculated)
lfd=[];	// spacing between the fixed parameters (height of the card stack on a desk (with leeway))

// width of the holder - optional
wh=0;	// total width of the holder

// height of the holder - set either variable
hh=47;	// total height of the holder
ha=0;	// angle of the cards in the holder (in degrees, over 45 degrees for)

// divider
dividers=true;
d=2;	// thickness of the divider (measured horizontally = multiple of the nozzle size)
dsh=20;	// height of the divider slot
dsl=0.5;	// divider slot leeway
dg=15;	// divider gap / spacing
*/