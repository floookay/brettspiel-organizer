$fn = 200;

x=187;
y=132;
z=36.6;
b=5;

xt=90;
yt=y-2*b;
zt=(z-b)/2-0.4;

module box() {
    difference() {
        hull() {
            translate([1,1,0]) cube_rounded(v = [x-2,y-2,z], r=4);
            translate([0,0,1]) cube_rounded(v = [x,y,z-1], r=4);
        }
        
        
        // cards
        oc=z-25;
        rc=20;
        translate([b,(y-93)/2,oc]) cube_rounded(v = [60,93,60]);
        translate([-5,y/2,oc]) union() {
            hull() {
                cylinder(h = 60, r = rc);
                translate([70,0,0]) cylinder(h = 60, r = rc);
            }
            // resize(newsize=[2*rc,2*rc,10]) sphere(r = rc);
            translate([70,0,0]) resize(newsize=[2*rc,2*rc,15]) sphere(r = rc);
        }

        translate([x-xt-b,(y-yt)/2,b]) cube_rounded(v = [xt,yt,z], r=10+b+0.3);
        translate([x-xt/2-b-30/2,-5,b]) cube([30,y+10,z]);
    }
}

module tray_money() {
    difference() {
        hull() {
            translate([1,1,0]) cube_rounded(v=[xt-0.6-2,yt-0.6-2,zt],r=10+b);
            translate([0,0,1]) cube_rounded(v=[xt-0.6,yt-0.6,zt-1],r=10+b);
        }
        translate([b,b,2]) tray_rounded(v=[xt-0.6-2*b,yt-0.6-2*b,zt],r=10);
    }
}
module tray_player() {
    difference() {
        hull() {
            translate([1,1,0]) cube_rounded(v=[xt-0.6-2,yt-0.6-2,zt],r=10+b);
            translate([0,0,1]) cube_rounded(v=[xt-0.6,yt-0.6,zt-1],r=10+b);
        }
        xp=(xt-0.6-2*b)/2-b/2;
        yp=(yt-0.6-2*b)/2-b/2;
        translate([b,b,2]) tray_rounded(v=[xp,yp,zt],r=10);
        translate([b+xp+b,b,2]) tray_rounded(v=[xp,yp,zt],r=10);
        translate([b+xp+b,b+yp+b,2]) tray_rounded(v=[xp,yp,zt],r=10);
        translate([b,b+yp+b,2]) tray_rounded(v=[xp,yp,zt],r=10);
    }
}

tray_player();



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