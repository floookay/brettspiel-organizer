include <gridfinity-rebuilt-utility.scad>

// ===== INFORMATION ===== //
/*
 IMPORTANT: rendering will be better for analyzing the model if fast-csg is enabled. As of writing, this feature is only available in the development builds and not the official release of OpenSCAD, but it makes rendering only take a couple seconds, even for comically large bins. Enable it in Edit > Preferences > Features > fast-csg
 the magnet holes can have an extra cut in them to make it easier to print without supports
 tabs will automatically be disabled when gridz is less than 3, as the tabs take up too much space
 base functions can be found in "gridfinity-rebuilt-utility.scad"
 examples at end of file

 BIN HEIGHT
 the original gridfinity bins had the overall height defined by 7mm increments
 a bin would be 7*u millimeters tall
 the lip at the top of the bin (3.8mm) added onto this height
 The stock bins have unit heights of 2, 3, and 6:
 Z unit 2 -> 7*2 + 3.8 -> 17.8mm
 Z unit 3 -> 7*3 + 3.8 -> 24.8mm
 Z unit 6 -> 7*6 + 3.8 -> 45.8mm

https://github.com/kennetek/gridfinity-rebuilt-openscad

*/

// ===== PARAMETERS ===== //

/* [Setup Parameters] */
$fa = 8;
$fs = 0.25;

/* [General Settings] */
// number of bases along x-axis
gridx = 1;
// number of bases along y-axis
gridy = 1;
// bin height. See bin height information and "gridz_define" below.
gridz = 6;

/* [Linear Compartments] */
// number of X Divisions (set to zero to have solid bin)
divx = 1;
// number of Y Divisions (set to zero to have solid bin)
divy = 1;

/* [Cylindrical Compartments] */
// number of cylindrical X Divisions (mutually exclusive to Linear Compartments)
cdivx = 0;
// number of cylindrical Y Divisions (mutually exclusive to Linear Compartments)
cdivy = 0;
// orientation
c_orientation = 2; // [0: x direction, 1: y direction, 2: z direction]
// diameter of cylindrical cut outs
cd = 10;
// cylinder height
ch = 1;
// spacing to lid
c_depth = 1;

/* [Height] */
// determine what the variable "gridz" applies to based on your use case
gridz_define = 0; // [0:gridz is the height of bins in units of 7mm increments - Zack's method,1:gridz is the internal height in millimeters, 2:gridz is the overall external height of the bin in millimeters]
// overrides internal block height of bin (for solid containers). Leave zero for default height. Units: mm
height_internal = 0;
// snap gridz height to nearest 7mm increment
enable_zsnap = true;

/* [Features] */
// the type of tabs
style_tab = 5; //[0:Full,1:Auto,2:Left,3:Center,4:Right,5:None]
// how should the top lip act
style_lip = 1; //[0: Regular lip, 1:remove lip subtractively, 2: remove lip and retain height]
// scoop weight percentage. 0 disables scoop, 1 is regular scoop. Any real number will scale the scoop.
scoop = 0; //[0:0.1:1]
// only cut magnet/screw holes at the corners of the bin to save uneccesary print time
only_corners = false;

/* [Base] */
style_hole = 0; // [0:no holes, 1:magnet holes only, 2: magnet and screw holes - no printable slit, 3: magnet and screw holes - printable slit, 4: Gridfinity Refined hole - no glue needed]
// number of divisions per 1 unit of base along the X axis. (default 1, only use integers. 0 means automatically guess the right division)
div_base_x = 0;
// number of divisions per 1 unit of base along the Y axis. (default 1, only use integers. 0 means automatically guess the right division)
div_base_y = 0;



// ===== IMPLEMENTATION ===== //

// color("tomato") {
// gridfinityInit(gridx, gridy, height(gridz, gridz_define, style_lip, enable_zsnap), height_internal) {

//     if (divx > 0 && divy > 0) {

//         cutEqual(n_divx = divx, n_divy = divy, style_tab = style_tab, scoop_weight = scoop);

//     } else if (cdivx > 0 && cdivy > 0) {

//         cutCylinders(n_divx=cdivx, n_divy=cdivy, cylinder_diameter=cd, cylinder_height=ch, coutout_depth=c_depth, orientation=c_orientation);
//     }
// }
// gridfinityBase(gridx, gridy, l_grid, div_base_x, div_base_y, style_hole, only_corners=only_corners);
// }


// ===== EXAMPLES ===== //

// 3x3 even spaced grid
/*
gridfinityInit(3, 3, height(6), 0, 42) {
	cutEqual(n_divx = 3, n_divy = 3, style_tab = 0, scoop_weight = 0);
}
gridfinityBase(3, 3, 42, 0, 0, 1);
*/

// Compartments can be placed anywhere (this includes non-integer positions like 1/2 or 1/3). The grid is defined as (0,0) being the bottom left corner of the bin, with each unit being 1 base long. Each cut() module is a compartment, with the first four values defining the area that should be made into a compartment (X coord, Y coord, width, and height). These values should all be positive. t is the tab style of the compartment (0:full, 1:auto, 2:left, 3:center, 4:right, 5:none). s is a toggle for the bottom scoop.

module invader_bin() {
    union() {
        gridfinityInit(2, 3, height(6), 0, 42) {
            cut(0, 0, 1, 0.6, 5, 1);
            cut(1, 0, 1, 0.6, 5, 1);
            cut(x=0, y=0.6, w=2, h=1, t=5, s=0);
            cut(0, 1.6, 2, 0.7, 5, 0);
            cut(0, 2.3, 2, 0.7, 5, 0);
        }
        gridfinityBase(2, 3, 42, 0, 0, 0);
    }
}

module elements_bin() {
    union() {
        gridfinityInit(2, 2, height(6), 0, 42) {
            // cut(0, 0, 1, 0.5, 5, 1.5);
            // cut(1, 0, 1, 0.5, 5, 1.5);
            // cut(0, 0.5, 1, 0.5, 5, 1.5);
            // cut(1, 0.5, 1, 0.5, 5, 1.5);
            // cut(0, 1, 1, 0.5, 5, 1.5);
            // cut(1, 1, 1, 0.5, 5, 1.5);
            // cut(0, 1.5, 1, 0.5, 5, 1.5);
            // cut(1, 1.5, 1, 0.5, 5, 1.5);
            mirror(v = [0,1,0]) {
                cut(0, 0, 0.5, 1, 5, 2);
                cut(0.5, 0, 0.5, 1, 5, 2);
                cut(1, 0, 0.5, 1, 5, 2);
                cut(1.5, 0, 0.5, 1, 5, 2);
            }
            cut(0, 0, 0.5, 1, 5, 2);
            cut(0.5, 0, 0.5, 1, 5, 2);
            cut(1, 0, 0.5, 1, 5, 2);
            cut(1.5, 0, 0.5, 1, 5, 2);
        }
        gridfinityBase(2, 2, 42, 0, 0, 0);
    }
}

module token_bin() {
    gx = 4;
    trays = 5;
    difference() {
        union() {
            gridfinityInit(gx, 1, height(6), 0, 42) {
                cut(0, 0, gx/trays, 1, 5, 1.6);
                cut(gx/trays, 0, gx/trays, 1, 5, 1.6);
                cut(2*gx/trays, 0, gx/trays, 1, 5, 1.6);
                cut(3*gx/trays, 0, gx/trays, 1, 5, 1.6);
                cut(4*gx/trays, 0, gx/trays, 1, 5, 1.6);
            }
            gridfinityBase(4, 1, 42, 0, 0, 0);
        }
        // svgs
        // basepath="/home/flo/Repositories/brettspiel-organizer/spirit island/svg/";
        // gx_offset = -gx*l_grid/2 + gx/trays*l_grid/2;
        // translate([gx_offset + 0*gx/trays*l_grid,-l_grid/2+1,l_grid/3]) rotate([90,0,0]) linear_extrude(1) translate([-11,0,0]) import(str(basepath, "Beasts.svg"));
        // translate([gx_offset + 1*gx/trays*l_grid,-l_grid/2+1,l_grid/3]) rotate([90,0,0]) linear_extrude(1) translate([-11,0,0]) import(str(basepath, "Disease.svg"));
        // translate([gx_offset + 2*gx/trays*l_grid,-l_grid/2+1,l_grid/3]) rotate([90,0,0]) linear_extrude(1) translate([-13,0,0]) import(str(basepath, "Wilds.svg"));
        // translate([gx_offset + 3*gx/trays*l_grid,-l_grid/2+1,l_grid/3]) rotate([90,0,0]) linear_extrude(1) translate([-9,0,0]) import(str(basepath, "Strife.svg"));
        // translate([gx_offset + 4*gx/trays*l_grid,-l_grid/2+1,l_grid/3]) rotate([90,0,0]) linear_extrude(1) translate([-13,0,0]) import(str(basepath, "Badlands.svg"));
    }
}

module player_bin() {
    union() {
        gridfinityInit(1, 1, height(6), 0, 42) {
            cut(0, 0, 1, 1, 5, 1.5);
        }
        gridfinityBase(1, 1, 42, 0, 0, 0);
    }
}

module fear_bin() {
    union() {
        gridfinityInit(2, 1, height(6), 0, 42) {
            cut(0, 0, 2, 1, 5, 1.5);
        }
        gridfinityBase(2, 1, 42, 0, 0, 0);
    }
}

module energy_bin() {
    union() {
        gridfinityInit(3, 1, height(6), 0, 42) {
            cut(0, 0, 1.5, 1, 5, 1.5);
            cut(1.5, 0, 1.5, 1, 5, 1.5);
        }
        gridfinityBase(3, 1, 42, 0, 0, 0);
    }
}
