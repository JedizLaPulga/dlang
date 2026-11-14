module sys.call.math.number;

import core.stdc.math;
import core.stdc.stdlib;

// Safe integer operations with overflow detection
struct SafeInt {
    long value;
    bool overflowed;
    
    this(long val) {
        value = val;
        overflowed = false;
    }
    
    SafeInt add(long other) const {
        SafeInt result;
        if ((other > 0 && value > long.max - other) ||
            (other < 0 && value < long.min - other)) {
            result.overflowed = true;
            result.value = 0;
        } else {
            result.value = value + other;
        }
        return result;
    }
    
    SafeInt multiply(long other) const {
        SafeInt result;
        if (value != 0 && (other > long.max / value || other < long.min / value)) {
            result.overflowed = true;
            result.value = 0;
        } else {
            result.value = value * other;
        }
        return result;
    }
}

// Fast exponentiation using binary exponentiation
long power(long base, int exp) {
    if (exp < 0) return 0;
    if (exp == 0) return 1;
    
    long result = 1;
    long b = base;
    
    while (exp > 0) {
        if (exp % 2 == 1) {
            result *= b;
        }
        b *= b;
        exp /= 2;
    }
    
    return result;
}

// Greatest Common Divisor via Euclidean algorithm
long gcd(long a, long b) {
    if (a < 0) a = -a;
    if (b < 0) b = -b;
    
    while (b != 0) {
        long temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

// Least Common Multiple
long lcm(long a, long b) {
    if (a == 0 || b == 0) return 0;
    return (a / gcd(a, b)) * b;
}

// Primality testing
bool isPrime(long n) {
    if (n < 2) return false;
    if (n == 2) return true;
    if (n % 2 == 0) return false;
    if (n < 9) return true;
    if (n % 3 == 0) return false;
    
    long limit = cast(long)sqrt(cast(double)n);
    for (long i = 5; i <= limit; i += 6) {
        if (n % i == 0 || n % (i + 2) == 0) {
            return false;
        }
    }
    return true;
}

// Fibonacci sequence generation
long fibonacci(int n) {
    if (n <= 0) return 0;
    if (n == 1) return 1;
    
    long a = 0, b = 1;
    for (int i = 2; i <= n; i++) {
        long temp = a + b;
        a = b;
        b = temp;
    }
    return b;
}

// Factorial with overflow detection
struct FactResult {
    long value;
    bool overflowed;
}

FactResult factorial(int n) {
    FactResult result;
    result.overflowed = false;
    
    if (n < 0) {
        result.overflowed = true;
        result.value = 0;
        return result;
    }
    
    if (n == 0 || n == 1) {
        result.value = 1;
        return result;
    }
    
    long fact = 1;
    for (int i = 2; i <= n; i++) {
        if (fact > long.max / i) {
            result.overflowed = true;
            result.value = 0;
            return result;
        }
        fact *= i;
    }
    
    result.value = fact;
    return result;
}

// Linear Congruential Generator for random numbers
struct LCG {
    ulong seed;
    
    this(ulong initialSeed) {
        seed = initialSeed;
    }
    
    // Generate next random number
    ulong next() {
        seed = (seed * 1103515245UL + 12345UL) & 0x7fffffffUL;
        return seed;
    }
    
    // Random double in [0.0, 1.0)
    double nextDouble() {
        return cast(double)next() / 0x7fffffffUL;
    }
    
    // Random int in [0, max)
    int nextInt(int max) {
        return cast(int)(next() % max);
    }
}
