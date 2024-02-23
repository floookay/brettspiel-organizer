$fn=200;

w=2.8;
x=73.3;
y=44;

difference() {
    hull() {
        cube_rounded(v=[x+2*w,y,20], r=1);
        translate(v = [-w,0,0]) cube_rounded(v=[x+4*w,y,2], r=1);
    }
    translate(v = [w,0,2]) cube([x,y,20]);
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