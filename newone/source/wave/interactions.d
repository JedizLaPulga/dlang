module wave.interactions;

import wave.electron : Electron;
import wave.photon : Photon;
import wave.gluon : Gluon;
import wave.proton : Proton;
import wave.neutron : Neutron;

enum bool isParticle(T) = __traits(hasMember, T, "charge") && 
                          __traits(hasMember, T, "mass") &&
                          __traits(hasMember, T, "spin");

enum bool isFermion(T) = is(T == struct) && isParticle!T;
enum bool isBoson(T) = is(T == class) && isParticle!T;

struct Interaction(ParticleA, ParticleB) {
	static assert(isParticle!ParticleA, ParticleA.stringof ~ " is not a valid particle");
	static assert(isParticle!ParticleB, ParticleB.stringof ~ " is not a valid particle");
	
	private{
		ParticleA a;
		ParticleB b;
		double conservedCharge;
	}
	
	

	public this(ParticleA a, ParticleB b) {
		this.a = a;
		this.b = b;
		conservedCharge = getCharge(a) + getCharge(b);
		
		validateInteraction();
	}
	
	private void validateInteraction() {
		// Bosons cannot directly interact with bosons in this model
		static if (isBoson!ParticleA && isBoson!ParticleB) {
			static assert(false, "Boson-boson interactions not allowed in this model");
		}
		
		// Charge must be conserved (for this simplified model)
		double totalCharge = conservedCharge;
		if (totalCharge < -2 || totalCharge > 2) {
			throw new Exception("Charge conservation violated!");
		}
	}
	
	private double getCharge(T)(T particle) {
		static if (is(T == Electron)) {
			return particle.charge;
		} else static if (is(T == Proton)) {
			return particle.charge;
		} else static if (is(T == Neutron)) {
			return particle.charge;
		} else static if (is(T == Photon)) {
			return particle.charge;
		} else static if (is(T == Gluon)) {
			return particle.charge;
		} else {
			return 0.0;
		}
	}
	
	public double getConservedCharge() const {
		return conservedCharge;
	}
	
	public string getInteractionType() const {
		static if (isFermion!ParticleA && isFermion!ParticleB) {
			return "Fermion-Fermion";
		} else static if (isFermion!ParticleA && isBoson!ParticleB) {
			return "Fermion-Boson";
		} else {
			return "Unknown";
		}
	}
}
