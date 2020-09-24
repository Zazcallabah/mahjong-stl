
color("black")
intersection(){
    translate([0,0,16.1])
      rotate([180,0,90])
      resize([24,32,3])
      surface(file = "testtile.png", center = true, invert = false);
    translate([0,0,13])
      cube([32,24,3],center=true);
};