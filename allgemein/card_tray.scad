/**
 * The overall design of the card holder is based on js500's card trays for
 * various board games on printables, e.g. https://www.printables.com/model/449323
 *
 * I rebuilt the card holder from scratch with a parametric design for my own inserts 
 * because of the variable height that's usually available.
 * You can either set a desired outer parameters or the inner parameters (space for cards)
 * of the card holder.
 *
 * @author Florian Scheibeck <info@floookay.de>
 * @license this code is licensed under the terms of the GNU GPL version 3 (or later)
 */

// # configuration
$fn=200;	// for rendering
// $fn=20;	// for previewing

csl=90;	// card size length (with leeway)
csw=65;	// card size width (with leeway)

// basic parameters
r = 3;	// radius of the corners of the holder 
b = 1.2;	// height of the bottom
lw=5;	// extra thickness on the front and back walls
wt=2;	// thickness of the holder side walls (must be a multiple of the nozzle size)
cutout = true;	// cutout on the bottom

// length of the holder - set either variable
lh=150;	// total length of the holder (space for cards will be calculated)
lc=0;	// space for the cards (total length of the holder will be calculated)

// width of the holder - optional
wh=0;	// total width of the holder

// height of the holder - set either variable
hh=60;	// total height of the holder
ha=0;	// angle of the cards in the holder (in degrees, over 45 degrees for)

// divider
dividers = true;
d=3;	// thickness of the divider
dsh=20;	// height of the divider slot
dsl=1;	// divider slot leeway
dg=15;	// divider gap / spacing

// generation
card_holder();
divider();

echo(length=l);
echo(cardstack_length=cl);
echo(width=w);
echo(height=h);
echo(angle=a);
// # end of configuration


// # modeling
// size calculations
h = hh > 0 ? hh : sin(ha)*csw + b;
a = ha > 0 ? ha : asin((h-b)/csw);
l = lh > 0 ? lh : lw + lc + cos(a)*csw + lw;
w = wh > 0 ? wh : wt + csl + wt;
ww = wh == 0 ? wt : (wh - csw)/2;
cl = lc > 0 ? lc : l-lw-cos(a)*csw-lw;
rhombus_faces = [[0,1,2,3],[4,5,1,0],[7,6,5,4],[5,6,2,1],[6,7,3,2],[7,4,0,3]];

// card tray
xs = cos(a)*csw;	// x shift
zt = sin(a)*csw;	// card tray height
tray_points = [
	[0,0,0],[cl,0,0],[cl,csl,0],[0,csl,0],	// bottom
	[xs,0,zt],[cl+xs,0,zt],[cl+xs,csl,zt],[xs,csl,zt] // shifted top
];
module card_tray() {
	translate(v = [lw,ww,b]) polyhedron(points=tray_points, faces=rhombus_faces);
}

// divider
module divider_slot() {
	rds = 20;
	translate(v = [0,0,h])
	rotate([0,90-a,0])
	union() {
		rotate([-90,0,0])
		union() {
			cube_rounded(v=[d+dsl,dsh,w], r=0.5);
			translate(v = [-rds,rds/2,0]) difference() {
				translate(v = [0,-rds-10,0]) cube([rds+d+dsl,rds+10,w]);
				cylinder(h = w, r = rds);
			}
		}
	}
}
module divider() {
	difference() {
		translate(v = [50,0,h+b])
		rotate([0,180-a,0])
		union() {
			cube_rounded(v=[dsh,w,d], r=1);
			translate(v=[0,ww+dsl/2,0]) cube_rounded(v=[csw-dsl,w-2*ww-dsl,d], r=2);
		}
		groove();
	}
}

// groove
rgs = 5;	// small upper radius of the groove
rg = h/2-rgs;	// radius of the groove
module groove() {
	translate(v = [0,w/2,h]) union() {
		translate(v = [0,-w/2,0]) cube([l,w,20]);
		translate(v = [0,0,-rgs]) rotate([0,90,0]) cylinder(h=l, r=rg);
		translate(v = [0,-rg-rgs,-rgs]) difference() {
			cube([l,rg*2+rgs*2,rgs]);
			rotate([0,90,0]) cylinder(h=l, r=rgs);
			translate(v = [0,rg*2+rgs*2,0]) rotate([0,90,0]) cylinder(h=l, r=rgs);
		}
	}
}

// building the holder
module card_holder() {
	difference() {
		cube_rounded(v = [l,w,h], r = r);
		card_tray();
		groove();
		if(dividers)
		{
			nd = floor(cl/dg);
			for (i = [1:nd]) {
				translate(v = [l-lw-i*dg,0,0]) divider_slot();
			}
		}
		if(cutout)
		{
			translate(v = [lw,w/2-rg,0]) 
			cube_rounded(v = [cl,2*rg,b], r = rgs);
		}
		// translate(v = [-1,-1,-1]) cube([l+2,w/2+1,h+2]);	// for testing / cut holder in half
	}
}

// helper functions
module cube_rounded(v, r, center=false){
	translate(center==true ? [r-v[0]/2,r-v[1]/2,v[2]/2] : [r,r,0])
	hull(){
		cylinder(h = v[2], r = r);
		translate(v = [0,v[1]-2*r,0]) cylinder(h = v[2], r = r);
		translate(v = [v[0]-2*r,v[1]-2*r,0]) cylinder(h = v[2], r = r);
		translate(v = [v[0]-2*r,0,0]) cylinder(h = v[2], r = r);
	}
}

// # end of modeling