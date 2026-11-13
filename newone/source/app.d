import std.stdio;
import wave;

void main(){
	// FERMIONS (structs) - cannot coexist in same state
	auto electron1 = Electron();
	
	// BOSONS (classes) - multiple identical instances CAN coexist
	auto photon1 = new Photon();
	auto photon2 = new Photon();  // Same type, but different references!
	
	writeln("Photon 1 type: ", photon1.type);
	writeln("Photon 2 type: ", photon2.type);
	writeln("Same reference? ", photon1 is photon2);  // false - different objects
	writeln("Same type? ", typeid(photon1) == typeid(photon2));  // true - same class
	
	writeln("Electron type: ", electron1.type);
}
