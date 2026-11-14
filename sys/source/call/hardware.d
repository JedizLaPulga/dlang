module sys.call.hardware;

import core.stdc.stdlib;
import core.stdc.stdio;
import core.stdc.string;
import core.sys.posix.unistd;
import core.sys.posix.sys.utsname;

struct HardwareInfo {
    const(char)* osSystem;
    const(char)* osRelease;
    const(char)* osVersion;
    const(char)* hostname;
    const(char)* machineType;
    int cpuCoresOnline;
    int cpuCoresConfigured;
    long clockTicksPerSecond;
    long pageSize;
    long totalMemoryPages;
    long availableMemoryPages;
    long totalMemoryBytes;
    long availableMemoryBytes;

    bool isValid() const {
        // Validate all required fields are populated
        return osSystem !is null && osSystem[0] != '\0' &&
               osRelease !is null && osRelease[0] != '\0' &&
               hostname !is null && hostname[0] != '\0' &&
               machineType !is null && machineType[0] != '\0' &&
               cpuCoresOnline > 0 &&
               cpuCoresConfigured > 0 &&
               pageSize > 0 &&
               totalMemoryPages > 0;
    }

    const (char)* toString() const
    in {
        // Precondition: create() must have been called
        assert(isValid(), "HardwareInfo: invalid state - create() must be called first");
    }
    out(result) {
        // Postcondition: result must be non-null
        assert(result !is null, "HardwareInfo: toString() returned null");
    }
    do {
        char* buffer = cast(char*)malloc(2048);
        if (buffer is null) {
            return cast(const(char)*)"Error: malloc failed";
        }
        
        // Build format string
        const(char)* fmt = 
            "===== HARDWARE INFORMATION =====" ~ "\n" ~
            "--- Operating System ---" ~ "\n" ~
            "System: %s" ~ "\n" ~
            "Release: %s" ~ "\n" ~
            "Version: %s" ~ "\n" ~
            "Hostname: %s" ~ "\n" ~ "\n" ~
            "--- CPU Information ---" ~ "\n" ~
            "Machine Type: %s" ~ "\n" ~
            "CPU Cores (Online): %d" ~ "\n" ~
            "CPU Cores (Configured): %d" ~ "\n" ~
            "Clock Ticks/Second: %ld" ~ "\n" ~ "\n" ~
            "--- Memory Information ---" ~ "\n" ~
            "Page Size: %ld bytes" ~ "\n" ~
            "Total Physical Pages: %ld" ~ "\n" ~
            "Total Memory: %ld MB" ~ "\n" ~
            "Total Memory: %ld bytes" ~ "\n" ~
            "Available Physical Pages: %ld" ~ "\n" ~
            "Available Memory: %ld MB" ~ "\n" ~
            "Available Memory: %ld bytes" ~ "\n";
        
        snprintf(buffer, 2048, fmt,
            osSystem, osRelease, osVersion, hostname,
            machineType, cpuCoresOnline, cpuCoresConfigured, clockTicksPerSecond,
            pageSize, totalMemoryPages, totalMemoryBytes / (1024 * 1024), totalMemoryBytes,
            availableMemoryPages, availableMemoryBytes / (1024 * 1024), availableMemoryBytes
        );
        
        return cast(const(char)*)buffer;
    }
}

extern(C) char* strndup(const char* s, size_t n) @nogc nothrow;

// Retrieve all hardware info from system via POSIX calls
HardwareInfo create() {
    HardwareInfo hw;
    
    utsname info;
    uname(&info);
    
    // Allocate persistent copies of system strings
    hw.osSystem = strndup(&info.sysname[0], 65);
    hw.osRelease = strndup(&info.release[0], 65);
    hw.osVersion = strndup(&info.version_[0], 65);
    hw.hostname = strndup(&info.nodename[0], 65);
    hw.machineType = strndup(&info.machine[0], 65);
    
    long onlineCores = sysconf(_SC_NPROCESSORS_ONLN);
    hw.cpuCoresOnline = cast(int)onlineCores;
    
    long configuredCores = sysconf(_SC_NPROCESSORS_CONF);
    hw.cpuCoresConfigured = cast(int)configuredCores;
    
    long clockTicks = sysconf(_SC_CLK_TCK);
    hw.clockTicksPerSecond = clockTicks;
    
    long pageSize = sysconf(_SC_PAGE_SIZE);
    hw.pageSize = pageSize;
    
    long totalPages = sysconf(_SC_PHYS_PAGES);
    hw.totalMemoryPages = totalPages;
    hw.totalMemoryBytes = totalPages * pageSize;
    
    long availPages = sysconf(_SC_AVPHYS_PAGES);
    hw.availableMemoryPages = availPages;
    hw.availableMemoryBytes = availPages * pageSize;
    
    return hw;
}