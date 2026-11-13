module wave.neutron;

import wave.quarks;

struct Neutron{
	public:
	immutable double charge = UpQuark.charge + DownQuark.charge + DownQuark.charge;
	immutable double mass = UpQuark.mass + DownQuark.mass + DownQuark.mass;
	immutable double spin = UpQuark.spin + DownQuark.spin + DownQuark.spin;
	immutable string type = "neutron";
	immutable string color = "white";
	immutable string baryonNumber = "1";
}