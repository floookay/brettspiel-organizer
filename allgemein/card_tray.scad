$fn=20;

// configuration
csl=90;	// card size length (with leeway)
csw=65;	// card size width (with leeway)

r = 2;	// radius of the corners of the holder 
b = 1.2;	// height of the bottom

// divider
dividers = false;
d=1.2;	// thickness of the divider
dsh=20;	// height of the divider slot
dsl=0.5;	// divider slot leeway

// length of the holder - set either variable
lh=0;	// total length of the holder (space for cards will be calculated)
lc=100;	// space for the cards (total length of the holder will be calculated)
lw=5;	// extra thickness of the front and back walls

// width of the holder - set either variable
wh=0;	// total width of the holder
ww=2;	// thickness of the holder side walls (must be a multiple of the nozzle size)

// height of the holder - set either variable
hh=60;	// total height of the holder
ha=0;	// angle of the cards in the holder (in degrees, over 45 degrees for)

// size calculations
h = hh > 0 ? hh : sin(ha)*csw + b;
a = ha > 0 ? ha : asin((h-b)/csw);
l = lh > 0 ? lh : lw + lc + cos(a)*csw + lw;
w = wh > 0 ? wh : ww + csl + ww;
rhombus_faces = [[0,1,2,3],[4,5,1,0],[7,6,5,4],[5,6,2,1],[6,7,3,2],[7,4,0,3]];
cl = lc > 0 ? lc : l-lw-cos(a)*csw-lw;
echo(length=l);
echo(width=w);
echo(height=h);
echo(angle=a);

// card tray
xs = cos(a)*csw;	// x shift
zt = sin(a)*csw;	// card tray height
tray_points = [
	[0,0,0],[cl,0,0],[cl,csl,0],[0,csl,0],	// bottom
	[xs,0,zt],[cl+xs,0,zt],[cl+xs,csl,zt],[xs,csl,zt] // shifted top
];

// divider
xsd = cos(a)*dsh;	// x shift
divider_slot_points = [
	[0,0,0],[d+dsl,0,0],[d+dsl,w,0],[0,w,0],	// bottom
	[xsd,0,dsh],[d+xsd+dsl,0,dsh],[d+xsd+dsl,w,dsh],[xsd,w,dsh] // shifted top
];
module divider_slot() {
	translate(v = [0,0,h-dsh]) polyhedron(points=divider_slot_points, faces=rhombus_faces);
}
divider_points = [
	[0,0,0],[d,0,0],[d,w,0],[0,w,0],	// bottom
	[xsd,0,dsh],[d+xsd,0,dsh],[d+xsd,w,dsh],[xsd,w,dsh] // shifted top
];
module divider() {
	// todo
	union() {
		polyhedron(points=divider_points, faces=rhombus_faces);
	}
}

// groove
rgs = 5;	// small upper radius of the groove
rg = h/2-rgs;	// radius of the groove
module groove() {
	translate(v = [0,w/2,h]) union() {
		translate(v = [0,0,-rgs]) rotate([0,90,0]) cylinder(h=l, r=rg);
		translate(v = [0,-rg-rgs,-rgs]) difference() {
			cube([l,rg*2+rgs*2,rgs]);
			rotate([0,90,0]) cylinder(h=l, r=rgs);
			translate(v = [0,rg*2+rgs*2,0]) rotate([0,90,0]) cylinder(h=l, r=rgs);
		}
	}
}

// building the holder
difference() {
	cube_rounded(v = [l,w,h], r = r);
	translate(v = [lw,ww,b]) polyhedron(points=tray_points, faces=rhombus_faces);
	groove();
	if(dividers)
	{
		divider_slot();
	}
	// translate(v = [-1,-1,-1]) cube([l+2,w/2+1,h+2]);	// for testing / cut tray in half
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
