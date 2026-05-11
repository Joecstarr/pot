odTop = 75;
odBottom = 75;
idTop = 72;
idBottom = 72;
cupHeight = 93;
baseHeight = 3;

legLength= 0;
legDiam= odTop/10;
legCount = 10;
legDistToCenter = .8;

holeRadius = 3;
holeOffset = 1;
numberOfHoles = 0;
numberOfCols= 0;
angleOffset = 19;
holeDirection = true;

lipRim = 10;
lipThickness = 5;

bottomOffset = holeRadius*1;
bottomHoleRowCount = 5;

MAX = 256;


union() {
    difference() {
        difference() {
            union(){
                rim(odTop,odTop+lipRim,lipThickness,cupHeight-lipThickness);
                cylinder(h = cupHeight, d1 = odBottom, d2 = odTop, center = false, $fn=300);
            }
            translate([0, 0, baseHeight]) 
            cylinder(h = cupHeight+baseHeight, d1 = idBottom, d2 = idTop, center = false, $fn=300);
            bottomHoles(idBottom, holeRadius, bottomOffset , bottomHoleRowCount );
        }

        union() {
            if(0<numberOfCols){
                for (i=[0:numberOfCols])
                {
                    rotate([0, 0, i*(360/numberOfCols)]) 
                    teardropSet(holeOffset, angleOffset, numberOfHoles , holeRadius, baseHeight, MAX, holeDirection);   
                }
            }
        }
    }

    translate([0,0,-legLength])
    feet(fitDiam = odBottom, diam = legDiam, height=legLength,count=legCount,placement=legDistToCenter);
}

module rim(bottomDiam, topDiam, thickness, height) {
    translate([0,0,height])
    cylinder(h = thickness, d1=bottomDiam,d2=topDiam, center = false, $fn=300);

}

module feet(fitDiam, diam, height, count, placement) {
    union() {
        for (i=[0:count])
        {
        rotate([0, 0, i*360/count])
            translate([(fitDiam/2)*placement,0,0])
            cylinder(h = height, d=diam, center = false, $fn=300);
        }

}
}

module teardropSet(oset, osetAngle, count, radius, base, maxHeight, holeUp) {

    union() {
        rotate([0, 0, 180])
        union() {
            for (i=[0:count])
            {      
                if (holeUp){ 
                    rotate([0, 270, i*osetAngle]) 
                    union(){
                    translate([i*(oset+2*radius)+base+radius+3, 0 ,maxHeight/2])
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
                        translate([-1*i*(oset+2*radius)-base-radius-3, 0 ,maxHeight/2])
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

module spout(fitDiam, diam, height, count, placement) {
    union() {

        for (i=[0:count])
        {
        rotate([0, 0, i*360/count])
            translate([(fitDiam/2)*placement,0,0])
            cylinder(h = height, d=diam, center = false, $fn=300);
        }

}
}

module bottomHoles(diam, holeRadius, holeOffset, holeCount) {
   delta = holeOffset+2*holeRadius;
   center = -1*((holeCount-1)*delta)/2;
   difference(){ 
        translate([center,center,0])
        union() {
            for (i=[0:holeCount-1])
            {
                for (j=[0:holeCount-1])
                {
                    translate([delta*i,delta*j,0])
                        cylinder(h = MAX-10, r=holeRadius, center = true, $fn=300);
                }
            }
        }
        difference(){
            cube(MAX,center=true);
            cylinder(h=MAX-10,d=diam,center=true);
        }
   }
}