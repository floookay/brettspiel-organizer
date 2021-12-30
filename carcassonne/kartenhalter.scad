$fn=50;

// Karten
k_dicke = 36.80/17;
k_breite = 44.90;

k_margin = 0.7;

h_wand = 1;
h_hoehe = k_breite * 3/4;
h_loch = 30;

module viertel(anzahl_karten)
{
	minkowski()
	{
		difference()
		{
			union()
			{
				mock = 0.01;
				x = k_breite/2+h_wand/2+k_margin/2;
				y = anzahl_karten*k_dicke/2+k_margin;
				z = h_hoehe;			
				cube([x,y,0.5]);	// Boden
				translate([0,y,0]) cube([x,mock,z]);	// Front
				translate([x,0,0]) cube([mock,y,z]);	// Seite
			}
			translate([0,0,h_hoehe*3/4]) rotate([-90,0,0])
			hull()
			{
				cylinder(h=anzahl_karten*k_dicke, d=h_loch);
				translate([0,-20,0]) cylinder(h=anzahl_karten*k_dicke, d=h_loch);
			}
		}
		sphere(d=h_wand);
    }

}

module karten(anzahl_karten, margin)
{
	cube([k_breite + margin, k_dicke * anzahl_karten + margin, k_breite + margin], true);
}

module kartenhalter(anzahl_karten)
{
	union()
	{
		viertel(anzahl_karten);
		mirror([1, 0, 0]) viertel(anzahl_karten);
		mirror([0, 1, 0]) viertel(anzahl_karten);
		rotate([0,0,180]) viertel(anzahl_karten);
	}
}

kartenhalter(15);