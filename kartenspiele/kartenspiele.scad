// configuration
$fn=100;
w=1.2;
r=1;
ri=w-r;
x=77.5;
z=95;


// generation
// basic(yc=15,yr=2);	// food chain island
// basic(yc=20,yr=2);	// sprawlopolis
// basic(yc=16,yr=2);	// agropolis
// basic(yc=17,yr=2);	// palm island
// basic(yc=14,yr=2);	// circle the wagon
// basic(yc=14,yr=2);	// hätte wäre wenn
// basic(yc=14,yr=2,ym=5);	// gegensatz
// basic(yc=14,yr=2);	// geschickt gesteckt
// basic(yc=28,yr=4);	// sedlec
// basic(yc=8,yr=2);	// death valley
// basic(yc=14,yr=2);	// liberation
// basic(yc=14,yr=2);	// avignon


// modules
module basic(yc=10,yr=2,ym=0) {
	y = yr > 0
		? ym > 0
			? w+ym+w+yc+w+yr+w
			: w+yc+w+yr+w
		: ym > 0
			? w+ym+w+yc+w
			: w+yc+w;
	difference() {
		cube_rounded(v = [x,y,z], r=r);
		if(yr>0) {
			translate(v = [w,y-w-yr,w]) cube_rounded(v = [x-2*w,yr,z], r=ri);
		}
		translate(v = [w,w+(ym>0?w+ym:0),w]) cube_rounded(v = [x-2*w,yc,z], r=ri);
		if(ym>0) {
			translate(v = [w,w,w]) cube_rounded(v = [x-2*w,ym,z], r=ri);
		}
		translate(v = [x/2,-0.5,z]) union() {
			rg = x/3;
			rgs = rg/4;
			translate(v = [0,0,-rgs]) rotate([-90,0,0]) cylinder(h=y+1, r=rg);
			translate(v = [0,0,-rgs])
			difference() {
				translate(v = [-rg-rgs,0,0]) cube([2*rg+2*rgs,y+1,rgs]);
				translate(v = [-rg-rgs,0,0]) rotate([-90,0,0]) cylinder(h=y+1, r=rgs);
				translate(v = [rg+rgs,0,0]) rotate([-90,0,0]) cylinder(h=y+1, r=rgs);
			}
		}
	}
}

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