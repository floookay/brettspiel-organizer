$fn = 20;
// $fn = 200;

box=285;
boxz=72;

rules=10;
boards=20;

cardl=88;
cardw=58;

w_min=1.6;
cardsy=w_min+cardl+w_min;
cardsx=200;
cardsz=boxz-rules-boards;

miscy=108;
miscx=box-cardsx-1;
miscz=70;
miscxi=miscx-w_min*2-0.2;
misczi=miscz-w_min-0.2;
miscyi=miscy-w_min*2-0.8;

magnetz=2;
magnetr=10.2/2;

module box() {
	color("grey") difference() {
		translate([-1,-1,-1]) cube([box+2,box+2,boxz+1]);
		cube([box,box,boxz+1]);
	}
}
box();

module cards_full_placeholder(y) {
	color("lightblue") cube([cardsx,y,cardsz]);
}
translate([box-cardsx,box-cardsy,0]) cards_full_placeholder(cardsy);
translate([box-cardsx,box-cardsy-0.5-cardsy,0]) cards_full_placeholder(cardsy);
translate([box-cardsx,box-cardsy-0.5-cardsy-0.5-cardsy,0]) cards_full_placeholder(cardsy);

module misc_drawer() {
	color("lightyellow") difference() {
		cube_rounded([miscx,miscy,miscz], r=w_min);
		translate([w_min,w_min,w_min]) cube([miscx-w_min*2,miscy-w_min*2,miscz]);
		translate([miscx/2,w_min,0]) rotate([-90,0,0]) cylinder(h=miscy-2*w_min, r=20);
	}
}
misc_drawer();

miscz_player = 11;
miscz_duet = 20;
miscz_token = 20;
miscz_eggs = miscyi-miscz_player-miscz_duet-miscz_token-0.4-1;

module misc_player() {
	color("lightgreen") difference() {
		cube_rounded([miscxi,misczi,miscz_player], r=1);
		xtray=(miscxi-3*w_min)/2;
		ytray=(misczi-4*w_min)/3;
		for (i = [0:1]) {
			for (j = [0:2]) {
				translate([w_min+i*(xtray+w_min),w_min+j*(ytray+w_min),w_min]) tray_rounded([xtray,ytray,20],r=4);
			}
		}
		help=10;
		translate([help,help,miscz_player/2+2]) tray_rounded([miscxi-2*help,misczi-2*help,20],r=4);
		xicon=(miscxi-30)/6;
		cubex=5;
		for (i=[0:3]) {
			translate([w_min+15+xicon+cubex/2+i*xicon,-cubex/2+0.8,miscz_player/2]) cube(cubex, center=true);
			translate([w_min+15+xicon+cubex/2+i*xicon,misczi+cubex/2-0.8,miscz_player/2]) cube(cubex, center=true);
		}
	}
}
translate([0,miscz_player,0])
translate([w_min,w_min,w_min]) rotate([90,0,0])
misc_player();

module misc_duet() {
	color("white") difference() {
		union() {
			difference() {
				cube_rounded([miscxi,misczi,miscz_duet], r=1);
				offset=2;
				yingyangr=misczi-2*w_min-offset;
				translate([w_min,w_min,w_min]) tray_rounded([miscxi-2*w_min,misczi-2*w_min,miscz_duet]);
			}
			seperatorr=(misczi+w_min)/4;
			translate(v = [miscxi/2,seperatorr,0])
			difference() {
				cylinder(h = miscz_duet, r = seperatorr);
				cylinder(h = miscz_duet, r = seperatorr-w_min);
				translate(v = [-100,-100,0]) cube([100,200,100]);
			}
			translate(v = [miscxi/2,seperatorr*3-w_min,0]) rotate([0,0,180]) difference() {
				cylinder(h = miscz_duet, r = seperatorr);
				cylinder(h = miscz_duet, r = seperatorr-w_min);
				translate(v = [-100,-100,0]) cube([100,200,100]);
			}
		}
		iconr=10;
		translate([miscxi/2+2,0.8,miscz_duet/2]) rotate([90,0,0]) ying_yang(iconr,iconr);
		translate([miscxi/2-2,0.8,miscz_duet/2]) rotate([90,0,0]) rotate([0,0,180]) ying_yang(iconr,iconr);
		translate([0,misczi+iconr-2*0.8,0]) translate([miscxi/2+2,0.8,miscz_duet/2]) rotate([90,0,0]) ying_yang(iconr,iconr);
		translate([0,misczi+iconr-2*0.8,0]) translate([miscxi/2-2,0.8,miscz_duet/2]) rotate([90,0,0]) rotate([0,0,180]) ying_yang(iconr,iconr);
	}
}
module ying_yang(r,h){
	rotate([0,0,90]) linear_extrude(h){
		union(){
			difference(){
				difference(){
					circle(r=r/2);
					translate([-r/2,0]) square([r,r/2]);
				}
				translate([-r/4,0]) circle(r=r/4);
			}
			translate([r/4,0]) circle(r=r/4);
		}
	}
}
translate([0,miscz_player+miscz_duet,0])
translate([w_min,w_min,w_min]) rotate([90,0,0])
misc_duet();

module misc_tokens(){
	color("yellow") difference() {
		cube_rounded([miscxi,misczi,miscz_token], r=1);
		translate([w_min,w_min,w_min]) tray_rounded([miscxi-2*w_min,misczi-2*w_min,miscz_token]);
		xicon=(miscxi-30)/6;
		cubex=10;
		translate([miscxi/2,-cubex/2+0.8,miscz_token/2]) icontoken(cubex);
		translate([miscxi/2,misczi+cubex/2-0.8,miscz_token/2]) icontoken(cubex);
	}
}
module icontoken(x) {
	rotate([90,0,0]) difference() {
		cube(x, center=true);
		translate(v = [0,0,-x/2+0.2]) difference() {
			cube([x,x,0.4], center=true);
			rotate([0,0,45]) cube([x,x,0.4],center=true);
		}
		translate(v = [0,0,x/2-0.2]) difference() {
			cube([x,x,0.4], center=true);
			rotate([0,0,45]) cube([x,x,0.4],center=true);
		}
	}
}
translate([0,miscz_player+miscz_duet+miscz_token,0])
translate([w_min,w_min,w_min]) rotate([90,0,0])
misc_tokens();

module misc_eggs(){
	color("orange") difference() {
		cube_rounded([miscxi,misczi,miscz_eggs], r=1);
		translate([w_min,w_min,w_min]) tray_rounded([miscxi-2*w_min,misczi-2*w_min,miscz_eggs]);
		xicon=(miscxi-30)/6;
		cubex=10;
		translate([miscxi/2,0.8,miscz_eggs/2]) rotate([90,0,0]) linear_extrude(height = cubex) scale(0.06) import("./svg/egg.svg",center=true);
		translate([miscxi/2,misczi+cubex-0.8,miscz_eggs/2]) rotate([90,0,0]) linear_extrude(height = cubex) scale(0.06) import("./svg/egg.svg",center=true);
		// translate([miscxi/2,misczi+cubex/2-0.8,miscz_token/2]) icontoken(cubex);
	}
}
translate([0,miscz_player+miscz_duet+miscz_token+miscz_eggs,0])
translate([w_min,w_min,w_min]) rotate([90,0,0])
misc_eggs();

etcy=box-cardsy-cardsy-1;
foodx=cardsx-w_min*2;
foodxd=foodx-0.2-1;
foody=etcy-w_min*2-cardw;
foodyd=foody-w_min-0.2-1;
foodz=cardsz-w_min*2;
foodzd=(foodz-0.2-1)/2;
etco=10;

module etc_cards() {
	difference() {
		cube_rounded([cardsx,etcy,cardsz]);
		x_min = w_min;
		// x_min = w_min*2;
		// x_min = (cardsx-2*cardl)/3;
		translate([x_min,etcy-w_min-cardw,w_min]) union() {
			cube_rounded([cardl,cardw,cardsz]);
			translate([cardl/2,cardw,-w_min-1]) cylinder(h = cardsz+2, r = 25);
		}
		translate([cardsx-x_min-cardl,etcy-w_min-cardw,w_min]) union() {
			cube_rounded([cardl,cardw,cardsz]);
			translate([cardl/2,cardw,-w_min-1]) cylinder(h = cardsz+2, r = 25);
		}
		translate([w_min,-etcy+foody,w_min]) cube([foodx,etcy,foodz]);
		translate([-1,-etcy+foody-etco,-1]) cube([cardsx+2,etcy,cardsz+2]);
		// finger hole
		spacex = cardsx-(x_min+cardl+w_min+w_min+cardl+x_min);
		translate([x_min+cardl+w_min,etcy-w_min-cardw,w_min]) cube([spacex,cardw+w_min,cardsz]);
	}
}
translate([miscx+1,0,0]) etc_cards();

module etc_drawer() {
	x_min = w_min;
	spacex = cardsx-(x_min+cardl+w_min+w_min+cardl+x_min) - 0.2;
	x=cardw+w_min-0.2;
	y=cardsz-w_min-0.1;
	z=spacex-0.2;
	r=w_min;
	difference() {
		cube_rounded([x,y,z], r=r+w_min);
		translate([w_min,w_min,w_min]) tray_rounded([x-2*w_min,y-2*w_min,z], r=r);
	}
}
etc_drawer();

module etc_food1() {
	// worms, berries, crop
	difference() {
		cube_rounded([foodxd,foodyd,foodzd], r=1);
		xtray=(foodxd-4*w_min)/3;
		ytray=foodyd-2*w_min;
		for (i = [0:2]) {
			translate([w_min+i*(xtray+w_min),w_min,w_min]) tray_rounded([xtray,ytray,20],r=5);
		}
	}
}
translate([miscx+1+w_min,w_min,w_min]) etc_food1();

module etc_food2() {
	// fish, mouse, nectar
	difference() {
		cube_rounded([foodxd,foodyd,foodzd], r=1);
		smalltrayx=54;
		largetrayx=foodxd-4*w_min-2*smalltrayx;
		ytray=foodyd-2*w_min;
		translate([w_min,w_min,w_min]) tray_rounded([smalltrayx,ytray,20],r=5);
		translate([w_min+smalltrayx+w_min,w_min,w_min]) tray_rounded([smalltrayx,ytray,20],r=5);
		translate([w_min+smalltrayx+w_min+smalltrayx+w_min,w_min,w_min]) tray_rounded([largetrayx,ytray,20],r=5);
	}
}
translate([miscx+1+w_min,w_min,w_min+foodzd]) etc_food2();

module etc_lid() {
	difference() {
		cube_rounded([cardsx,foody,cardsz],r=w_min);
		translate([-1,foody-etco,-1]) cube([cardsx+2,foody,cardsz+2]);
		translate([w_min,w_min,w_min]) cube([cardsx-2*w_min,foody,cardsz-2*w_min]);
	}
}
translate([miscx+1,0,0]) etc_lid();

// helpers
module cube_rounded(v, r=3, center=false){
	translate(center==true ? [r-v[0]/2,r-v[1]/2,-v[2]/2] : [r,r,0])
	union(){
		cylinder(h = v[2], r = r);
		translate(v = [0,v[1]-2*r,0]) cylinder(h = v[2], r = r);
		translate(v = [v[0]-2*r,v[1]-2*r,0]) cylinder(h = v[2], r = r);
		translate(v = [v[0]-2*r,0,0]) cylinder(h = v[2], r = r);
		translate(v = [-r,0,0]) cube([v[0],v[1]-2*r,v[2]]);
		translate(v = [0,-r,0]) cube([v[0]-2*r,v[1],v[2]]);
	}
}
module tray_rounded(v, r=3, center=false){
	translate(center==true ? [r-v[0]/2,r-v[1]/2,v[2]/2] : [r,r,0])
	translate(v = [0,0,r]) hull(){
		cylinder(h = v[2]-r, r = r);
		sphere(r = r);
		translate(v = [0,v[1]-2*r,0]) cylinder(h = v[2]-r, r = r);
		translate(v = [0,v[1]-2*r,0]) sphere(r = r);
		translate(v = [v[0]-2*r,v[1]-2*r,0]) cylinder(h = v[2]-r, r = r);
		translate(v = [v[0]-2*r,v[1]-2*r,0]) sphere(r = r);
		translate(v = [v[0]-2*r,0,0]) cylinder(h = v[2]-r, r = r);
		translate(v = [v[0]-2*r,0,0]) sphere(r = r);
	}
}