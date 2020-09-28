
l=25;
w=20;
h=15;
margin = .9;
lm = (l/2)-margin;
wm = (w/2)-margin;

color("green")
difference(){
    intersection(){
        translate([0,0,(h-6)/2])
         cube([l,w,h-6],center=true);
         hull(){
            $fn = 34;
            translate([-1*lm,-1*wm,margin]) sphere(r=1);
            translate([-1*lm,wm,margin]) sphere(r=1);
            translate([lm,-1*wm,margin]) sphere(r=1);
            translate([lm,wm,margin]) sphere(r=1);

            translate([-1*lm,-1*wm,h-margin]) sphere(r=1);
            translate([-1*lm,wm,h-margin]) sphere(r=1);
            translate([lm,-1*wm,h-margin]) sphere(r=1);
            translate([lm,wm,h-margin]) sphere(r=1);
        };
    };
    translate([-5,0,5])
      sphere(r=4.5);
    translate([-5,0,4.5])
      cylinder(h=9,r=4.5);
    translate([5,0,5])
      sphere(r=4.5);
    translate([5,0,4.5])
      cylinder(h=9,r=4.5);
};


split = .52;
engravedepth = 0.8;

color("red")
    translate([-(l-2)/2,-(w-2)/2,h-(1+engravedepth)])
    cube([(l-2)*split,w-2,1]);
    
    
color("black")
    translate([-(l-2)/2 + (l-2)*split,-(w-2)/2,h-(1+engravedepth)])
    cube([(l-2)*(1-split),w-2,1.1]);

color("white")
difference(){
    intersection(){
        union(){
            translate([0,0,h-3])
              cube([l,w,6],center=true);
        };
        hull(){
            $fn = 34;
            translate([-1*lm,-1*wm,margin]) sphere(r=1);
            translate([-1*lm,wm,margin]) sphere(r=1);
            translate([lm,-1*wm,margin]) sphere(r=1);
            translate([lm,wm,margin]) sphere(r=1);

            translate([-1*lm,-1*wm,h-margin]) sphere(r=1);
            translate([-1*lm,wm,h-margin]) sphere(r=1);
            translate([lm,-1*wm,h-margin]) sphere(r=1);
            translate([lm,wm,h-margin]) sphere(r=1);
            };
    };
    
    translate([-(l-2)/2,-(w-2)/2,h-(1+engravedepth)])
    cube([l-2,w-2,1]);

    translate([0,0,h])
      rotate([180,0,90])
      resize([w,l,engravedepth+0.05])
      surface(file = "signtest.png", center = true, invert = false);
};