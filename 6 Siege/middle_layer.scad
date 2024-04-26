include <config.scad>

$fn=10;

b = 2;  // bottom
z = b + 50 + 2;
rl = 6;
c = 0.5;
or = operator_rn + c;
zl = 3.6;

w = 3.2;
x_op = w+120+w;
module operator_profiles() {
    y = 90*3 + 1;
    difference() {
        cube_rounded(v=[x_op,box,z], r=rl);
        translate(v = [w,(box-y)/2,b]) cube([x_op-2*w,y,z]);
        translate(v = [w,-1,b+47]) cube([20.5,box+2,z]);
        translate(v = [w+120/2,(box-y)/2+90/2,-1]) cylinder(h = 2*b, r = 35);
        translate(v = [w+120/2,(box-y)/2+90/2+90+90+1,-1]) cylinder(h = 2*b, r = 35);
    }
}
operator_profiles();

xr = 228-x_op-0.5;
echo(xr);
xl = box-x_op-xr;
y_pt = w+140+w+10+w;   // w+y_lt+w+y_at+w
module player_tray() {
    difference() {
        cube_rounded(v=[xr,y_pt,z/2], r=rl);
        // bottom cutout
        x_bc = 156.9-x_op-0.5;
        translate(v = [x_bc,y_pt-80-52,-1]) cube([3.2+1,52,16+1]);
        // activation token
        o_at = y_pt-10-w;
        translate(v = [(xr-93)/2,o_at,b]) cube([93,10,30]);
        translate(v = [(xr-25)/2,o_at,-1]) cube([25,20,30]);
        // leaning token
        x_lt = 28;
        y_lt = 140;
        translate(v = [xr-w-x_lt,o_at-y_lt-w,b]) union() {
            translate(v = [0,0,8]) cube([x_lt,y_lt,30]);
            for (i = [0:4]) {
                translate(v = [0,i*(y_lt/5),0]) union() {
                    cube([x_lt,2.5,30]);
                    translate(v = [0,0,3]) rotate(a = 20, v = [1,0,0]) cube([x_lt,15,10]);
                }
            }
        }
        // damage token
        y_dt = 62;
        translate(v = [w,o_at-y_dt-w,b]) tray_rounded(v = [xr-3*w-x_lt,y_dt,40], r=15);
        // overwatch token
        translate(v = [w,w,10]) tray_rounded(v=[x_bc-w-w,y_pt-(w+y_dt+w+10+w)-w,30], r=5);
        // stunned/located token
        x_st = 29.3;
        y_st = (y_pt-(w+y_dt+w+10+w)-w-w)/2;
        translate(v = [xr-x_lt-w-w-x_st,w,10]) tray_rounded(v=[x_st,y_st,30], r=5);
        translate(v = [xr-x_lt-w-w-x_st,w+y_st+w,10]) tray_rounded(v=[x_st,y_st,30], r=5);
        // reroll token slot
        translate(v = [x_bc,w+y_st+w/2,30]) rotate(a = 90, v = [0,1,0]) cylinder(h = 3.2+1, r = 38/2, $fn=6);
    }
    // fix bottom side piece
    difference() {
        cube_rounded(v=[xr,y_pt,z/2], r=rl);
        translate(v = [-1,w,-1]) cube([xr+2,y_pt,z/2+2]);
    }

}
translate(v = [x_op,box-y_pt,0]) player_tray();