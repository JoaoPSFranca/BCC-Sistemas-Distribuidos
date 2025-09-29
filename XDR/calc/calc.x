struct numbers {
	int a;
	int b;
};

program CALC_PROG {
	version CALC_VERS {
		int add(numbers)=1;
		int sub(numbers)=2;
		int mul(numbers)=3;
		int div(numbers)=4;
	}=1;
}=0x23451111;

