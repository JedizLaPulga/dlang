import std.stdio;
import wave;



void main(){
	ElectronField!(5) field;

	writefln("Electron at index 0 has charge: %s", field.getElectron(0).charge);
}
