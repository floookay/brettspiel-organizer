$fn = 200;

x=187;
y=132;
z=36.6;
b=5;

xt=90;
yt=y-2*b;
zt=(z-b)/2-0.4;
ztp=zt-2;
ztl=b;

module box() {
    oc=z-25;
    rc=20;
    difference() {
        hull() {
            translate([1,1,0]) cube_rounded(v = [x-2,y-2,z], r=4);
            translate([0,0,1]) cube_rounded(v = [x,y,z-1], r=4);
        }
        
        
        // cards
        translate([b,(y-93)/2,oc]) cube_rounded(v = [60,93,60]);
        translate([-5,y/2,oc]) union() {
            translate([0,-rc-b/2,0]) cube([b+10,rc*2+b,60]);
            translate([70,0,0]) cylinder(h = 60, r = rc);
            // resize(newsize=[2*rc,2*rc,10]) sphere(r = rc);
            translate([70,0,0]) resize(newsize=[2*rc,2*rc,15]) sphere(r = rc);
        }


        xp=(xt-0.6)/2;
        yp=(yt-0.6)/2;
        translate([x-xt-b,(y-yt)/2,b]) difference() {
            cube_rounded(v = [xt,yt,z], r=10+b+0.3);
            translate([xt/2,yt/2,0]) difference() {
                translate([0,0,ztp/2]) cube([30,30,ztp], center=true);
                translate([b+10,b+10,0]) cylinder(h=ztp+1, r=10+b+1);
                translate([-(b+10),-(b+10),0]) cylinder(h=ztp+1, r=10+b+1);
                translate([b+10,-(b+10),0]) cylinder(h=ztp+1, r=10+b+1);
                translate([-(b+10),b+10,0]) cylinder(h=ztp+1, r=10+b+1);
            }
        }
        translate([x-xt/2-b-40/2,-1,b]) cube([40,b+2,z]);
        translate([x-xt/2-b-40/2,y-b-1,b]) cube([40,b+2,z]);
    }
    translate([b/2,y/2+rc+b/2,1]) cylinder(h=z-1, r=b/2);
    translate([b/2,y/2-rc-b/2,1]) cylinder(h=z-1, r=b/2);


    translate([x-xt/2-b-40/2,b/2,1]) cylinder(h=z-1, r=b/2);
    translate([x-xt/2-b-40/2+40,b/2,1]) cylinder(h=z-1, r=b/2);
    translate([x-xt/2-b-40/2,-b/2+y,1]) cylinder(h=z-1, r=b/2);
    translate([x-xt/2-b-40/2+40,-b/2+y,1]) cylinder(h=z-1, r=b/2);
}

module tray_money() {
    difference() {
        hull() {
            translate([1,1,0]) cube_rounded(v=[xt-0.6-2,yt-0.6-2,zt],r=10+b);
            translate([0,0,1]) cube_rounded(v=[xt-0.6,yt-0.6,zt-1],r=10+b);
        }
        translate([b,b,2]) tray_rounded(v=[xt-0.6-2*b,yt-0.6-2*b,zt],r=10);
        translate([(xt-0.6-30)/2,0,zt]) hull() {
            sphere(r = 2);
            translate([30,0,0]) sphere(r = 2);
        }
        translate([(xt-0.6-30)/2,yt-0.6,zt]) hull() {
            sphere(r = 2);
            translate([30,0,0]) sphere(r = 2);
        }
    }
}
module lid_money() {
    difference() {
        hull() {
            translate([1,1,0]) cube_rounded(v=[xt-0.6-2,yt-0.6-2,ztl],r=10+b);
            translate([0,0,1]) cube_rounded(v=[xt-0.6,yt-0.6,ztl-1],r=10+b);
        }
        translate([0,0,2]) difference() {
            cube([xt-0.6,yt-0.6,ztl]);
            translate([b,b,0]) cube_rounded([xt-0.6-2*b,yt-0.6-2*b,ztl],r=10);
        }
        translate([b*2,b*2,2]) cube_rounded([xt-0.6-4*b,yt-0.6-4*b,ztl],r=10-b);

    }
}
module tray_players() {
    difference() {
        hull() {
            translate([1,1,0]) cube_rounded(v=[xt-0.6-2,yt-0.6-2,ztp],r=10+b);
            translate([0,0,1]) cube_rounded(v=[xt-0.6,yt-0.6,ztp-1],r=10+b);
        }
        xp=(xt-0.6-2*b)/2-b/2;
        yp=(yt-0.6-2*b)/2-b/2;
        translate([b,b,2]) tray_rounded(v=[xp,yp,ztp],r=10);
        translate([b+xp+b,b,2]) tray_rounded(v=[xp,yp,ztp],r=10);
        translate([b+xp+b,b+yp+b,2]) tray_rounded(v=[xp,yp,ztp],r=10);
        translate([b,b+yp+b,2]) tray_rounded(v=[xp,yp,ztp],r=10);
    }
}

module tray_player() {
    xp=(xt-0.6)/2;
    yp=(yt-0.6)/2;
    difference() {
        hull() {
            translate([1,1,0]) cube_rounded(v=[xp-2,yp-2,ztp],r=10+b);
            translate([0,0,1]) cube_rounded(v=[xp,yp,ztp-1],r=10+b);
        }
        translate([b/2,b/2,2]) tray_rounded(v=[xp-b,yp-b,ztp],r=10+b/2);
    }
}
box();
// translate([x-xt-b,b,b]) tray_player();

// tray_money();
// translate([0,0,10]) lid_money();



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