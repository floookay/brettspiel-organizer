$fn = 200;
moreplayers = true;
difference() {
    x = 97;
    y = moreplayers ? 72 : 60;
    z = 72;
    w = 2;
    dx = (x - 4*w)/3;
    dy = moreplayers ? 13+12 : 12;
    cube_rounded(v = [x,y,z], r=2);
    translate(v = [w,w,w]) cube_rounded(v=[dx,dy,z], r=1);
    translate(v = [w+dx+w,w,w]) cube_rounded(v=[dx,dy,z], r=1);
    translate(v = [w+dx+w+dx+w,w,w]) cube_rounded(v=[dx,dy,z], r=1);
    omy = w + dy + w;
    mx = 17;
    mz = 17;
    my = 10.5;
    mw = (x - 4*mx)/5;
    translate(v = [mw,omy,z-mz-1]) meeple(mx,my,z);
    translate(v = [mw+mx+mw,omy,z-mz-1]) meeple(mx,my,z);
    translate(v = [mw+mx+mw+mx+mw,omy,z-mz-1]) meeple(mx,my,z);
    translate(v = [mw+mx+mw+mx+mw+mx+mw,omy,z-mz-1]) meeple(mx,my,z);
    translate(v = [w,omy+my+w,w]) tray_rounded(v = [x-2*w,y-omy-w-my-w,z], r=5);
    translate(v = [w,omy,w]) tray_rounded(v = [x-2*w,y-omy-w,30], r=5);
    translate(v = [w,omy,20]) intersection() {
        translate(v = [0,-20,0]) rotate(a=[-45,0,0]) cube([x,y,z]);
        tray_rounded(v = [x-2*w,y-omy-w,z], r=5);
    }
}

module meeple(mx,my,z) {
    rg = (mx-4)/2;
    rgs = 2;
    w = 0;
    l=10;
    h=10;
    cube_rounded(v=[mx,my,z], r=1);
    translate(v = [mx/2,5,h+rg+rgs/2+.5]) rotate(a = [0,0,90]) union() {
		translate(v = [0,-w/2,0]) cube([l,w,20]);
		translate(v = [0,0,-rgs]) rotate([0,90,0]) cylinder(h=l, r=rg);
		translate(v = [0,-rg-rgs,-rgs]) difference() {
			cube([l,rg*2+rgs*2,20]);
			rotate([0,90,0]) cylinder(h=l, r=rgs);
			translate(v = [0,rg*2+rgs*2,0]) rotate([0,90,0]) cylinder(h=l, r=rgs);
		}
	}
    // translate(v = [r+1,0,0]) rotate(a = [0,0,90]) rotate(a = [0,90,0]) hull() {
    //     cylinder(h = 10, r = mx/2-1);
    //     translate(v = [20,0,0]) cylinder(h = 10, r = r);
    // }
}

module cube_rounded(v, r=3, center=false){
    translate(center==true ? [r-v[0]/2,r-v[1]/2,v[2]/2] : [r,r,0])
    hull(){
        cylinder(h = v[2], r = r);
        translate(v = [0,v[1]-2*r,0]) cylinder(h = v[2], r = r);
        translate(v = [v[0]-2*r,v[1]-2*r,0]) cylinder(h = v[2], r = r);
        translate(v = [v[0]-2*r,0,0]) cylinder(h = v[2], r = r);
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