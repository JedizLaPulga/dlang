module wave.proton;

import wave.quarks;

struct Proton{
	public:
	immutable double charge = UpQuark.charge + UpQuark.charge + DownQuark.charge;
	immutable double mass = UpQuark.mass + UpQuark.mass + DownQuark.mass;
	immutable double spin = UpQuark.spin + UpQuark.spin + DownQuark.spin;
	immutable string type = "proton";
	immutable string color = "white";
	immutable string baryonNumber = "1";
}
