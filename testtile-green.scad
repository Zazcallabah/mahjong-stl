color("green")
difference(){
    intersection(){
        translate([0,0,1.5])
          cube([32,24,3],center=true);
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
   translate([-7,0,1.5])
     cylinder(h=9,r=6);
   translate([7,0,1.5])
     cylinder(h=9,r=6);
};

