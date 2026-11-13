import std.stdio;
import wave;

void main(){
	auto field = ElectronField!(5)();

	writefln("Electron at index 0 has charge: %s", field.getElectron(0).charge);
}

