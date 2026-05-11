
height = 80;
thickness = 4;

holeRadius = 4;
holeOffset = 1;
numberOfHoles = 4;
numberOfCols= 6;
angleOffset = 19;
holeDirection = false;

mountingHoleRad = 5;

bottomSlice= 10;

MAX = 256;


bowl(height,thickness,holeDirection);
translate([0,0,thickness])
rotate([0,180,0])
bowlInner(height*.9,thickness,bottomSlice,numberOfCols,holeOffset, angleOffset,    numberOfHoles , holeRadius, MAX,holeDirection);   


module bowl(height,thickness,holeDirection){
    union(){
    difference(){
        sphere(height, $fn=300);
        sphere(height-thickness, $fn=300);

        translate([0,0,height])
        cube([height*3,height*3,height*2],center=true);
        
        translate([0,height,0])
        cube([height*2,height*2,height*2],center=true);

    }
    difference(){
        cube([height*2,thickness,height*2],center=true);
        difference(){
             cube([height*5,height*5,height*5],center=true);
             difference(){
                 sphere(height, $fn=300);
                 translate([0,0,height*1.5])
                 cube([height*2,height*2,height*3],center=true);
             }
        }
        
        translate([height/2,thickness,-2*mountingHoleRad])rotate([90,0,0])
        teardrop(thickness*5,mountingHoleRad,!holeDirection);
        
        translate([0,thickness,-2*mountingHoleRad])rotate([90,0,0])
        teardrop(thickness*5,mountingHoleRad,!holeDirection);
        
        translate([-1*height/2,thickness,-2*mountingHoleRad])rotate([90,0,0])
        teardrop(thickness*5,mountingHoleRad,!holeDirection);
        }
    }
}

module bowlInner(height,thickness,bottomSlice,numberOfCols,oset, osetAngle, count, radius, maxHeight, holeUp){
    union(){
        difference(){
            union(){
                difference(){
                    union(){
                        sphere(height, $fn=300);
                        translate([0,0,-1*thickness])
                        cylinder(thickness, r=1.1 * height, $fn=300);
                    }

                    sphere(height-thickness, $fn=300);
                    translate([0,0,height])
                    cube([height*3,height*3,height*2],center=true);

                    translate([0,(3*height)/2,0])
                    cube([height*3,height*3,height*2],center=true);

                    translate([0,0,-0.75*height])
                    union() {
                        for (i=[0:numberOfCols])
                        {
                            rotate([0, 0, i*(360/numberOfCols)]) 
                            teardropSet(holeOffset, angleOffset,numberOfHoles , holeRadius, MAX,holeDirection);   
                        }
                    }
                }
                difference(){
                        cube([height*2,thickness,height*2],center=true);
                        difference(){
                            cube([height*8,height*5,height*5],center=true);
                            difference(){
                                sphere(height, $fn=300);
                                translate([0,0,height*1.5])
                                cube([height*2,height*2,height*3],center=true);
                            }
                        }
                }
            }

            translate([-1*height,-1*height,-2.75*height])
            cube([height*2,height*2,height*2]);
        }
        difference(){
            translate([-1*height,-1*height,-0.75*height])
            cube([height*2,height*2,thickness]);
            difference(){
                cube([height*5,height*5,height*5],center=true);
                sphere(height, $fn=300);
            }
            translate([0,height,0])
            cube([height*2,height*2,height*2],center=true);

            union() {
                for (i=[0:numberOfCols]){
                    for (j=[0:numberOfCols]){
                        translate([2*i*(holeOffset+2*holeRadius)-height/2,2*j*(holeOffset+2*holeRadius)-height,-100])
                        teardrop(MAX,holeRadius,holeUp);
                    }
                }
            }
        }
    }
}



module teardropSet(oset, osetAngle, count, radius, maxHeight, holeUp) {

    union() {
        rotate([0, 0, 180])
        union() {
            for (i=[0:count])
            {      
                if (holeUp){ 
                    rotate([0, 270, i*osetAngle]) 
                    union(){
                    translate([i*(oset+2*radius)+radius+3, 0 ,maxHeight/2])
                    union() {
                        linear_extrude(height = maxHeight, center = true, convexity = radius, twist = 0)
                            circle(r = radius, $fn = 30);
                        linear_extrude(height = maxHeight, center = true, convexity = radius, twist = 0)
                            projection(cut = false) rotate([0, -270, 0]) translate([0, 0, radius * sin(45) * 1.5]) cylinder(h = radius * sin(45), r1 = radius * sin(45), r2 = 0, center = true, $fn = 30);
                    }
                    }
                }else{
                     
                    rotate([0, 90, i*osetAngle]) 
                    union(){
                        translate([-1*i*(oset+2*radius)-radius-3, 0 ,maxHeight/2])
                        union() {
                            linear_extrude(height = maxHeight, center = true, convexity = radius, twist = 0)
                                circle(r = radius, $fn = 30);
                            linear_extrude(height = maxHeight, center = true, convexity = radius, twist = 0)
                                projection(cut = false) rotate([0, -270, 0]) translate([0, 0, radius * sin(45) * 1.5]) cylinder(h = radius * sin(45), r1 = radius * sin(45), r2 = 0, center = true, $fn = 30);
                        } 
                    }
                }
            }
        }
    }
}


module teardrop(maxHeight,radius,holeUp)
{
    union(){
        if (holeUp){ 
            rotate([0, 0, 270]) 
            union() {
                linear_extrude(height = maxHeight, center = true, convexity = radius, twist = 0)
                    circle(r = radius, $fn = 30);
                linear_extrude(height = maxHeight, center = true, convexity = radius, twist = 0)
                    projection(cut = false) rotate([0, -270, 0]) translate([0, 0, radius * sin(45) * 1.5]) cylinder(h = radius * sin(45), r1 = radius * sin(45), r2 = 0, center = true, $fn = 30);
            }
        }else{
            rotate([0, 0, 90]) 
            union() {
                linear_extrude(height = maxHeight, center = true, convexity = radius, twist = 0)
                    circle(r = radius, $fn = 30);
                linear_extrude(height = maxHeight, center = true, convexity = radius, twist = 0)
                    projection(cut = false) rotate([0, -270, 0]) translate([0, 0, radius * sin(45) * 1.5]) cylinder(h = radius * sin(45), r1 = radius * sin(45), r2 = 0, center = true, $fn = 30);
            } 
        }
    }
}
