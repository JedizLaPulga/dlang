
module sys.math.number;

import core.stdc.math;

mixin template MathMethods() {
    Num sqrt() const {
        return Num(core.stdc.math.sqrt(value));
    }

    Num pow(double exponent) const {
        return Num(core.stdc.math.pow(value, exponent));
    }

    Num pow(Num exponent) const {
        return Num(core.stdc.math.pow(value, exponent.value));
    }

    Num abs() const {
        return Num(core.stdc.math.fabs(value));
    }

    Num floor() const {
        return Num(core.stdc.math.floor(value));
    }

    Num ceil() const {
        return Num(core.stdc.math.ceil(value));
    }

    Num round() const {
        return Num(core.stdc.math.round(value));
    }

    Num sin() const {
        return Num(core.stdc.math.sin(value));
    }

    Num cos() const {
        return Num(core.stdc.math.cos(value));
    }

    Num tan() const {
        return Num(core.stdc.math.tan(value));
    }

    Num log() const {
        return Num(core.stdc.math.log(value));
    }

    Num log10() const {
        return Num(core.stdc.math.log10(value));
    }

    Num exp() const {
        return Num(core.stdc.math.exp(value));
    }
}

mixin template NumLineMethods() {
    long min() const {
        return start_val;
    }

    long max() const {
        return end_val;
    }

    long sum() const {
        long result = 0;
        long n = length();
        if (n <= 0) return 0;
        result = (n * (start_val + end_val)) / 2;
        return result;
    }

    double average() const {
        long n = length();
        if (n <= 0) return 0.0;
        return cast(double)sum() / cast(double)n;
    }

    long count() const {
        return length();
    }

    long product() const {
        long result = 1;
        for (long i = start_val; i <= end_val; i++) {
            result *= i;
        }
        return result;
    }

    long range() const {
        return end_val - start_val;
    }

    bool isEven() const {
        return (end_val - start_val) % 2 == 0;
    }
}

struct Num {
    private double value;
    
    alias value this;  // Implicitly convert Num to double
    
    this(T)(T val) {
        this.value = cast(double)val;
    }

    T type(T)() const {
        return cast(T)this.value;
    }

    // Mix in all the badass math methods
    mixin MathMethods;

    // Arithmetic operators
    Num opBinary(string op)(Num rhs) const {
        static if (op == "+") return Num(value + rhs.value);
        else static if (op == "-") return Num(value - rhs.value);
        else static if (op == "*") return Num(value * rhs.value);
        else static if (op == "/") return Num(value / rhs.value);
        else static if (op == "%") return Num(value % rhs.value);
        else static assert(false, "Unsupported operation: " ~ op);
    }

    Num opBinary(string op, T)(T rhs) const {
        static if (op == "+") return Num(value + rhs);
        else static if (op == "-") return Num(value - rhs);
        else static if (op == "*") return Num(value * rhs);
        else static if (op == "/") return Num(value / rhs);
        else static if (op == "%") return Num(value % rhs);
        else static assert(false, "Unsupported operation: " ~ op);
    }

    Num opBinaryRight(string op, T)(T lhs) const {
        static if (op == "+") return Num(lhs + value);
        else static if (op == "-") return Num(lhs - value);
        else static if (op == "*") return Num(lhs * value);
        else static if (op == "/") return Num(lhs / value);
        else static if (op == "%") return Num(lhs % value);
        else static assert(false, "Unsupported operation: " ~ op);
    }

    // Compound assignment operators
    ref Num opOpAssign(string op)(Num rhs) {
        static if (op == "+") value += rhs.value;
        else static if (op == "-") value -= rhs.value;
        else static if (op == "*") value *= rhs.value;
        else static if (op == "/") value /= rhs.value;
        else static if (op == "%") value %= rhs.value;
        else static assert(false, "Unsupported operation: " ~ op);
        return this;
    }

    ref Num opOpAssign(string op, T)(T rhs) {
        static if (op == "+") value += rhs;
        else static if (op == "-") value -= rhs;
        else static if (op == "*") value *= rhs;
        else static if (op == "/") value /= rhs;
        else static if (op == "%") value %= rhs;
        else static assert(false, "Unsupported operation: " ~ op);
        return this;
    }

    // Comparison operators
    int opCmp(Num rhs) const {
        if (value < rhs.value) return -1;
        if (value > rhs.value) return 1;
        return 0;
    }

    int opCmp(T)(T rhs) const {
        if (value < rhs) return -1;
        if (value > rhs) return 1;
        return 0;
    }

    bool opEquals(Num rhs) const {
        return value == rhs.value;
    }

    bool opEquals(T)(T rhs) const {
        return value == rhs;
    }

    // Unary operators
    Num opUnary(string op)() const {
        static if (op == "+") return Num(+value);
        else static if (op == "-") return Num(-value);
        else static assert(false, "Unsupported unary operation: " ~ op);
    }

    // Implicit conversion to numeric types
    T opCast(T)() const {
        return cast(T)value;
    }

    // Hash function for use in associative arrays
    size_t toHash() const {
        import core.stdc.string : memcpy;
        size_t hash;
        memcpy(&hash, &value, (size_t.sizeof < double.sizeof) ? size_t.sizeof : double.sizeof);
        return hash;
    }
}

struct NumLine {
    private long start_val;
    private long end_val;
    private long current;

    this(long start, long end) {
        start_val = start;
        end_val = end;
        current = start;
    }

    // Mix in range math methods
    mixin NumLineMethods;

    long start() const {
        return start_val;
    }

    long end() const {
        return end_val;
    }

    long length() const {
        if (end_val >= start_val)
            return end_val - start_val + 1;
        return 0;
    }

    bool empty() const {
        return current > end_val;
    }

    long front() const {
        return current;
    }

    void popFront() {
        if (current <= end_val)
            current++;
    }

    void reset() {
        current = start_val;
    }

    long opIndex(long index) const {
        if (index >= 0 && index < length())
            return start_val + index;
        return -1;
    }

    bool contains(long value) const {
        return value >= start_val && value <= end_val;
    }
}