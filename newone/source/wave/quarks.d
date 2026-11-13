module wave.quarks;

package:

struct UpQuark{
	enum double charge = 2.0/3.0;
	enum double mass = 2.3; // in MeV/c^2
	enum double spin = 1.0/2.0; // in ħ units
	enum string type = "up";
}

struct DownQuark{
	enum double charge = -1.0/3.0;
	enum double mass = 4.8; // in MeV/c^2
	enum double spin = 1.0/2.0; // in ħ units
	enum string type = "down";
}
