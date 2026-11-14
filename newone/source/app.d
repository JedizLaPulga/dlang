import std.stdio;
import wave;

void main(){
	// Valid interactions
	auto electron = Electron();
	auto photon = new Photon();
	
	auto interaction = Interaction!(Electron, Photon)(electron, photon);
	writefln("Interaction type: %s", interaction.getInteractionType());
	writefln("Conserved charge: %s", interaction.getConservedCharge());
	
	// This would NOT compile:
	// auto bad = Interaction!(Photon, Gluon)(photon, new Gluon()); // Error: Boson-boson not allowed
	
	writefln("Is Electron a fermion? %s", isFermion!Electron);
	writefln("Is Photon a boson? %s", isBoson!Photon);
}

