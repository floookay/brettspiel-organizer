$fn = 100;

w=1.2;
mr=3.5/2;
ml=3;

y=310/2;
x=19;
z=50;

ra=2;

difference() {
    union() {
        cube_rounded(v = [x,y,z], r=ra);
    }
    translate(v = [w,w,w]) cube_rounded(v = [x2-w*2,y1-2*w,th], r=ra-w);
    translate(v = [x2-x1+w,y1-y2+w,w]) cube_rounded(v = [x1-2*w,y2-2*w,th], r=ra-w);
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