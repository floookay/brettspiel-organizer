$fn = 100;

x=54;
y=81.4;
z_max=60;

w=1.2;

mr=3.2/2;
ml=3;


z1=13;
z2=13;
zd=z_max-z1-z2-1;

translate([-x-5,0,0])
difference() {
    cube_rounded(v = [x,y,z1]);
    o=6;
    translate(v = [0,(y-(w+33+o+23))/2,0]) union() {
        translate(v = [w,w,w]) cube_rounded(v = [x-2*w,33,z1], rc=0,r=0);
        translate(v = [w,w+33+o,w]) cube_rounded(v = [x-2*w,23,z1], rc=0,r=0);
    }
    translate([mr+w,mr+w,z1-ml]) cylinder(h = 10, r = mr);
    translate([x-(mr+w),mr+w,z1-ml]) cylinder(h = 10, r = mr);
    translate([mr+w,y-(mr+w),z1-ml]) cylinder(h = 10, r = mr);
    translate([x-(mr+w),y-(mr+w),z1-ml]) cylinder(h = 10, r = mr);
}

translate(v = [x+5,0,0]) difference() {
    cube_rounded(v = [x,y,z2]);
    o=4;
    translate(v = [(x-39)/2,w,w]) cube([39,23,z2]);
    translate(v = [(x-47)/2,w+23+o,w]) cube([47,8,z2]);
    translate(v = [w,w+23+o+8+o,w]) tray_rounded(v=[(x-3*w)/2,33,50]);
    translate(v = [w+(x-3*w)/2+w,w+23+o+8+o,w]) tray_rounded(v=[(x-3*w)/2,33,50]);


    translate([mr+w,mr+w,z2-ml]) cylinder(h = 10, r = mr);
    translate([x-(mr+w),mr+w,z2-ml]) cylinder(h = 10, r = mr);
    translate([mr+w,y-(mr+w),z2-ml]) cylinder(h = 10, r = mr);
    translate([x-(mr+w),y-(mr+w),z2-ml]) cylinder(h = 10, r = mr);
}

difference() {
    cube_rounded(v = [x,y,zd],rc=0);
    o=6;

    translate(v = [0,(y-(w+33+o+23))/2,-w-w]) union() {
        translate(v = [w,w,w]) cube_rounded(v = [x-2*w,33,z1+5], rc=0,r=0);
        translate(v = [w,w+33+o,w]) cube_rounded(v = [x-2*w,23,z1+5], rc=0,r=0);
    }
    translate([mr+w,mr+w,-10+ml]) cylinder(h = 10, r = mr);
    translate([x-(mr+w),mr+w,-10+ml]) cylinder(h = 10, r = mr);
    translate([mr+w,y-(mr+w),-10+ml]) cylinder(h = 10, r = mr);
    translate([x-(mr+w),y-(mr+w),-10+ml]) cylinder(h = 10, r = mr);

    o2=4;
    translate(v = [0,0,20]) union() {
        translate(v = [(x-39)/2,w,w-3]) cube([39,23,zd]);
        translate(v = [(x-47)/2,w+23+o2,w-3]) cube([47,8,zd]);
        translate(v = [w,w+23+o2+8+o2,w]) tray_rounded(v=[(x-3*w)/2,33,50]);
        translate(v = [w+(x-3*w)/2+w,w+23+o2+8+o2,w]) tray_rounded(v=[(x-3*w)/2,33,50]);
    }
    translate([mr+w,mr+w,zd-ml]) cylinder(h = 10, r = mr);
    translate([x-(mr+w),mr+w,zd-ml]) cylinder(h = 10, r = mr);
    translate([mr+w,y-(mr+w),zd-ml]) cylinder(h = 10, r = mr);
    translate([x-(mr+w),y-(mr+w),zd-ml]) cylinder(h = 10, r = mr);

    translate(v = [x/2,y+7,zd/2]) difference() {
        sphere(r = 15);
        cube([w,50,50], true);
    }
}




module cube_rounded(v, r=3, center=false, rc=1){
    translate(center==true ? [r-v[0]/2,r-v[1]/2,-v[2]/2+rc] : [r,r,rc])
    union(){
        cylinder(h = v[2]-rc, r = r);
        translate(v = [0,v[1]-2*r,0]) cylinder(h = v[2]-rc, r = r);
        translate(v = [v[0]-2*r,v[1]-2*r,0]) cylinder(h = v[2]-rc, r = r);
        translate(v = [v[0]-2*r,0,0]) cylinder(h = v[2]-rc, r = r);
        translate(v = [-r,0,0]) cube([v[0],v[1]-2*r,v[2]-rc]);
        translate(v = [0,-r,0]) cube([v[0]-2*r,v[1],v[2]-rc]);
        if(rc > 0)
        {
            translate(v = [0,0,-rc]) hull() {
                cylinder(h = rc, r2 = r, r1 = r-rc);
                translate(v = [0,v[1]-2*r,0]) cylinder(h = rc, r2 = r, r1 = r-rc);
                translate(v = [v[0]-2*r,v[1]-2*r,0]) cylinder(h = rc, r2 = r, r1 = r-rc);
                translate(v = [v[0]-2*r,0,0]) cylinder(h = rc, r2 = r, r1 = r-rc);
            }
        }
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