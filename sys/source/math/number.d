
module sys.math.number;

struct Num {
    double value;
    
    this(T)(T val) {
        value = cast(double)val;
    }
}