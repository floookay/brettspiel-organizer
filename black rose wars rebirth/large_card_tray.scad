$fn=20;

w=2.8;
x=155;
y=114;
z=35;
b=30;

difference() {
    cube_rounded(v=[x,y,z], r=5);
    translate(v = [w,w,2]) cube_rounded([x-2*w,y-2*w,z], r=5-w);
    translate(v = [b,b,0]) cube_rounded([x-2*b,y-2*b,z], r=5);
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