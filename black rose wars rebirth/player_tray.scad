$fn=200;
x=295;
y=64;
z=62;
w=1.6;
b=1.4;
hx=20;
hy=w;
hr=9;
hz=30;
trays=7;

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

module tray() {
    union() {
        difference() {
            cube_rounded([x/trays,y,z], r=2);
            translate(v = [w,w,b]) tray_rounded([x/trays-2*w,y-2*w,z], r=5);
        }
        translate(v = [0,y/2-hy/2,z-hz]) hull() {
            cube([w,hy,hz]);
            translate(v = [hr,hy,hz-hr]) rotate([90,0,0]) cylinder(h=hy, r=hr);
        }
    }
}
tray();