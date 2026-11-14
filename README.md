# dlang - Interesting betterC Stuff for Linux

A collection of interesting D language experiments and utilities built with **betterC** mode for Linux systems. Focuses on system programming with zero garbage collection overhead.

## Features

### Hardware Information Module (`sys/syscall/hardware.d`)

Retrieve detailed hardware information from your Linux system using pure POSIX C interoperability.

**Provides:**
- **OS Information**: System name, release, version, hostname
- **CPU Information**: Machine type, online cores, configured cores, clock ticks/second
- **Memory Information**: Page size, total memory, available memory (in bytes and MB)

**Key Methods:**
- `HardwareInfo create()` - Retrieves all hardware information
- `bool isValid()` - Validates hardware state (ensures create() was called properly)
- `const(char)* toString()` - Returns formatted string of all hardware details with contracts

```d
HardwareInfo hw = create();
if (hw.isValid()) {
    printf("%s\n", hw.toString());
}
```

### Clock/Timer Module (`sys/syscall/hardware.d`)

High-precision timing utilities with pause/resume support.

**Time struct features:**
- `long elapsedNanoseconds()` - Get elapsed time in nanoseconds
- `bool isExpired()` - Check if timer exceeded maximum

**Clock struct features:**
- `long elapsedNanoseconds()` - High-precision elapsed time
- Multiple time units: `elapsedMicroseconds()`, `elapsedMilliseconds()`, `elapsedSeconds()`, `elapsedSecondsAsDouble()`, `elapsedMinutes()`
- `void pause()` / `void resume()` - Pause and resume timing
- `bool isPaused()` - Check pause state
- `void reset()` - Restart the timer
- Automatic output on destruction (RAII)

```d
Clock clock = Clock(0);
sleep(2);
clock.pause();
// ... do something while paused ...
clock.resume();
printf("Elapsed: %.3f seconds\n", clock.elapsedSecondsAsDouble());
clock.reset();  // Start fresh
```

## Building

### Requirements
- D compiler (DMD, LDC2, or GDC)
- DUB package manager
- Linux system

### Compile

```bash
cd sys
dub build
```

### Run

```bash
./sys
```

## Example Output

```
Creating hardware info...
Hardware info valid - calling toString():

===== HARDWARE INFORMATION =====
--- Operating System ---
System: Linux
Release: 6.x.x-xx-generic
Version: #xx-Ubuntu SMP PREEMPT_DYNAMIC [REDACTED] UTC [YEAR]
Hostname: [HOSTNAME_REDACTED]

--- CPU Information ---
Machine Type: x86_64
CPU Cores (Online): 16
CPU Cores (Configured): 16
Clock Ticks/Second: 100

--- Memory Information ---
Page Size: 4096 bytes
Total Physical Pages: 3815897
Total Memory: 14905 MB
Total Memory: 15629914112 bytes
Available Physical Pages: 2257233
Available Memory: 8817 MB
Available Memory: 9245626368 bytes
```

*Note: Sensitive information (hostname, kernel build date/time, timezone) has been redacted from this example for privacy reasons.*

## Project Structure

```
dlang/
├── README.md
├── sys/
│   ├── dub.json
│   ├── source/
│   │   ├── app.d           # Main application
│   │   └── syscall/
│   │       └── hardware.d  # Hardware info & timing utilities
│   └── package.d
└── .gitignore
```

## Key Design Principles

✅ **betterC Mode** - No garbage collection, pure C interoperability  
✅ **Zero Runtime Overhead** - Direct system calls via POSIX  
✅ **Contract-Based Programming** - Input/output validation with `in`/`out` contracts  
✅ **Code Reuse** - Mixin templates to eliminate duplication  
✅ **Memory Safe** - Proper allocation/deallocation with validation  
✅ **Linux POSIX Compliant** - Uses standard system interfaces  

## Implementation Details

### HardwareInfo Validation

The `isValid()` method verifies:
- All string fields are non-null and non-empty
- All numeric fields are positive
- State is valid for use

### toString() Contracts

- **In Contract**: Asserts `isValid()` - create() must be called first
- **Out Contract**: Validates result is non-null
- **Implementation**: Allocates 2KB buffer with formatted output

### Time Unit Mixin

The `TimeUnitMethods` mixin template is shared between `Time` and `Clock` structs, providing consistent time conversion methods without code duplication.

## Imports Used

```d
import core.stdc.stdlib;      // malloc, free
import core.stdc.stdio;       // printf, snprintf
import core.stdc.string;      // strlen
import core.sys.posix.unistd; // sysconf, sleep, usleep
import core.sys.posix.sys.utsname; // uname
```

## Author

Created as an exploration of interesting D language features and system programming with betterC mode.

## License

Proprietary (2026)

---

**Contributions Welcome!** - Feel free to explore, experiment, and extend with more interesting betterC utilities for Linux.
