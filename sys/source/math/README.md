# Math Module 🔢

A high-performance, betterC-compatible mathematics module for D providing powerful numeric types with built-in operators and range semantics.

## Overview

This module provides two core types:

- **`Num`** - A flexible numeric wrapper supporting arbitrary precision arithmetic and advanced math operations
- **`NumLine`** - A range-based integer sequence with statistical operations over intervals

## The `Num` Type

`Num` is a struct wrapping a `double` value, providing seamless integration with D's operator system and mathematical functions.

### Creation

```d
Num x = Num(10.0);
Num y = Num(3.14159);
Num z = Num(42);  // Implicitly converts int to double
```

### Arithmetic Operations

All standard operators work naturally:

```d
Num x = Num(10.0);
Num y = Num(3.0);

Num sum   = x + y;      // 13.0
Num diff  = x - y;      // 7.0
Num prod  = x * y;      // 30.0
Num quot  = x / y;      // 3.333...
Num mod   = x % y;      // 1.0
```

**Mixed operations with built-in types:**

```d
Num x = Num(10.0);
Num result1 = x + 5;     // Num(15.0)
Num result2 = 2 * x;     // Num(20.0)
Num result3 = x / 2.0;   // Num(5.0)
```

### Comparison Operators

```d
Num a = Num(5.0);
Num b = Num(3.0);

bool greater = a > b;    // true
bool less    = a < b;    // false
bool equal   = a == Num(5.0);  // true
```

### Type Conversion

Use `.type()` for flexible type extraction:

```d
Num pi = Num(3.14159);

double d = pi.type!double();  // 3.14159
int    i = pi.type!int();     // 3
long   l = pi.type!long();    // 3
```

**Implicit conversion via `alias this`:**

```d
Num x = Num(10.0);
printf("%f\n", x);  // Works directly - no explicit cast needed
```

### Math Methods

**Basic arithmetic:**

```d
Num x = Num(16.0);
Num root = x.sqrt();        // 4.0
Num squared = x.pow(2);     // 256.0
Num powered = x.pow(0.5);   // 4.0
Num absolute = Num(-10.0).abs();  // 10.0
```

**Rounding:**

```d
Num x = Num(3.7);
Num floored = x.floor();    // 3.0
Num ceiled  = x.ceil();     // 4.0
Num rounded = x.round();    // 4.0
```

**Trigonometric:**

```d
Num angle = Num(0.785398);  // ~45 degrees in radians
Num s = angle.sin();        // 0.707...
Num c = angle.cos();        // 0.707...
Num t = angle.tan();        // 1.0
```

**Logarithmic:**

```d
Num e_val = Num(2.71828);
Num ln_e = e_val.log();           // 1.0
Num log_100 = Num(100.0).log10(); // 2.0
Num exp_1 = Num(1.0).exp();       // 2.71828...
```

### Hashing

`Num` supports hashing for potential use in associative arrays (outside betterC):

```d
Num a = Num(5.0);
Num b = Num(5.0);
Num c = Num(3.0);

size_t hash_a = a.toHash();  // Consistent
size_t hash_b = b.toHash();  // Same as hash_a
size_t hash_c = c.toHash();  // Different
```

---

## The `NumLine` Type

`NumLine` represents a contiguous range of integers `[start, end]` with compile-time zero-cost range semantics and mathematical operations over the entire interval.

### Creation

```d
NumLine line = NumLine(1, 10);    // Range [1, 2, 3, ..., 10]
NumLine range = NumLine(5, 15);   // Range [5, 6, 7, ..., 15]
```

### Range Properties

```d
NumLine line = NumLine(1, 10);

long start = line.start();    // 1
long end   = line.end();      // 10
long count = line.count();    // 10
long span  = line.range();    // 9 (max - min)
```

### Mathematical Operations

All operations compute over the entire range efficiently:

```d
NumLine line = NumLine(1, 10);

long   min_val = line.min();      // 1
long   max_val = line.max();      // 10
long   sum_val = line.sum();      // 55 (1+2+...+10)
double avg_val = line.average(); // 5.5
long   prod    = line.product(); // 3628800 (10!)
```

### Membership Testing

```d
NumLine line = NumLine(1, 10);

bool in_range = line.contains(5);   // true
bool out_range = line.contains(15); // false
bool at_start = line.contains(1);   // true
```

### Index Access

Access elements by 0-based index:

```d
NumLine line = NumLine(1, 10);

long first = line.opIndex(0);  // 1
long fifth = line.opIndex(4);  // 5
long last  = line.opIndex(9);  // 10
```

### Iteration with foreach

`NumLine` implements D's range interface for natural `foreach` syntax:

```d
NumLine line = NumLine(1, 10);

foreach (long val; line) {
    printf("%ld ", val);  // Prints: 1 2 3 4 5 6 7 8 9 10
}
```

### Reset and State Management

```d
NumLine line = NumLine(1, 5);

line.reset();  // Restart iteration from beginning
bool empty = line.empty();  // Check if iteration is exhausted
```

---

## Combined Usage

Integrate `Num` and `NumLine` for powerful computations:

```d
NumLine nums = NumLine(1, 5);

Num rangeAvg = Num(nums.average());  // 3.0
Num squared  = rangeAvg * rangeAvg;   // 9.0
Num root     = squared.sqrt();        // 3.0
```

**Example: Computing statistics over a range**

```d
NumLine data = NumLine(1, 100);

printf("Min: %ld\n", data.min());           // 1
printf("Max: %ld\n", data.max());           // 100
printf("Sum: %ld\n", data.sum());           // 5050
printf("Average: %f\n", data.average());    // 50.5

Num avg = Num(data.average());
Num deviation = Num(data.max()) - avg;
printf("Max deviation from avg: %f\n", deviation);
```

---

## Design Philosophy

- **Zero-cost abstractions**: All operations compile to efficient machine code (betterC compatible)
- **Natural syntax**: Operators and methods feel like built-in types
- **No allocations**: Stack-based, no GC or dynamic memory needed
- **Type flexibility**: `Num.type()` for explicit type conversions when needed
- **Range semantics**: `NumLine` uses standard D range interface for `foreach` compatibility
- **Compile-time optimizations**: Mixins and templates eliminate code duplication

---

## Implementation Details

### Mixin Templates

**`MathMethods`** - Provides sqrt, pow, sin, cos, tan, log, exp, etc. for `Num`

**`NumLineMethods`** - Provides min, max, sum, average, product for `NumLine`

These are compile-time code templates that expand directly into the struct body, giving methods access to private members with zero runtime overhead.

### Implicit Conversion

`alias value this;` in `Num` allows seamless conversion to `double`:

```d
Num x = Num(10.0);
printf("%f\n", x);  // No cast needed - implicitly converts to double
```

### Range Interface

`NumLine` implements:
- `empty()` - Range exhausted?
- `front()` - Current element
- `popFront()` - Advance to next

This makes it compatible with D's `foreach` and range algorithms.

---

## Examples

### Example 1: Computing Fibonacci via Ranges

```d
NumLine fib_range = NumLine(1, 10);

foreach (long i; fib_range) {
    // Compute fibonacci number at position i
    Num result = Num(i).pow(2);
    printf("Position %ld: %f\n", i, result);
}
```

### Example 2: Statistical Computation

```d
NumLine dataset = NumLine(10, 20);

Num mean = Num(dataset.average());
Num range_span = Num(dataset.max() - dataset.min());
Num normalized = range_span / Num(100.0);

printf("Mean: %f, Normalized span: %f\n", mean, normalized);
```

### Example 3: Precision Arithmetic

```d
Num precision = Num(0.1) + Num(0.2);
Num check = Num(0.3);

printf("0.1 + 0.2 == 0.3? %d\n", precision == check);

// Use .type() for type-safe extraction
double result = precision.type!double();
```

---

## Constraints & Compatibility

- **betterC mode**: ✅ Full support (no GC, no runtime required)
- **Associative Arrays**: ❌ Not available in betterC (but `toHash()` prepared for escape hatch)
- **Exceptions**: ❌ Not available (assert-based validation only)
- **Type**: `Num` uses `double` internally; `NumLine` uses `long` for iteration

---

## Future Enhancements

- [ ] Complex number support
- [ ] Matrix operations on ranges
- [ ] Bitwise operations for NumLine
- [ ] Custom step sizes for ranges
- [ ] Statistical moments (variance, skewness)
