
import sys.math.number;
import core.stdc.stdio : printf;

extern(C) int main() {
	printf("=== NUM TYPE EXAMPLES ===\n\n");
	
	printf("--- Creation and Basic Operations ---\n");
	Num x = Num(10.0);
	Num y = Num(3.0);
	printf("x = %f\n", x);
	printf("y = %f\n", y);
	printf("x + y = %f\n", x + y);
	printf("x - y = %f\n", x - y);
	printf("x * y = %f\n", x * y);
	printf("x / y = %f\n", x / y);
	printf("\n");

	printf("--- Type Conversion with .type() ---\n");
	Num pi = Num(3.14159);
	printf("pi as double: %f\n", pi.type!double());
	printf("pi as int: %d\n", pi.type!int());
	printf("pi as long: %ld\n", pi.type!long());
	printf("\n");

	printf("--- Math Methods ---\n");
	Num sixteen = Num(16.0);
	printf("sqrt(16) = %f\n", sixteen.sqrt());
	printf("16^2 = %f\n", sixteen.pow(2));
	printf("16^0.5 = %f\n", sixteen.pow(0.5));
	printf("abs(-10) = %f\n", Num(-10.0).abs());
	printf("floor(3.7) = %f\n", Num(3.7).floor());
	printf("ceil(3.2) = %f\n", Num(3.2).ceil());
	printf("\n");

	printf("--- Trigonometric Functions ---\n");
	Num angle = Num(0.785398);
	printf("sin(0.785398) = %f\n", angle.sin());
	printf("cos(0.785398) = %f\n", angle.cos());
	printf("tan(0.785398) = %f\n", angle.tan());
	printf("\n");

	printf("--- Logarithmic Functions ---\n");
	Num e = Num(2.71828);
	printf("log(e) = %f\n", e.log());
	printf("log10(100) = %f\n", Num(100.0).log10());
	printf("exp(1) = %f\n", Num(1.0).exp());
	printf("\n");

	printf("--- Comparisons and Hash ---\n");
	Num a = Num(5.0);
	Num b = Num(5.0);
	Num c = Num(3.0);
	printf("5 == 5? %d\n", a == b);
	printf("5 > 3? %d\n", a > c);
	printf("5 < 3? %d\n", a < c);
	printf("hash(5.0): %zu\n", a.toHash());
	printf("hash(5.0): %zu (same)\n", b.toHash());
	printf("\n");

	printf("=== NUMLINE TYPE EXAMPLES ===\n\n");

	printf("--- Creation and Basic Properties ---\n");
	NumLine range1 = NumLine(1, 10);
	printf("Range [1, 10]\n");
	printf("Start: %ld\n", range1.start());
	printf("End: %ld\n", range1.end());
	printf("Count: %ld\n", range1.count());
	printf("Span: %ld\n", range1.range());
	printf("\n");

	printf("--- Mathematical Operations Over Range ---\n");
	printf("Min: %ld\n", range1.min());
	printf("Max: %ld\n", range1.max());
	printf("Sum: %ld\n", range1.sum());
	printf("Average: %f\n", range1.average());
	printf("Product: %ld\n", range1.product());
	printf("Is even count? %d\n", range1.isEven());
	printf("\n");

	printf("--- Membership Testing ---\n");
	printf("Contains 5? %d\n", range1.contains(5));
	printf("Contains 15? %d\n", range1.contains(15));
	printf("Contains 1? %d\n", range1.contains(1));
	printf("\n");

	printf("--- Accessing by Index ---\n");
	printf("Element at index 0: %ld\n", range1.opIndex(0));
	printf("Element at index 4: %ld\n", range1.opIndex(4));
	printf("Element at index 9: %ld\n", range1.opIndex(9));
	printf("\n");

	printf("--- Iteration with foreach ---\n");
	printf("Iterating [1, 10]: ");
	foreach (long val; range1) {
		printf("%ld ", val);
	}
	printf("\n\n");

	printf("--- Different Range ---\n");
	NumLine range2 = NumLine(5, 15);
	printf("Range [5, 15]\n");
	printf("Sum: %ld\n", range2.sum());
	printf("Average: %f\n", range2.average());
	printf("Elements: ");
	foreach (long val; range2) {
		printf("%ld ", val);
	}
	printf("\n\n");

	printf("--- Combined Example ---\n");
	NumLine nums = NumLine(1, 5);
	printf("Computing with NumLine and Num together:\n");
	Num rangeAvg = Num(nums.average());
	Num squared = rangeAvg * rangeAvg;
	printf("Average of [1,5]: %f\n", rangeAvg);
	printf("Average squared: %f\n", squared);
	printf("Square root of squared: %f\n", squared.sqrt());
	printf("\n");

	return 0;
}