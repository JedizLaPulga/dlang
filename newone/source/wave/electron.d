module wave.electron;

struct Electron{
	public:
	immutable double charge = -1.0;
	immutable double mass = 0.511; // in MeV/c^2
	immutable double spin = 1.0/2.0; // in ħ units
	immutable string type = "electron";
	immutable string flavor = "electron";
	immutable string leptonNumber = "1";
}
