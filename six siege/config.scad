box = 300;

// operator
operator_h = 59;    // operator max height
operator_r = 30/2;    // operator base ring radius
operator_rn =31.5/2;    // operator base ring radius with notch

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