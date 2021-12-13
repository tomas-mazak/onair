/*difference() {
  square([250, 125]);
  
}*/

use <triangles.scad>;

outer_x = 250;
outer_y = 125;
outer_z = 50;

wall_thickness = 2;

module corner_with_screwhole(height) {
  difference() {
    triangle(12, 12, height);
    translate([3.5, 3.5, height-10]) cylinder(11, d=2.2, $fn=20);
  }
}

module standoff() {  
  difference() {
    cylinder(7, d=5, $fn=50);
    cylinder(8, d=2.2, $fn=50);
  }
}

module front() {
  difference() {
    // basic shape
    cube([outer_x, outer_y, outer_z]);
    translate([wall_thickness*2, wall_thickness*2, wall_thickness])
      cube([outer_x-4*wall_thickness, outer_y-4*wall_thickness, 16]);
    translate([wall_thickness, wall_thickness, wall_thickness+15])
      cube([outer_x-2*wall_thickness, outer_y-2*wall_thickness, outer_z]);
    
    // tilted edges
    translate([-1, -3, -9]) rotate([45, 0, 0]) cube([outer_x+2, 10, 10]);
    translate([-1, outer_y+3, -9]) rotate([45, 0, 0]) cube([outer_x+2, 10, 10]);
    translate([-9, -1, -3]) rotate([0, 45, 0]) cube([10, outer_y+2, 10]);
    translate([outer_x-5, -1, -3]) rotate([0, 45, 0]) cube([10, outer_y+2, 10]);
    
    // text cut-out
    translate([outer_x-5.5, 35, wall_thickness+1]) rotate([0, 180, 0]) linear_extrude(wall_thickness+2) text("ON AIR", size=52, font="Stencilia\\-A:style=Regular");
    
    // power connector socket
    translate([outer_x/2, wall_thickness+1, outer_z-6.4-3*wall_thickness]) rotate([90, 0, 0]) cylinder(10, d=12.8);
    
    // microusb socket
    translate([outer_x-wall_thickness-1, outer_y/2-6, outer_z-2*wall_thickness-17]) cube([10, 12, 7]);
  }

  // corners to attach back wall to
  translate([wall_thickness, wall_thickness, wall_thickness])
    corner_with_screwhole(outer_z-2*wall_thickness);
  translate([outer_x-wall_thickness, wall_thickness, wall_thickness])
    rotate([0, 0, 90]) corner_with_screwhole(outer_z-2*wall_thickness);
  translate([outer_x-wall_thickness, outer_y-wall_thickness, wall_thickness])
    rotate([0, 0, 180]) corner_with_screwhole(outer_z-2*wall_thickness);
  translate([wall_thickness, outer_y-wall_thickness, wall_thickness])
    rotate([0, 0, 270]) corner_with_screwhole(outer_z-2*wall_thickness);
}

module back() {
  difference() {
    // basic shape
    union() {
      cube([outer_x, outer_y, wall_thickness]);
      translate([wall_thickness+0.2, wall_thickness+0.2, 0])
        cube([outer_x-2*wall_thickness-0.4, outer_y-2*wall_thickness-0.4, 2*wall_thickness]);
    }
    // screw holes
    translate([wall_thickness+3.5, wall_thickness+3.5, -1]) {
      cylinder(2*wall_thickness+2, d=3, $fn=20);
      cylinder(2+1, d=5.8, $fn=50);
    }
    translate([outer_x-wall_thickness-3.5, wall_thickness+3.5, -1]) {
      cylinder(2*wall_thickness+2, d=3, $fn=20);
      cylinder(2+1, d=5.8, $fn=50);
    }
    translate([outer_x-wall_thickness-3.5, outer_y-wall_thickness-3.5, -1]) {
      cylinder(2*wall_thickness+2, d=3, $fn=20);
      cylinder(2+1, d=5.8, $fn=50);
    }
    translate([wall_thickness+3.5, outer_y-wall_thickness-3.5, -1]) {
      cylinder(2*wall_thickness+2, d=3, $fn=20);
      cylinder(2+1, d=5.8, $fn=50);
    }
    
    // wall mount
    translate([(outer_x-17)/2, outer_y-45, -1]) {
      cube([17, 38, wall_thickness*1.5+1]);
      translate([(17-6)/2, 0, 0]) cube([6, 11, wall_thickness*2+2]);
    }
    translate([40, outer_y-20, -1]) cylinder(2*wall_thickness+2, d=4);
    translate([outer_x-40, outer_y-20, -1]) cylinder(2*wall_thickness+2, d=4);
  }
  // REMOVE BEFORE FLIGHT
  //translate([wall_thickness, (outer_y-55)/2, 2*wall_thickness]) cube([85, 55, 1]);
  
  // MOSFET standoffs
  translate([110, outer_y/2, 2*wall_thickness]) standoff();
  translate([139, outer_y/2, 2*wall_thickness]) standoff();
  
  // RPI standoffs
  translate([175, (outer_y-49)/2, 2*wall_thickness]) standoff();
  translate([175+58, (outer_y-49)/2, 2*wall_thickness]) standoff();
  translate([175, (outer_y-49)/2+49, 2*wall_thickness]) standoff();
  translate([175+58, (outer_y-49)/2+49, 2*wall_thickness]) standoff();
}

module reflection_screen() {
  difference() {
    cube([outer_x-2*wall_thickness-0.4, outer_y-wall_thickness-0.4, 1.4]);
    translate([0, outer_y, wall_thickness+5]) rotate([180, 0, 0]) front();
  }
}

//front();
//back();
translate([wall_thickness+0.2, wall_thickness+0.2, 0]) reflection_screen();
