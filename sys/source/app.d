
import sys.call.hardware;
import core.stdc.stdio;
import core.stdc.stdlib;

extern(C) int main() {
	printf("Creating hardware info...\n");
	HardwareInfo hw = create();
	
	if (!hw.isValid()) {
		printf("ERROR: Hardware info is invalid!\n");
		return 1;
	}
	
	printf("Hardware info valid - calling toString():\n\n");
	const(char)* result = hw.toString();
	printf("%s\n", result);
	
	free(cast(void*)result);
	
	return 0;
}