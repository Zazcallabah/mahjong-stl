
#color("white")
difference(){
    intersection(){
        union(){
            translate([0,0,9.5])
              cube([32,24,13],center=true);
        };
        hull(){
            $fn = 34;
            translate([-15.05,-11.05,.95]) sphere(r=1);
            translate([-15.05,11.05,.95]) sphere(r=1);
            translate([15.05,-11.05,.95]) sphere(r=1);
            translate([15.05,11.05,.95]) sphere(r=1);
            
            translate([-15.05,-11.05,15.1]) sphere(r=1);
            translate([-15.05,11.05,15.1]) sphere(r=1);
            translate([15.05,-11.05,15.1]) sphere(r=1);
            translate([15.05,11.05,15.1]) sphere(r=1);
        };
    };

    translate([0,0,16.1])
      rotate([180,0,90])
      resize([24,32,3])
      surface(file = "testtile.png", center = true, invert = false);
    translate([-7,0,3])
      cylinder(h=9,r=6);
    translate([7,0,3])
      cylinder(h=9,r=6);
};
