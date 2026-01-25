$fn=100;

cr=40/2;  // chip radius
ch=31.7/10;  // chip height
cmr=1/2;  // chip margin radius
cmh=2;  // chip margin height

tw=3;   // tube width
tah=tw-1;  // tube angled height
tch=4;  // tube connector height
tc=tw/2;    // tube connector
tcw=20; // tube connector width
tcm=0.1;    // tube connector margin

hr=20/2;

ts=7;

chip_tube(17, "VESUVIANS", ts);
translate([cr*3,0,0]) chip_tube(17, "ATLANTEANS", ts);
translate([cr*6,0,0]) chip_tube(17, "P' REFUGEES", ts);
translate([0,cr*3,0]) chip_tube(17, "LAMOSIANS", ts);
translate([cr*3,cr*3,0]) chip_tube(17, "KUNLUN", ts);
translate([cr*6,cr*3,0]) chip_tube(17, "AMAZONS", ts);
translate([0,cr*6,0]) chip_tube(17, "ARGONAUTS", ts);
translate([cr*3,cr*6,0]) chip_tube(17, "PARTHIANS", ts);

// translate([0,0,0]) chip_tube(20, "NAUMACHIA", ts);
// translate([cr*3,0,0]) chip_tube(8, "COND", ts);  // 6 chips

// translate([cr*6,0,0]) chip_tube(12, "NEUTRAL", ts); // 8 chips
// translate([0,cr*3,0]) chip_tube(9, "ARENA", ts); // 8 chips
// translate([cr*3,cr*3,0]) chip_tube(14, "IMMORTAL", ts);   // 12 chips
// translate([cr*6,cr*3,0]) chip_tube(19, "ASCENSION", ts);
// translate([0,cr*6,0]) chip_tube(8, "COLLO", ts);   // 8 chips

echo(6*15 + ch*(17*8+20+17+12+9+13+19+8));

translate([0,-cr*3,0]) cap_tube();


module cap_tube() {
    z=12;
    t=1.8;
    r=1.6;
    g=9;
    difference() {
        union() {
            translate([0,0,z]) cylinder(h=1, r1=cr+cmr+tw, r2=cr+cmr+tw-1);
            translate([0,0,z-r]) cylinder(h=r, r=cr+cmr+tw);
            translate([0,0,z-r-t]) cylinder(h=t, r1=cr+cmr+tw-t, r2=cr+cmr+tw);

            hull() {
                translate([0,0,0]) cylinder(h=z, r=cr+cmr+tw-t);
                translate([cr+cmr+tw-g,0,0]) cylinder(h=z, r=g);
                translate([-cr-cmr-tw+g,0,0]) cylinder(h=z, r=g);
            }
            rotate([0,0,60]) hull() {
                translate([0,0,0]) cylinder(h=z, r=cr+cmr+tw-t);
                translate([cr+cmr+tw-g,0,0]) cylinder(h=z, r=g);
                translate([-cr-cmr-tw+g,0,0]) cylinder(h=z, r=g);
            }
            rotate([0,0,120]) hull() {
                translate([0,0,0]) cylinder(h=z, r=cr+cmr+tw-t);
                translate([cr+cmr+tw-g,0,0]) cylinder(h=z, r=g);
                translate([-cr-cmr-tw+g,0,0]) cylinder(h=z, r=g);
            }

            translate([0,0,r]) cylinder(h=t, r2=cr+cmr+tw-t, r1=cr+cmr+tw);
            translate([0,0,0]) cylinder(h=r, r=cr+cmr+tw);
            translate([0,0,-tah]) cylinder(h=tah, r1=cr+cmr, r2=cr+cmr+tw);
            translate([0,0,-tah-tch]) cylinder(h=tch, r=cr+cmr);
            translate([0,0,-tah-tch]) intersection() {
                cube([tcw,200,100], center=true);
                union() {
                    cylinder(h=tc, r=cr+cmr+tc-tcm);
                    translate([0,0,tc]) cylinder(h=tc-tcm, r1=cr+cmr+tc-tcm, r2=cr+cmr);
                    translate([0,-cr-cmr-tc+tcm+1,tc+0.2]) sphere(1, $fn=14);
                    translate([0,cr+cmr+tc-tcm-1,tc+0.2]) sphere(1, $fn=14);
                }
            }
        }
        // translate([cr-8,0,17]) sphere(10);
        translate([0,0,z]) linear_extrude(20) text("H", size=28, font="Times New Roman:style=Bold", valign="center", halign="center");
    }
}

module chip_tube(chips=17, t="", s=7) {
    difference() {
        union() {
            cylinder(h=chips*ch+cmh+tah+tch, r=cr+cmr+tw);  // chips tube
            translate([0,0,-tah]) cylinder(h=tah, r1=cr+cmr, r2=cr+cmr+tw);
            translate([0,0,-tah-tch]) cylinder(h=tch, r=cr+cmr);
            translate([0,0,-tah-tch]) intersection() {
                cube([tcw,200,100], center=true);
                union() {
                    cylinder(h=tc, r=cr+cmr+tc-tcm);
                    translate([0,0,tc]) cylinder(h=tc-tcm, r1=cr+cmr+tc-tcm, r2=cr+cmr);
                    translate([0,-cr-cmr-tc+tcm+1,tc+0.2]) sphere(1, $fn=14);
                    translate([0,cr+cmr+tc-tcm-1,tc+0.2]) sphere(1, $fn=14);
                }
            }
        }
        cylinder(h=chips*ch+20, r=cr+cmr); // chips
        // connector
        rotate([0,0,90]) {
            translate([0,0,chips*ch+cmh+tch]) cylinder(h=tah, r1=cr+cmr, r2=cr+cmr+tw);
            translate([0,0,chips*ch+cmh]) intersection() {
                union() {
                    translate([100/2-tcw/2,100/2-tcw/2,100/2]) cube([100,100,100], center=true);
                    translate([-100/2+tcw/2,-100/2+tcw/2,100/2]) cube([100,100,100], center=true);
                }
                union() {
                    cylinder(h=tc, r=cr+cmr+tc);
                    translate([0,0,tc]) cylinder(h=tc, r1=cr+cmr+tc, r2=cr+cmr);
                    rotate([0,0,90]) {
                        translate([0,-cr-cmr-tc+tcm+1,tc+0.2]) sphere(1.1, $fn=14);
                        translate([0,cr+cmr+tc-tcm-1,tc+0.2]) sphere(1.1, $fn=14);
                    }
                }
            };
            translate([0,0,chips*ch+cmh]) intersection() {
                cube([tcw,200,100], center=true);
                union() {
                    cylinder(h=20, r=cr+cmr+tc);
                }
            }
        }
        translate([0,0,hr]) rotate([0,90,0]) hull() {
            cylinder(h=(cr+tw)*2+1, r=hr, center=true);
            translate([-chips*ch+hr*2,0,0]) cylinder(h=(cr+tw)*2+1, r=hr, center=true);
        }
        // text
        translate([0,cr+cmr+tw-tw/2+0.8,1]) rotate([0,0,-90]) rotate([0,-90,0]) linear_extrude(2) scale([1,1.4,1])
        text(t, size=s, font="Times New Roman:style=Bold", valign="center", spacing=0.9);
        translate([0,-cr-cmr-tw+tw/2-0.8,1]) rotate([0,0,90]) rotate([0,-90,0]) linear_extrude(2) scale([1,1.4,1])
        text(t, size=s, font="Times New Roman:style=Bold", valign="center", spacing=0.9);
    }
}

