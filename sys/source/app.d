
import sys.math.number;
import core.stdc.stdio : printf;

extern(C) int main() {
	Num x = Num(16.0);
	Num y = Num(2.0);
	Num z = Num(3.14159);

	printf("x = %f\n", x);
	printf("sqrt(x) = %f\n", x.sqrt());
	printf("x.pow(2) = %f\n", x.pow(2));
	printf("x.pow(y) = %f\n", x.pow(y));
	printf("abs(-x) = %f\n", (-x).abs());
	printf("floor(z) = %f\n", z.floor());
	printf("ceil(z) = %f\n", z.ceil());
	printf("sin(z) = %f\n", z.sin());
	printf("cos(z) = %f\n", z.cos());
	printf("exp(1) = %f\n", Num(1.0).exp());
	printf("log(x) = %f\n", x.log());

	return 0;
}