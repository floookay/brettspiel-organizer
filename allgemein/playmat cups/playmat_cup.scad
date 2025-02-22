$fn = 100;


wall = 1.6;
height = 80;
bottom = 2;

module curved_text(diameter, textvalue, angle_offset=0) {
    // https://www.openscad.info/index.php/2020/07/02/cylindrical-text-the-easy-way/
    arc_angle = 180/10*len(textvalue) * (50/diameter);
    for(i=[0:1:len(textvalue)]) {
        rotate([0,0,angle_offset-i*arc_angle/len(textvalue)]) {
            translate( [(diameter/2+wall)-0.8,0,6])
            rotate([90,180,90])
                linear_extrude(1)
                text(textvalue[i],size=9,valign="center",halign="center");
        }
    }
}

module playmat_cup(diameter, textvalue = []) {
    minkrad = 2;
    difference() {
        union() {
            cylinder(h = height - minkrad, r = diameter/2 + wall);
            minkowski() {
                cylinder(h = minkrad + 1, r = diameter/2 + wall - minkrad);
                sphere(r = minkrad);
            }
        }
        translate(v = [0,0,height/2]) cylinder(h = height/2, r1 = diameter/2, r2 = diameter/2 + 0.8);
        translate(v = [0,0,bottom]) cylinder(h = height, r = diameter/2);
        if(len(textvalue) > 0) {
            curved_text(diameter = diameter, textvalue = textvalue);
            curved_text(diameter = diameter, textvalue = textvalue, angle_offset=180);
            translate(v = [0,0,-minkrad+0.2]) rotate([180,0,0]) linear_extrude(minkrad + 1) text(textvalue[0],size=diameter/2,valign="center",halign="center");
        }
    }
}
playmat_cup(75, ["R","A","D","L","A","N","D","S"]);



 
