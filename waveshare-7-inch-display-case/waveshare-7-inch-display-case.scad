/* Case for the Waveshare 7 inch IPS HDMI display with USB touch, audio and VGA connectors

## Overview

This model defines case for the Waveshare 7 inch display. It features

- minimum size around the display
- display is horizontally centered in the case
- buttons on the left side are pressed through knobs which can be either oval or rectangular
- connectors on the right side are accessible through seperate openings in the case

The case consists of a top and bottom part and the five knobs.
Top and bottom part fit into each other using a surrounding notch.
They are held together with four M3x16 screws and M3R rectangular nuts,
both nut heights fit. These screws also hold the display itself in place
and keep it between the two halfs of the case.

The case is printed without any supports. It uses 45° overhangs at the critical elements
which should be printed cleanly by any decent 3D printer.

## Using this definition file and printing the parts

This definition file is completely self-contained.
It consists of three parts:

1. Parameters describing the model, split into
    a. measurements taken from the physical artifact, i.e. the display
    b. additional lengths defined for certain properties of the case
    c. derived lengths from the above needed at several places
2. Modules describing
    a. the display itself to some detail to simplify the modelling process
    b. parts of the case and combinations of such parts to actually model the case
    c. different combinations of the most high-level modules for presentation and printing
3. Call to one of the combining top-level modules to actually produce some output

Use the highest level or combining modules to produce the output you need
and generate STL files from them.

All sizes in this file are given in millimeters.
Generally, x-axis is "width", y-axis is "depth" and z-axis is "height".
However, there are independently modelled parts (like the knobs)
which are _not_ designed in their actual orientation in the case.
For these elements, naming may seem inconsistent.

## Assembly

1. Print the top and bottom case parts and the five knobs.
2. Place the top part bottom-up on the workbench.
3. Push the four M3R nuts into the openings.
4. Place the display in the case.
5. Add the five knobs for the button in the openings on the side.
6. Put the bottom part of the case above the display and the top part.
7. Use the M3x16 screws to put everything together.

 */

// Version of the construction, increase if severe changes are made
version_string = "v1";

// Top-level switch: Should the buttons for the knobs on the left side
//   of the display be rectangular or elliptic?
//   This switch influences all parts of the case, so do not change it
//   for different parts of the same device.
left_button_rectangular = false;

// *******************
// *** Definitions ***
// *******************

// Part 1: Physical sizes, non-negotiable

// Main PCB
pcb_height = 1.6;  // Height of the display PCB
pcb_width = 165;   // Width of the display PCB
pcb_depth = 107;   // Depth of the PCB _without_ the four screw holders

// Holder parts of the PCB
holder_hole_diameter = 3;  // Diameter of the screw hole
holder_width = 8;          // Width of the holder (parallel to the long PCB side)
holder_depth = 8.5;        // Depth of the holder, longest distance to main PCB edge
holder_hole_from_edge = 3; // Distance between hole diameter and edge along the y axis
// Note: Along the x-axis/width, the hole is centered to the holder and needs no explicit measurement.

// Dimensions of the actual screen mouted on the PCB
screen_gross_width = 165;  // Width of the screen including its own frame (same as PCB width)
screen_gross_depth = 99.3; // Depth of the screen including frame
screen_gross_height = 7.3 - pcb_height; // Height of the screen _including_ gap between screen and PCB
screen_top_outer_gap = 2.1;  // Gap between screen and PCB top edge _outside_ the screen itself
// The "inner gaps" are the distance between the screen module edge and the actual screen with the pixels
screen_top_inner_gap = 4;       // Inner gap on the screen top side
screen_left_inner_gap = 3;      // Left inner gap
screen_right_inner_gap = 6.8;   // Right inner gap, note that it is different from the left gap!
screen_bottom_inner_gap = 8.7;  // Bottom inner gap, larger than top gap

// Dimension of knobs on the left side of the PCB
// These measurements describes the tiny knobs soldered onto the PCB
// Note: "width" and "depth" are swapped here as the measurements are taken from the knobs'
//   front side, i.e. rotated by 90°
knob_case_width = 7;  // Width of the "knob case", i.e. the white body of the knob
knob_case_height = 5.2 - pcb_height; // due to measuring
knob_case_depth = 2.25;  // Depth of the case, mainly needed for modelling the display itself
knob_bottom_distance = 0.84; // Distance between the actual (black) knob and the knob case edge
knob_height = 1.5;  // Height of the actual knob
knob_depth = 1.15;         // Depth of the knob, i.e. how long is the visible knob part when released
knob_depth_pressed = 0.7;  // Length of the visible knob part above the case when pressed
knob_width = 3;            // Width of the knob itself (centered in the knob case)
// The "knob area" is the full area of all five knobs as they are soldered on the PCB
knob_area_gross_width = 59; // from left of first case to right of last knob case
knob_area_bottom_gap = 39.5 - knob_case_width - holder_depth;  // Distance between the
//  outer edge of the knob case nearest to the PCB "bottom" edge, _excluding_ the screw holder

// USB pcb plug is the highest element on the PCB bottom
// This is _not_ one of the plugs of the right side but the PCB-mounted USB plug on the PCB's
//   bottom side. This is the "highest" element on the bottom side so the case needs to be
//   large enough to have space for it.
usb_pcb_plug_width = 4.7;
usb_pcb_plug_depth = 10;
usb_pcb_plug_height = 6;  // This is the most important dimension as it is the actual height
// The following measures give the position of the plug on the PCB. They are currently unused.
// They could be used to create a hole in the case for using the plug.
usb_pcb_plug_left_gap = 128.4 - usb_pcb_plug_width; // due to measuring
usb_pcb_plug_bottom_gap = 21.6 - usb_pcb_plug_depth; // due to measuring

// Now come the dimensions of the plugs on the right side of the display.
// The plug positions are measured from the bottom PCB edge _without_ the holders
//   to the nearer edge of the plug.

// HDMI plug data
hdmi_plug_width = 15;
hdmi_plug_depth = 11;
hdmi_plug_gross_height = 7.8 - pcb_height;
hdmi_plug_bottom_gap = 97.5 - hdmi_plug_width; // due to measuring, PCB corner WITHOUT holders

// USB plug data
usb_plug_width = 7.6;
usb_plug_depth = 5.7;
usb_plug_gross_height = 4.3 - pcb_height;
usb_plug_bottom_gapA = 83.2 - usb_plug_width - holder_depth;
usb_plug_bottom_gapB = 68.7 - usb_plug_width - holder_depth;

// Audio plug data
// Width, depth and height are measured for the cubic part of the plug,
//   the "diameter" lengths are for the circular part of the plug
audio_plug_width = 6.5;
audio_plug_depth = 12.1;
audio_plug_gross_height = 6.54 - pcb_height;
audio_plug_diameter = 5.4;
audio_plug_diameter_depth = 14.1 - audio_plug_depth;
audio_plug_bottom_gap = 43 - audio_plug_width;

// VGA plug data
vga_plug_width = 11.3;
vga_plug_depth = 8.1;
vga_plug_gross_height = 5 - pcb_height;
vga_plug_bottom_gap = 33.8 - vga_plug_width - holder_depth;


// Part 2: Dimensions of the case, can be changed

// Depth of chars embossed into case, mainly version number
char_depth = 0.8;

// Additional free space below the highest part on the bottom of the PCB
additional_bottom_space = 2;

// General strength of the walls of the case
wall_strength = 2;

// Gap between the case and the pcb in width and depth
pcb_gap = 0.5;

// Additional free space above the top layer of the screen
additional_top_space = 1;

// additional space around holes for the plug on the right
right_side_plugs_frame = 1.2;

// additional space left and right of the right-side plug holes in the case
right_side_walls_frame = 5;

// Final adjustment of hole height on both sides
physical_height_correction = -1;

// Dimensions of the buttons on the left
// These buttons are constructed as squares or circles and then non-uniformely
//   scaled to the ratio of x_diameter and y_diameter.
// The construction is based on a thinner visible part and a thicker inner part
//   which are connected by a conic connection. This allows for 45° overhangs
//   for the buttons and for the eclosing case parts.
left_button_x_diameter = 8; // small x diameter of button
left_button_y_diameter = 4; // small y diameter
left_button_inner_x_diameter = 11; // large x diameter (y is scaled proportionally)
left_button_presser_width = 4; // width of knob presser
left_button_presser_height = 8; // height of knob presser (will be scaled!)
left_button_presser_depth = 1.2; // depth of knob presser
left_button_presser_center_shift = 0; // shift of knob presser along the y axis
left_button_elevated = 1; // elevation of the button above the case edge
left_button_covered_inner = 0.8; // embedded part with small diameter
left_button_case_frame = 0.25; // Computational distance between button and case

// Front offset from case front where the thicker case part for the buttons
//  on the left begin - These are designed based on the case orientation!
left_buttons_area_front = wall_strength + pcb_gap + holder_depth + knob_area_bottom_gap + knob_case_width / 2 -
    left_button_inner_x_diameter / 2 - wall_strength;
// Depth of said thicker part
left_buttons_area_depth = knob_area_gross_width - knob_case_width + left_button_inner_x_diameter + 2 * wall_strength;
// Width of the thicker part, including the wall strength
left_buttons_area_width = wall_strength + screen_right_inner_gap - screen_left_inner_gap - pcb_gap / 2;
// Height of the middle of the button holes on the left side
left_buttons_holes_height = wall_strength + additional_bottom_space + usb_pcb_plug_height - left_button_y_diameter / 2 +
  left_button_presser_center_shift + physical_height_correction;

// Dimensions of the split between upper and lower case part
// The case is split into an upper and a lower part which are connected with a cramped edge.
// This edge has a general height roughly at the height of the PCB.
// However, on the left and right side of the case the edge height is adjusted to the
// openings for the buttons (left) and the plugs (right) so that the split goes roughly
// through the middle.
// The cramp is formed by an outer and an inner split height which are defined for
// all three split heights separately.

// Height of the cramp, everywhere the same
split_cramp_height = 1;

// Position of the general outer split height
outer_split_height = wall_strength + additional_bottom_space + usb_pcb_plug_height + pcb_height;

// Inner general split simply being raised by the split cramp height.
inner_split_height = outer_split_height + split_cramp_height;

// Position of the general outer split where the plugs on the right are.
// The outer split is positioned so that it splits the cirular audio plug opening in half.
outer_split_height_right = wall_strength + additional_bottom_space + usb_pcb_plug_height - ((audio_plug_diameter +
  split_cramp_height) / 2) + physical_height_correction;

// Inner split height on the right simply derived from outer split height
inner_split_height_right = outer_split_height_right + split_cramp_height;

// On the left, outer split is derived from the height of the hole center
outer_split_height_left = left_buttons_holes_height - split_cramp_height;

// Inner split again derived from outer split.
// Note that the inner split is exactly on the hole center as this is also the height
//   of the split in the actual button holes of the case.
inner_split_height_left = outer_split_height_left + split_cramp_height;


// Part 3: Dimension computed from physical and defined stuff,
//   declared separately as needed at different places

// Width of the actual screen area
screen_net_width = screen_gross_width - (screen_left_inner_gap + screen_right_inner_gap);

// Height of the actual screen area
screen_net_depth = screen_gross_depth - (screen_top_inner_gap + screen_bottom_inner_gap);

// Gap on global y-axis between display module edge and PCB edge
screen_bottom_outer_gap = pcb_depth - (screen_gross_depth + screen_top_outer_gap);

// These are the outer case dimensions, including walls of the case itself
case_width = screen_net_width + 2 * (wall_strength + pcb_gap + screen_right_inner_gap);
case_depth = screen_net_depth
  + screen_bottom_inner_gap + screen_bottom_outer_gap
  + screen_top_inner_gap + screen_top_outer_gap
  + 2 * (wall_strength + pcb_gap + holder_depth);
case_height = additional_bottom_space + usb_pcb_plug_height + pcb_height + screen_gross_height + 2 * wall_strength;

// Distance between two left-side knobs (gap from edge to edge)
knob_distance = (knob_area_gross_width - knob_case_width) / 4;

// In-case depth of the left-side-buttons, from case outer side to knob surface
// NOT including the elevation of the buttons above the case surface
left_button_body_depth = wall_strength + screen_right_inner_gap - screen_left_inner_gap;

// Part 4: Additional technical lengths

// overlapping delta to prevent computational artifacts
DELTA = 0.02;

// Virtual dimension to show differences in construction which do not exist in reality
VIRTUAL = 0.1;

// Gap between constructed parts so that they have some play
PARTSGAP = 0.1;

// Smoothness of curved surfaces
$fn = 60;

// *******************
// *** Screw stuff ***
// *******************

// This is almost kind of a library but included here to keep things independent.

// M3 screws
screw_head_diameter_M3 = 5.6;
screw_head_height_M3 = 1.6;
screw_thread_diameter_M3 = 3.2;

// M3 washer
washer_diameter_M3 = 6.85;
washer_height_M3 = 0.5;

// M3R rectangular nut
nut_height_M3R = 2.34; // smaller ones: 1.74;
nut_width_M3R = 5.41;

// final adjustment settings for the physical parts
phy_adjust = 0.1;  // Adjustment of physical sizes for printed holes etc.
nut_M3R_adjust = 0.15;  // Special adjustment for the M3R nut

// Helper modules

/** Create a pyramid with the given dimensions, based on ground plain,
    either in first quadrant or x/y-centered to the origin */
module pyramid(dim, center = false) {
  translate(center?[-dim.x / 2, -dim.y / 2, 0]:[0, 0, 0])
    polyhedron(
    points = [[dim.x, dim.y, 0], [dim.x, 0, 0], [0, 0, 0], [0, dim.y, 0], // base points
        [dim.x / 2, dim.y / 2, dim.z]], // apex point
    faces = [[0, 1, 4], [1, 2, 4], [2, 3, 4], [3, 0, 4], // each triangle side
        [1, 0, 3], [2, 1, 3]]            // two triangles for square base
    );
}


/** Draw a screw hole

A screw hole has a diameter so that a screw with a certain thread diameter can slide in it.
It may also contain a wider area on one side where the screw head and a washer can sink in.
It has rounded edges.

The screw hole is usually used to be differenced from the object which shell contain this slide.
It does NOT automatically add some height so that it cuts surely through the containing body.

@param thread_diameter diameter of the screw thread which will slide in the screw slide
@param washer_diameter diameter of the wider part in which screw head and washer can sink in
@param full_height Height for the complete object, WITHOUT additional space to cut surely through the containing body
@param washer_height Height of the wider part for washer and screw head. If 0, no wider part is generated
@param chamfer_angle Additional chamfer angle between washer_diameter and thread_diameter.
@param phy_adjust Additional space added around screw and washer diameter, default is 0.1
*/
module screw_hole(thread_diameter, washer_diameter, full_height, washer_height, chamfer_angle = 0, phy_adjust = 0.1) {
  radius = thread_diameter / 2 + phy_adjust;
  wradius = washer_diameter / 2 + phy_adjust;
  chamfer_height = (chamfer_angle <= 0 || chamfer_angle >= 90?0:wradius * tan(90 - chamfer_angle));
  union() {
    cylinder(h = full_height, r = radius);
    cylinder(h = washer_height, r = wradius);
    if (chamfer_height > 0)
      translate([0, 0, washer_height - 0.01])
        cylinder(h = chamfer_height, r1 = wradius, r2 = 0);
  }
}

/** Draw a screw hole for M3 screws.

This module uses the screw_slide_M3() module and sets parameters according to the M3 screw dimensions without any slide area.

@param full_height Height of the hole, additional space for safely cut through some enclosing body is NOT added
@param head_space Additional space in the wider area above screw head and washer
@param phy_adjust Additional space added around screw and head diameter, default is 0.1

*/
module screw_hole_M3(full_height, head_space, chamfer_angle = 0, phy_adjust = 0.1) {
  screw_hole(thread_diameter = screw_thread_diameter_M3,
  washer_diameter = screw_head_diameter_M3,
  full_height = full_height,
  washer_height = screw_head_height_M3 + head_space,
  chamfer_angle = chamfer_angle,
  phy_adjust = phy_adjust);
}

/** Draw a screw shaft for M3 screws.

This module uses the screw_slide_M3() module and sets parameters according to the M3 screw dimensions without any slide area - and without space for a screw head.

@param full_height Height of the hole, additional space for safely cut through some enclosing body is NOT added
@param phy_adjust Additional space added around screw and head diameter, default is 0.1

*/
module screw_shaft_M3(full_height, phy_adjust = 0.1) {
  screw_hole(thread_diameter = screw_thread_diameter_M3,
  washer_diameter = screw_thread_diameter_M3,
  full_height = full_height,
  washer_height = 0,
  chamfer_angle = 0,
  phy_adjust = phy_adjust);
}

/** Draws an area where a nut can be inserted into the 3D-printed part.
    Nut is placed x/y centered or with front left edge in origin
    and at z=0 level.
*/
module nut_area_M3R(leftadd = 0, rightadd = 0, frontadd = 0, backadd = 0, center = false, withscrewhole = false,
top_chamfering_angle = 0, bottom_chamfering_angle = 0, phy_adjust = nut_M3R_adjust) {

  full_width = nut_width_M3R + phy_adjust;
  half_width = full_width / 2;
  full_height = nut_height_M3R + phy_adjust;
  top_chamfering_height = (top_chamfering_angle == 0?0:tan(90 - top_chamfering_angle) * half_width);
  bottom_chamfering_height = (bottom_chamfering_angle == 0?0:tan(90 - bottom_chamfering_angle) * half_width);

  module top_chamfering(height) {
    module p() {
      pyramid([full_width, full_width, height]);
    }
    union() {
      p();
      if (leftadd > 0 || rightadd > 0) hull() {
        translate([leftadd > 0?-leftadd - half_width:0, 0, 0]) p();
        translate([rightadd > 0?rightadd + half_width:0, 0, 0]) p();
      }
      if (frontadd > 0 || backadd > 0) hull() {
        translate([0, frontadd > 0?-frontadd - half_width:0, 0]) p();
        translate([0, backadd > 0?backadd + half_width:0, 0]) p();
      }
    }
  }

  translate([center?-half_width:0, center?-half_width:0, 0]) {
    difference() {// For the screw hole in the middle
      super_full_height = 2 * DELTA + bottom_chamfering_height + full_height + top_chamfering_height;
      intersection() {
        translate([-leftadd, -frontadd, -bottom_chamfering_height - DELTA])
          cube([leftadd + full_width + rightadd,
                frontadd + full_width + backadd,
            super_full_height]);
        union() {
          translate([-leftadd, 0, 0])
            cube([leftadd + nut_width_M3R + phy_adjust + rightadd,
                nut_width_M3R + phy_adjust,
                nut_height_M3R + phy_adjust]);
          translate([0, -frontadd, 0])
            cube([nut_width_M3R + phy_adjust,
                    frontadd + nut_width_M3R + phy_adjust + backadd,
                nut_height_M3R + phy_adjust]);
          if (top_chamfering_height > 0)
            translate([0, 0, nut_height_M3R + phy_adjust - DELTA / 10])
              top_chamfering(top_chamfering_height);
          if (bottom_chamfering_height > 0)
            translate([0, 0, DELTA / 10])
              scale([1, 1, -1])
                top_chamfering(bottom_chamfering_height);
        }
      }
      if (withscrewhole) {
        translate([half_width, half_width, -bottom_chamfering_height - DELTA])
          cylinder(h = super_full_height, d = screw_thread_diameter_M3);
      }
    }
  }
}

/* Create four coordinate pairs out of two X and two Y coordinates
   Points are created counterclockwise beginning bottom left. */
function fourToTheFloor(leftX, rightX, bottomY, topY) =
  [[leftX, bottomY], [rightX, bottomY], [rightX, topY], [leftX, topY]];

// Position of the screw holes in the case
function screwHolderLeftFront() = fourToTheFloor(wall_strength + (screen_right_inner_gap - screen_left_inner_gap),
      wall_strength + (screen_right_inner_gap - screen_left_inner_gap) + pcb_width - holder_width,
  wall_strength + pcb_gap, wall_strength + pcb_gap + holder_depth + pcb_depth);


// *** End of screw stuff ***

// ******************************************
// *** Start of actual construction parts ***
// ******************************************

// All following modules create a part of the complete construction.
// They build upon other parts.
// Order here in code is so that every module only references modules _above_ it.
// So, if you read the source code from top to bottom, you should never see
// a module not yet defined.

// To understand what is going on, you should be able to simply call
// each of these modules and see what happens. You might want to
// disable the final call to some high-level module fist at the end of the code.

/** Plugs on the right side.

  Needed for the "digital twin" and the holes in the case for them.
  The size is the one of the actual plugs.
  For the case holes, some "frame" is added to have more space. */
module side_plugs(frame = 0) {
  rotate([0, 0, 90]) {
    translate([hdmi_plug_bottom_gap - frame, 0, -hdmi_plug_gross_height - frame + DELTA])
      cube([hdmi_plug_width + 2 * frame, hdmi_plug_depth, hdmi_plug_gross_height + 2 * frame + DELTA]);
    translate([usb_plug_bottom_gapA - frame, 0, -usb_plug_gross_height - frame + DELTA])
      cube([usb_plug_width + 2 * frame, usb_plug_depth, usb_plug_gross_height + 2 * frame + DELTA]);
    translate([usb_plug_bottom_gapB - frame, 0, -usb_plug_gross_height - frame + DELTA])
      cube([usb_plug_width + 2 * frame, usb_plug_depth, usb_plug_gross_height + 2 * frame + DELTA]);
    translate([audio_plug_bottom_gap - frame, 0, -audio_plug_gross_height - frame + DELTA])
      union() {
        if (frame == 0)
          cube([audio_plug_width + 2 * frame, audio_plug_depth, audio_plug_gross_height + 2 * frame + DELTA]);
        translate([audio_plug_width / 2 + frame, (frame == 0?0:audio_plug_depth), audio_plug_diameter / 2 + frame])
          rotate([90, 0, 0])
            cylinder(h = audio_plug_diameter_depth + (frame == 0?0:audio_plug_depth) + DELTA, r = (audio_plug_diameter +
              frame) / 2);
      }
    translate([vga_plug_bottom_gap - frame, 0, -vga_plug_gross_height - frame + DELTA])
      cube([vga_plug_width + 2 * frame, vga_plug_depth, vga_plug_gross_height + 2 * frame + DELTA]);
  }
}


// Draws a "digital twin" of the display
// At [0,0,0] is the bottom of the PCB's left near screw holder appendix
// virtual rectangular corner, i.e. the rounding of the screw holders is not
// taken into consideration.
module display() {

  // Draw a screw holder with some additional DELTA for connecting it gaplessly
  //   to the main PCB
  module holder_with_DELTA() {
    difference() {
      intersection() {
        translate([holder_width / 2, holder_depth, -DELTA])
          cylinder(h = pcb_height + 2 * DELTA, r = holder_depth);
        cube([holder_width, holder_depth + DELTA, pcb_height]);
      }
      translate([holder_width / 2, holder_hole_from_edge + (holder_hole_diameter / 2), -DELTA])
        cylinder(h = pcb_height + 2 * DELTA, r = holder_hole_diameter / 2);
    }
  }

  // This is the usb PCB plug at the bottom of the PCB, needed
  // to leave enough space below the PCB
  module usb_pcb_plug() {
    translate([usb_pcb_plug_left_gap, usb_pcb_plug_bottom_gap, -usb_pcb_plug_height])
      cube([usb_pcb_plug_width, usb_pcb_plug_depth, usb_pcb_plug_height + DELTA]);
  }

  // One of the knobs on the left side of the PCB
  // Note that the knob case is designed with the knob along the x-axis.
  module knob() {
    union() {
      translate([0, knob_depth, 0])
        cube([knob_case_width, knob_case_depth, knob_case_height]);
      translate([(knob_case_width - knob_width) / 2, 0, knob_bottom_distance])
        cube([knob_width, knob_depth + DELTA, knob_height]);
    }
  }

  // The whole area of the five knobs, correctly oriented along the y-axis
  //   and located relative to the PCB being on the x/y-plane
  module knob_area() {
    translate([0, knob_area_gross_width + knob_area_bottom_gap, -knob_case_height])
      rotate([0, 0, -90]) {
        knob_gap = (knob_area_gross_width - (5 * knob_case_width)) / 4;
        knob_shift = knob_case_width + knob_gap;
        for (i = [0:1:4])
        translate([knob_shift * i, 0, 0])
          knob();
      }
  }

  // Main PCB with the knobs, the USB plug at the bottom and the plugs on the right
  module main_body() {
    union() {
      cube([pcb_width, pcb_depth, pcb_height]); // main pcb
      translate([(pcb_width - screen_gross_width) / 2, pcb_depth - (screen_gross_depth + screen_top_outer_gap),
          pcb_height - DELTA]) {
        difference() {
          cube([screen_gross_width, screen_gross_depth, screen_gross_height + DELTA]);
          translate([screen_left_inner_gap, screen_bottom_inner_gap, screen_gross_height + DELTA - VIRTUAL])
            cube([screen_gross_width - (screen_left_inner_gap + screen_right_inner_gap),
                screen_gross_depth - (screen_top_inner_gap + screen_bottom_inner_gap),
                VIRTUAL + DELTA]);
        }
      }
      knob_area();
      usb_pcb_plug();
      translate([pcb_width, 0, 0])
        side_plugs();
    }
  }

  // The main body with the four screw holders
  union() {
    translate([0, holder_depth, 0])
      main_body();
    holder_with_DELTA();
    translate([pcb_width - holder_width, 0, 0])
      holder_with_DELTA();
    translate([pcb_width, 2 * holder_depth + pcb_depth, 0]) {
      rotate([0, 0, 180]) {
        holder_with_DELTA();
        translate([pcb_width - holder_width, 0, 0])
          holder_with_DELTA();
      }
    }
  }

}

/** Constructs the left buttons as cylinders and cone, add frame if used for the hole in the case for the button.

  NOTE: OpenSCAD 2021.1 sometimes becomes extremly slow when using these.
*/
module left_button_cylinder(frame = 0) {
  full_height = left_button_body_depth + left_button_elevated;
  heights = [0, // bottom
    left_button_presser_depth, // start of thick part
        full_height - left_button_elevated - (left_button_inner_x_diameter - left_button_x_diameter),
    // start of shrinking part
      full_height - left_button_elevated, // start of thin part
    full_height]; // end of thin part
  scale([1, (left_button_y_diameter + 2 * frame) / (left_button_x_diameter + 2 * frame), 1]) {
    intersection() {
      translate([-left_button_inner_x_diameter / 2 - frame - DELTA, -left_button_inner_x_diameter / 2 - frame - DELTA, (
        frame > 0?-wall_strength:0)])
        cube([left_button_inner_x_diameter + 2 * (frame + DELTA), left_button_inner_x_diameter + 2 * (frame + DELTA),
            full_height + (frame > 0?2 * wall_strength:0)]);
      union() {
        if (frame > 0) {
          translate([0, 0, DELTA - wall_strength])
            cylinder(h = heights[2] + wall_strength, d = left_button_inner_x_diameter + 2 * frame);
        }
        else {
          translate([-left_button_presser_width / 2, -left_button_presser_height / 2 + left_button_presser_center_shift,
              heights[0] - DELTA])
            cube([left_button_presser_width, left_button_presser_height, 2 * DELTA + heights[1]]);
          translate([0, 0, heights[1]])
            cylinder(h = heights[2] - heights[1], d = left_button_inner_x_diameter + 2 * frame);
        }
        translate([0, 0, heights[2]]) {
          difference() {
            cylinder(h = left_button_inner_x_diameter / 2,
            d1 = left_button_inner_x_diameter + 2 * frame, d2 = 2 * frame);
            translate([-left_button_inner_x_diameter / 2 - frame - DELTA, -left_button_inner_x_diameter / 2 - frame - DELTA,
              heights[3]-heights[2]+DELTA])
              cube([left_button_inner_x_diameter + 2 * (frame + DELTA), left_button_inner_x_diameter + 2 * (frame + DELTA),
                left_button_inner_x_diameter / 2]);
          }
        }
        translate([0, 0, heights[2]])
          cylinder(h = heights[4] - heights[2] + DELTA + (frame > 0?wall_strength:0), d = left_button_x_diameter + 2 *
            frame);
      }
    }
  }
}

/** Constructs the left buttons as cube and pyramid, add frame if used for the hole in the case for the button.

  NOTE: OpenSCAD 2021.1 sometimes  becomes extremly slow when using these.
*/
module left_button_rect(frame = 0) {
  full_height = left_button_body_depth + left_button_elevated;
  heights = [0, // bottom
    left_button_presser_depth, // start of thick part
        full_height - left_button_elevated - (left_button_inner_x_diameter - left_button_x_diameter),
    // start of shrinking part
      full_height - left_button_elevated, // start of thin part
    full_height]; // end of thin part
  scale([1, (left_button_y_diameter + 2 * frame) / (left_button_x_diameter + 2 * frame), 1]) {
    intersection() {
      translate([-left_button_inner_x_diameter / 2 - frame - DELTA, -left_button_inner_x_diameter / 2 - frame - DELTA, (
        frame > 0?-wall_strength:0)])
        cube([left_button_inner_x_diameter + 2 * (frame + DELTA), left_button_inner_x_diameter + 2 * (frame + DELTA),
            full_height + (frame > 0?2 * wall_strength:0)]);
      union() {
        if (frame > 0) {
          translate([-left_button_inner_x_diameter / 2 - frame, -left_button_inner_x_diameter / 2 - frame, DELTA -
            wall_strength])
            cube([left_button_inner_x_diameter + 2 * frame, left_button_inner_x_diameter + 2 * frame,
                left_button_presser_depth + wall_strength]);
        }
        else {
          translate([-left_button_presser_width / 2, -left_button_presser_height / 2 + left_button_presser_center_shift,
              heights[0] - DELTA])
            cube([left_button_presser_width, left_button_presser_height, 2 * DELTA + heights[1]]);
        }
        translate([-left_button_inner_x_diameter / 2 - frame, -left_button_inner_x_diameter / 2 - frame, heights[1] -
          DELTA])
          cube([left_button_inner_x_diameter + 2 * frame, left_button_inner_x_diameter + 2 * frame, heights[2] - heights
          [1] + DELTA]);
        translate([0, 0, heights[2] - DELTA])
          pyramid([left_button_inner_x_diameter + 2 * frame, left_button_inner_x_diameter + 2 * frame,
                left_button_inner_x_diameter / 2 + frame], center = true);
        translate([-left_button_x_diameter / 2 - frame, -left_button_x_diameter / 2 - frame, heights[1]])
          cube([left_button_x_diameter + 2 * frame, left_button_x_diameter + 2 * frame, heights[4] - heights[1] + DELTA
            + (frame > 0?wall_strength:0)]);
      }
    }
  }
}

/** Actual left button module, constructing either rectangular or elliptic buttons */
module left_button(frame = 0) {
  if (left_button_rectangular)
    left_button_rect(frame);
  else
    left_button_cylinder(frame);
}

// Debug module 
module debug_left_button_with_case_frame() {
  left_button();
  translate([left_button_inner_x_diameter*1.2,0,0])
    left_button(frame=left_button_case_frame);
}

// Construct the five buttons on the left with correct distance and orientation
module left_knob_buttons(frame = 0, button_distance = knob_distance) {
  render(convexity = 2)
    rotate([90, 0, 270])
      union() {
        for (i = [0:1:4])
        translate([-button_distance * i, 0, 0])
          left_button(frame = frame);
      }
}

// Additional thickening in the area of the buttons on the left side
//   needed so that the holes for the buttons can be printed
module left_buttons_area() {
  translate([DELTA, left_buttons_area_front, DELTA])
    cube([left_buttons_area_width - DELTA,
      left_buttons_area_depth,
        case_height - 2 * DELTA]);
}

// Create the holes for the five buttons on the left
//   This module is "positive" and will be differenced from the case.
module left_buttons_holes() {
  translate([wall_strength + screen_right_inner_gap - screen_left_inner_gap - pcb_gap / 2,
            wall_strength + pcb_gap + holder_depth + knob_area_bottom_gap + knob_case_width / 2,
    left_buttons_holes_height])
    left_knob_buttons(frame = left_button_case_frame);
}

// *** Now comes the full case ***

// The case is constructed in three steps:
//   1. First, most parts of the full case are constructed without taking
//      upper and lower case part into consideration.
//   2. Then, two stamps are used which intersect the full case so that the
//      actual upper and lower part emerge.
//   3. Into both upper and lower part are multiple additional elements
//      added which should not have been affected from the stamping operation.
// You must understand what's going on here to actually understand how this whole
//   case is constructed.

// Constructs the full case without split between upper and lower part
module full_case() {
  difference() {
    union() {
      // Generate a hollow box with the defined wall strength
      difference() {
        cube([case_width, case_depth, case_height]);
        translate([wall_strength, wall_strength, wall_strength])
          cube([case_width - 2 * wall_strength, case_depth - 2 * wall_strength, case_height - 2 * wall_strength]);
      }
      // Add the additional thickness on the left for the buttons
      left_buttons_area();
    }
    // Buttons on the left side
    left_buttons_holes();
    // Holes for buttons on the right side
    translate([case_width + DELTA, wall_strength + holder_depth + pcb_gap, wall_strength + additional_bottom_space +
      usb_pcb_plug_height + physical_height_correction])
      side_plugs(frame = right_side_plugs_frame);
    // Labels
    char_start = wall_strength + holder_depth + pcb_gap + knob_area_bottom_gap + knob_width / 2 + 2;
    translate([char_depth, 0, wall_strength + additional_bottom_space + usb_pcb_plug_height + physical_height_correction
      + left_button_y_diameter - 2]) {
      translate([0, char_start, 0])
        rotate([90, 0, 270])
          linear_extrude(char_depth + DELTA)
            text("X", size = 6, font = "Noto Sans:style=Bold", halign = "center");
      translate([0, char_start + knob_distance, 0])
        rotate([90, 0, 270])
          linear_extrude(char_depth + DELTA)
            text("B", size = 6, font = "Noto Sans:style=Bold", halign = "center");
      translate([0, char_start + knob_distance * 2, 0])
        rotate([90, 0, 270])
          linear_extrude(char_depth + DELTA)
            text("F", size = 6, font = "Noto Sans:style=Bold", halign = "center");
      translate([0, char_start + knob_distance * 3, 0])
        rotate([90, 0, 270])
          linear_extrude(char_depth + DELTA)
            text("M", size = 6, font = "Noto Sans:style=Bold", halign = "center");
      translate([0, char_start + knob_distance * 4, 0])
        rotate([90, 0, 270])
          linear_extrude(char_depth + DELTA)
            text("P", size = 6, font = "Noto Sans:style=Bold", halign = "center");
    }
    translate([case_width - char_depth, wall_strength + holder_depth + pcb_gap, wall_strength + additional_bottom_space
      + usb_pcb_plug_height + physical_height_correction + pcb_height + 2]) {
      translate([0, vga_plug_bottom_gap + vga_plug_width / 2, 0])
        rotate([90, 0, 90])
          linear_extrude(char_depth + DELTA)
            text("VGA", size = 5, font = "Liberation Sans Narrow:style=Bold", halign = "center");
      translate([0, audio_plug_bottom_gap + audio_plug_width / 2, 0])
        rotate([90, 0, 90])
          linear_extrude(char_depth + DELTA)
            text("SND", size = 5, font = "Liberation Sans Narrow:style=Bold", halign = "center");
      translate([0, usb_plug_bottom_gapB + usb_plug_width / 2, 0])
        rotate([90, 0, 90])
          linear_extrude(char_depth + DELTA)
            text("PWR", size = 5, font = "Liberation Sans Narrow:style=Bold", halign = "center");
      translate([0, usb_plug_bottom_gapA + usb_plug_width / 2, 0])
        rotate([90, 0, 90])
          linear_extrude(char_depth + DELTA)
            text("T", size = 5, font = "Liberation Sans Narrow:style=Bold", halign = "center");
      translate([0, hdmi_plug_bottom_gap + hdmi_plug_width / 2, 0])
        rotate([90, 0, 90])
          linear_extrude(char_depth + DELTA)
            text("HDMI", size = 5, font = "Liberation Sans Narrow:style=Bold", halign = "center");
    }
    translate([case_width / 2, wall_strength + 2, case_height - wall_strength + char_depth])
      rotate([180, 0, 180])
        linear_extrude(char_depth + DELTA)
          text(version_string, size = 8, font = "Noto Sans:style=Bold", halign = "center");
    translate([case_width / 2, wall_strength + 2, wall_strength - char_depth])
      rotate([0, 0, 0])
        linear_extrude(char_depth + DELTA)
          text(version_string, size = 8, font = "Noto Sans:style=Bold", halign = "center");
  }
}

// Now comes the stamp for the bottom case part.
// This stamp has to model the cramp around the whole case.
// At left and right side, it adjusts the height according to the
// respective settings.
// You might just want to print this out alone to see what's happening here.
module bottom_stamp(for_upper = false) {
  outer_shift = for_upper?2 * DELTA:DELTA;
  inner_shift = for_upper?(wall_strength - PARTSGAP) / 2:(wall_strength + PARTSGAP) / 2;
  right_spare_front = vga_plug_bottom_gap - right_side_plugs_frame - right_side_walls_frame;
  right_spare_back = hdmi_plug_bottom_gap + hdmi_plug_width + right_side_plugs_frame + right_side_walls_frame;
  left_spare_front = left_buttons_area_front;
  left_spare_back = left_spare_front + left_buttons_area_depth;

  if (outer_split_height < inner_split_height) {
    union() {
      difference() {
        union() {
          translate([-outer_shift, -outer_shift, -outer_shift])
            cube([case_width + 2 * outer_shift, case_depth + 2 * outer_shift, outer_shift + outer_split_height + (
              for_upper?PARTSGAP / 2:-PARTSGAP / 2)]);
          translate([inner_shift, inner_shift, inner_shift])
            cube([case_width - 2 * inner_shift, case_depth - 2 * inner_shift, inner_split_height - inner_shift + (
              for_upper?PARTSGAP / 2:-PARTSGAP / 2)]);
        }
        translate([case_width - 2 * wall_strength, wall_strength + holder_depth + pcb_gap + right_spare_front, -DELTA])
          cube([3 * wall_strength, right_spare_back - right_spare_front, case_height + 2 * DELTA]);
        translate([-DELTA, left_buttons_area_front - DELTA, DELTA])
          cube([left_buttons_area_width + 2 * DELTA, left_buttons_area_depth + 2 * DELTA, case_height - 2 * DELTA]);
      }
      union() {
        translate([case_width / 2, -outer_shift, -outer_shift])
          cube([case_width / 2 + outer_shift, case_depth + 2 * outer_shift, outer_shift + outer_split_height_right + (
            for_upper?PARTSGAP / 2:-PARTSGAP / 2)]);
        translate([case_width / 2, inner_shift, inner_shift])
          cube([case_width / 2 - inner_shift, case_depth - 2 * inner_shift, inner_split_height_right - inner_shift + (
            for_upper?PARTSGAP / 2:-PARTSGAP / 2)]);
      }
      union() {
        translate([-outer_shift, -outer_shift, -outer_shift])
          cube([case_width / 2 + outer_shift, case_depth + 2 * outer_shift, outer_shift + outer_split_height_left + (
            for_upper?PARTSGAP / 2:-PARTSGAP / 2)]);
        translate([inner_shift, inner_shift, inner_shift])
          cube([case_width / 2 - inner_shift, case_depth - 2 * inner_shift, inner_split_height_left - inner_shift + (
            for_upper?PARTSGAP / 2:-PARTSGAP / 2)]);
      }
    }
  }
  else {
    cube([10, 10, 10]);
  }
}

// The top stamp is the counterpart of the bottom stamp for the top half of the case.
// It is constructed by "inverting" the bottom stamp within the case space.
module top_stamp() {
  difference() {
    translate([-DELTA, -DELTA, -DELTA])
      cube([case_width + 2 * DELTA, case_depth + 2 * DELTA, case_height + 2 * DELTA]);
    bottom_stamp(true);
  }
}


// The screw holder is the part which holds one screw or one nut.
// It is added to the top or bottom half of the case.
module screw_holder(height) {
  translate([-pcb_gap - DELTA, -pcb_gap - DELTA, -DELTA])
    cube([2 * (pcb_gap + DELTA) + holder_width,
          2 * (pcb_gap + DELTA) + holder_depth,
      height]);
}

// The actual bottom part of the case.
// It consists of the intersection of the whole case and the bottom stamp
// with some parts added afterwards.
module bottom_case_part(hole_in_bottom_for_development=false) {
  difference() {
    union() {
      // This is the main intersection of full case and bottom stamp.
      intersection() {
        full_case();
        bottom_stamp();
      }
      // These are the four screw holders added to the case
      for (c = screwHolderLeftFront())
      translate([c.x, c.y, wall_strength - DELTA])
        screw_holder(DELTA + additional_bottom_space + usb_pcb_plug_height - pcb_gap);
    };
    // And these are the four holes "drilled" into the screw holders.
    for (c = screwHolderLeftFront())
    translate([c.x + holder_width / 2, c.y + holder_hole_from_edge + holder_hole_diameter / 2, -DELTA])
      screw_hole_M3(full_height = wall_strength + DELTA + additional_bottom_space + usb_pcb_plug_height,
      head_space = 0.2, chamfer_angle = 60, phy_adjust = 0.2);
    // for development purposes
    if (hole_in_bottom_for_development) {
    // cut-out in the floor (saves material in test prints)
      translate([2*wall_strength+screen_right_inner_gap-screen_left_inner_gap,2*wall_strength+holder_depth,-DELTA])
        cube([case_width-(4*wall_strength)-screen_right_inner_gap+screen_left_inner_gap,case_depth-(4*wall_strength+2*holder_depth),wall_strength+2*DELTA]);
    }
    // end of development purposes
  }
}

// Top part of case, constructed similar to bottom part.
// Note that due to the was this is done, the top part of the case
// is modelled as it actually is located in space: It sits in its
// actual height above the x/y-plane and the top side _is_ the top side.
// For printing, the whole part has to be rotated by 180° around the x- or y-axis.
module top_case_part() {

  screw_holder_height = screen_gross_height + additional_top_space;

  difference() {
    union() {
      // The main intersection
      intersection() {
        full_case();
        top_stamp();
      }
      // Screw holders
      for (c = screwHolderLeftFront())
      translate([c.x, c.y, wall_strength + additional_bottom_space + usb_pcb_plug_height + pcb_height])
        screw_holder(DELTA + screw_holder_height);
      // inner frame around screen
      if (additional_bottom_space > PARTSGAP)
        translate([wall_strength + pcb_gap + screen_right_inner_gap - wall_strength,
                    wall_strength + pcb_gap + holder_depth + screen_bottom_outer_gap + screen_bottom_inner_gap -
            wall_strength,
                case_height - wall_strength - additional_top_space + PARTSGAP])
          cube([screen_net_width + 2 * wall_strength,
              screen_net_depth + 2 * wall_strength,
                additional_top_space - PARTSGAP + DELTA]);
    }
    // Now the space for the M3 screw nuts is cut out of the case.
    scp = screwHolderLeftFront();
    nut_extension = (holder_width - nut_width_M3R) / 2 + DELTA + 1;
    translate([holder_width / 2,
        holder_hole_from_edge + holder_hole_diameter / 2,
          case_height - wall_strength - nut_height_M3R]) {
      translate([scp[0].x, scp[0].y, 0])
        nut_area_M3R(rightadd = nut_extension, bottom_chamfering_angle = 60,
        withscrewhole = false, center = true);
      translate([scp[1].x, scp[1].y, 0])
        nut_area_M3R(leftadd = nut_extension, bottom_chamfering_angle = 60,
        withscrewhole = false, center = true);
      translate([scp[2].x, scp[2].y, 0])
        nut_area_M3R(leftadd = nut_extension, bottom_chamfering_angle = 60,
        withscrewhole = false, center = true);
      translate([scp[3].x, scp[3].y, 0])
        nut_area_M3R(rightadd = nut_extension, bottom_chamfering_angle = 60,
        withscrewhole = false, center = true);
    }

    // and the screw shafts also need to be cut out
    for (c = screwHolderLeftFront())
    translate([c.x + holder_width / 2, c.y + holder_hole_from_edge + holder_hole_diameter / 2, wall_strength +
      additional_bottom_space + usb_pcb_plug_height + pcb_height - 2 * DELTA])
      screw_shaft_M3(DELTA + screw_holder_height, 0);

    // cut the hole for the actual screen
    translate([wall_strength + pcb_gap + screen_right_inner_gap,
              wall_strength + pcb_gap + holder_depth + screen_bottom_outer_gap + screen_bottom_inner_gap,
            case_height - wall_strength - additional_top_space - DELTA])
      cube([screen_net_width,
        screen_net_depth,
            wall_strength + additional_top_space + 2 * DELTA]);
  }
}

// Here end the actual parts of the case (and the display.

// *** Combining and print-preparation modules ***

// The following modules combine the different parts constructed above
// or arrange them for printing with a 3D printer.

// Move the display so that is is correctly located in the case.
module display_in_case() {
  translate([wall_strength + (screen_right_inner_gap - screen_left_inner_gap),
      wall_strength + pcb_gap,
        wall_strength + additional_bottom_space + usb_pcb_plug_height])
    display();
}

// Move the five knobs on the left so that they are correctly located
// with respect to the case and the display.
module left_knobs_in_case() {
  translate([wall_strength + screen_right_inner_gap - screen_left_inner_gap - pcb_gap / 2,
            wall_strength + pcb_gap + holder_depth + knob_area_bottom_gap + knob_case_width / 2,
            wall_strength + additional_bottom_space + usb_pcb_plug_height - left_button_y_diameter / 2 +
      left_button_presser_center_shift])
    left_knob_buttons();
}

// Construct everything at the correct place.
// Mainly useful for demonstration or presentation.
// Display can be turned off and an explosion distance can be added.
// The different parts are colorized and semi-transparent for better look.
module full_model(with_display = true, explosion = 0) {
  translate([0, 0, -explosion])
    color("#a0ffa080")
      bottom_case_part();
  translate([-explosion,0,0])
    color("#a0a0ff80")
      left_knobs_in_case();
  if (with_display)
    color("#a0a0a040")
      display_in_case();
  translate([0, 0, explosion])
    color("#ffa0a080")
      top_case_part();
}

// Construct only the top case part and turn it so that it is ready for printing.
module top_case_part_for_printing() {
  translate([0, case_depth, case_height])
    rotate([180, 0, 0])
      top_case_part();
}

// Construct only the five buttons on the left side and turn them
// so that they are ready for printing
module buttons_for_printing(button_distance = 2 * knob_distance) {
  translate([0, 0, left_button_body_depth + left_button_elevated + DELTA])
    rotate([0, 270, 270])
      left_knob_buttons(button_distance = button_distance);
}

// Construct all parts and arrange them so that they can be printed at one
// (on a quite large print bed).
module all_parts() {
  bottom_case_part();
  translate([0, case_depth + 10, 0]) {
    top_case_part_for_printing();
    translate([40, 50, 0])
      buttons_for_printing();
  }
}

// Special module for development: Construct only the left and right
// sides of both top and bottom case part. This allows to print only
// these most difficult parts of the case. It helps saving time and money
// during development.
module left_right_development(print_left=true,print_right=true,print_buttons=true) {
  pwi = 20;
  pgap = 5;
  version = "G";
  if (print_left)
    intersection() {
      translate([-DELTA, -DELTA, -DELTA])
        cube([DELTA + pwi, 2 * DELTA + case_depth, 2 * DELTA + case_height]);
      difference() {
        bottom_case_part();
        translate([wall_strength - 0.4, wall_strength + holder_depth + pcb_gap + 0.8, wall_strength - 0.6])
          linear_extrude(0.6 + DELTA)
            text(version, size = 6);
      }
    }
  if (print_right)
    translate([pwi + pgap, 0, 0])
      intersection() {
        translate([0, -DELTA, -DELTA])
          cube([DELTA + pwi, 2 * DELTA + case_depth, 2 * DELTA + case_height]);
        translate([-case_width + pwi, 0, 0])
          difference() {
            bottom_case_part();
            translate([case_width - wall_strength - holder_width - 2, wall_strength + pcb_gap + 0.8, wall_strength - 0.6])
              linear_extrude(0.6 + DELTA)
                text(version, size = 6, halign = "right");
          }
      }
  if (print_left)
    translate([2 * (pwi + pgap), 0, 0]) {
      intersection() {
        translate([-DELTA, -DELTA, -DELTA])
          cube([DELTA + pwi, 2 * DELTA + case_depth, 2 * DELTA + case_height]);
        difference() {
          top_case_part_for_printing();
          translate([wall_strength - 0.4, wall_strength + holder_depth + pcb_gap + 0.8, wall_strength - 0.6])
            linear_extrude(0.6 + DELTA)
              text(version, size = 6);
        }
      }
    if (print_right)
      translate([pwi + pgap, 0, 0])
        intersection() {
          translate([0, -DELTA, -DELTA])
            cube([DELTA + pwi, 2 * DELTA + case_depth, 2 * DELTA + case_height]);
          difference() {
            translate([-case_width + pwi, 0, 0])
              top_case_part_for_printing();
            translate([12.5, wall_strength + holder_depth + pcb_gap + 0.8, wall_strength - 0.6])
              linear_extrude(0.6 + DELTA)
                text(version, size = 6);
          }
        }
    if (print_buttons)
      translate([pwi+pgap,wall_strength+holder_depth+2*pcb_gap+20,0])
        rotate([0,0,90])
          buttons_for_printing(knob_distance);
  }
}

// *** Main part of the constructions: Decide what actually should be constructed ***

// The idea of this whole document is that finally you decide what to construct
// by enabling one (and exactly one) of the following lines.
// Note that only the "really interesting" modules to print are mentioned here.
// During development you might want to construct only one of the smaller
// building block modules like a single button. Feel free to do so by adding another
// line here or directly at the respectie module and _disable all_ lines here.

// Enable this to show the complete model, potentially as an explosion sketch.
full_model(explosion=10,with_display=true);

// Enable this if you work on the left and right sides of the case and want to
// have a test print of them.
//left_right_development(print_right=false,print_buttons=false);

// Enable this to print the bottom case part.
//bottom_case_part();

// Enable this to print the top case part.
//top_case_part_for_printing();

// Enable this to print the buttons.
//buttons_for_printing();

// Enable this to print all parts at once (on a large print bed).
//all_parts();

// end of file
