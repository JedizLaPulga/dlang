
import sys.syscall.hardware;
import core.stdc.stdio;
import core.stdc.string;
import core.sys.posix.sys.utsname;

extern(C) int main() {
	HardwareInfo hw = create();
	
	// Get fresh uname for string display (avoiding char array casting issues)
	utsname info;
	uname(&info);
	
	printf("===== HARDWARE INFORMATION =====\n\n");
	
	printf("--- Operating System ---\n");
	printf("System: %.65s\n", &info.sysname[0]);
	printf("Release: %.65s\n", &info.release[0]);
	printf("Version: %.65s\n", &info.version_[0]);
	printf("Hostname: %.65s\n\n", &info.nodename[0]);
	
	printf("--- CPU Information ---\n");
	printf("Machine Type: %.65s\n", &info.machine[0]);
	printf("CPU Cores (Online): %d\n", hw.cpuCoresOnline);
	printf("CPU Cores (Configured): %d\n", hw.cpuCoresConfigured);
	printf("Clock Ticks/Second: %ld\n\n", hw.clockTicksPerSecond);
	
	printf("--- Memory Information ---\n");
	printf("Page Size: %ld bytes\n", hw.pageSize);
	printf("Total Physical Pages: %ld\n", hw.totalMemoryPages);
	printf("Total Memory: %ld MB\n", hw.totalMemoryBytes / (1024 * 1024));
	printf("Total Memory: %ld bytes\n", hw.totalMemoryBytes);
	printf("\n");
	printf("Available Physical Pages: %ld\n", hw.availableMemoryPages);
	printf("Available Memory: %ld MB\n", hw.availableMemoryBytes / (1024 * 1024));
	printf("Available Memory: %ld bytes\n", hw.availableMemoryBytes);
	printf("\n");
	
	return 0;
}