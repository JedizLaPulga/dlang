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


struct ElectronField(int num){
	private:
	Electron[] electrons;
	
	public:
	static ElectronField opCall() {
		ElectronField field;
		field.electrons.length = num;
		return field;
	}
	
	Electron getElectron(int index){
		
		return electrons[index];
	}

	Electron[] iter(){
		return electrons.dup;
	}
}
