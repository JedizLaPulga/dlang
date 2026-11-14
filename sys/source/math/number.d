
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