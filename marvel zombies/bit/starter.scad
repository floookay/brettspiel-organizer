// Toolkit that performs all the model generation operations
include <boardgame_insert_toolkit_lib.3.scad>;

// Helper library to simplify creation of single components
// Also includes some basic lid helpers
include <bit_functions_lib.3.scad>;

// Determines whether lids are output.
g_b_print_lid = true;

// Determines whether boxes are output.
g_b_print_box = true; 

// Only render specified box
g_isolated_print_box = "Box2"; 

// Used to visualize how all of the boxes fit together. 
g_b_visualization = false;          
        
// Outer wall thickness
// Default = 1.5mm
g_wall_thickness = 1.5;

// Provided to make variable math easier
// i.e., it's a lot easier to just type "wall" than "g_wall_thickness"
wall = g_wall_thickness;

// The tolerance value is extra space put between planes of the lid and box that fit together.
// Increase the tolerance to loosen the fit and decrease it to tighten it.
//
// Note that the tolerance is applied exclusively to the lid.
// So if the lid is too tight or too loose, change this value ( up for looser fit, down for tighter fit ) and 
// you only need to reprint the lid.
// 
// The exception is the stackable box, where the bottom of the box is the lid of the box below,
// in which case the tolerance also affects that box bottom.
//
g_tolerance = 0.15;

// This adjusts the position of the lid detents downward. 
// The larger the value, the bigger the gap between the lid and the box.
g_tolerance_detents_pos = 0.1;

// This sets the default font for any labels. 
// See https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Text#Using_Fonts_&_Styles
// for details on picking a new font.
g_default_font = "Liberation Sans:style=Regular";

// This determines whether the default single material version is output, or, if printing in multiple materials, 
// which layer to output.
g_print_mmu_layer = "default"; // [ "default" | "mmu_box_layer" | "mmu_label_layer" ]

////////////////////////////////////////////////////////////////////////////////
// User data for box creation
////////////////////////////////////////////////////////////////////////////////

// Variables for Box1
// The lower left corner of the box sits at (0, 0, 0)
// This defines the upper right corner of the box, i.e., the size
// Note that box_urz subtracts out 2*wall to have a final height of 20mm with an inset lid
box_urx = 190;
box_ury = 310/2;
box_urz = 50 - 2*wall;
w=1.2;

// y1=40;
// y2=40;
// y3=box_ury-(wall+y1+w+y2+w+wall);

x1=50;
x2=45;
x3=box_urx-(wall+x1+w+x2+w+wall);

// This math defines the size of a single square component that fills the box
cmp_dx = box_urx - 2*wall;
cmp_dy = box_ury - 2*wall;
cmp_dz = box_urz - 1*wall;


// Data structure processed by MakeAll();
data =
[
    [   
        // "Box1",                                                              // Box name, used for g_isolated_print_box
        // [
        //     [ BOX_SIZE_XYZ, [box_urx, box_ury, box_urz] ],                   // One Key-Value pair specifying the upper right x, y, and z of our box exterior.
        //     [ BOX_COMPONENT, cmp_parms(llx=0, lly=0, dx=x1, dy=cmp_dy, dz=cmp_dz)], // Another Key-Value pair to create the compartment
        //     [ BOX_COMPONENT, cmp_parms(llx=x1+w, lly=0, dx=x2, dy=cmp_dy, dz=cmp_dz)], // Another Key-Value pair to create the compartment
        //     [ BOX_COMPONENT, cmp_parms(llx=x1+w+x2+w, lly=0, dx=x3, dy=cmp_dy, dz=cmp_dz)], // Another Key-Value pair to create the compartment
        //     [ BOX_LID,
        //         [     
        //             [ LID_PATTERN_RADIUS, 20],
        //             [ LID_LABELS_BG_THICKNESS, 5],
        //             // [ LID_SOLID_LABELS_DEPTH, 0.4],
        //             [LID_LABELS_INVERT_B,true],
        //             [ LID_PATTERN_THICKNESS, 5],
        //             [ LABEL,
        //                 [
        //                     // [ LBL_TEXT,     "S.H.I.E.L.D."],
        //                     [ LBL_SIZE,     20 ],
        //                     [ LBL_DEPTH,     0.4 ],
        //                     [ LBL_FONT,         "Times New Roman"],
        //                 ],
        //             ],
        //         ],
        //     ],
        // ],
        // "Box2",                                                              // Box name, used for g_isolated_print_box
        // [
        //     [ BOX_SIZE_XYZ, [80, 60, 80] ],                   // One Key-Value pair specifying the upper right x, y, and z of our box exterior.
        //     [ BOX_COMPONENT, cmp_parms(llx=0, lly=0, dx=80-wall*2, dy=60-wall*2, dz=80-wall)], // Another Key-Value pair to create the compartment
        //     [ BOX_LID,
        //         [     
        //             [ LID_PATTERN_RADIUS, 20],
        //             [ LID_LABELS_BG_THICKNESS, 5],
        //             // [ LID_SOLID_LABELS_DEPTH, 0.4],
        //             [LID_LABELS_INVERT_B,true],
        //             [ LID_PATTERN_THICKNESS, 5],
        //             [ LABEL,
        //                 [
        //                     // [ LBL_TEXT,     "S.H.I.E.L.D."],
        //                     [ LBL_SIZE,     20 ],
        //                     [ LBL_DEPTH,     0.4 ],
        //                     [ LBL_FONT,         "Times New Roman"],
        //                 ],
        //             ],
        //         ],
        //     ],
        // ]
        // cards 23
        //
        //  "Box3",                                                              // Box name, used for g_isolated_print_box
        // [
        //     [ BOX_SIZE_XYZ, [112+2*wall, 60, 80] ],                   // One Key-Value pair specifying the upper right x, y, and z of our box exterior.
        //     [ BOX_COMPONENT, cmp_parms(llx=0, lly=60-23-2*wall, dx=112, dy=23, dz=80-wall)], // Another Key-Value pair to create the compartment
        //     [ BOX_COMPONENT, cmp_parms_fillet(llx=0, lly=0, dx=112, dy=60-wall-23-wall-wall, dz=80-wall, rot=f)], // Another Key-Value pair to create the compartment
        //     [ BOX_LID,
        //         [     
        //             [ LID_PATTERN_RADIUS, 20],
        //             [ LID_LABELS_BG_THICKNESS, 5],
        //             // [ LID_SOLID_LABELS_DEPTH, 0.4],
        //             [LID_LABELS_INVERT_B,true],
        //             [ LID_PATTERN_THICKNESS, 5],
        //             [ LABEL,
        //                 [
        //                     // [ LBL_TEXT,     "S.H.I.E.L.D."],
        //                     [ LBL_SIZE,     20 ],
        //                     [ LBL_DEPTH,     0.4 ],
        //                     [ LBL_FONT,         "Times New Roman"],
        //                 ],
        //             ],
        //         ],
        //     ],
        // ]
        "Box4",                                                              // Box name, used for g_isolated_print_box
        [
            [ BOX_SIZE_XYZ, [54, 60, 80] ],                   // One Key-Value pair specifying the upper right x, y, and z of our box exterior.
            [ BOX_COMPONENT, cmp_parms_fillet(llx=0, lly=0, dx=54-2*wall, dy=60-wall-wall, dz=80-wall, rot=f)], // Another Key-Value pair to create the compartment
            [ BOX_LID,
                [     
                    [ LID_PATTERN_RADIUS, 20],
                    [ LID_LABELS_BG_THICKNESS, 5],
                    // [ LID_SOLID_LABELS_DEPTH, 0.4],
                    [LID_LABELS_INVERT_B,true],
                    [ LID_PATTERN_THICKNESS, 5],
                    [ LABEL,
                        [
                            // [ LBL_TEXT,     "S.H.I.E.L.D."],
                            [ LBL_SIZE,     20 ],
                            [ LBL_DEPTH,     0.4 ],
                            [ LBL_FONT,         "Times New Roman"],
                        ],
                    ],
                ],
            ],
        ]
    ]
];

// Actually create the boxes based on the data structure above
MakeAll();
