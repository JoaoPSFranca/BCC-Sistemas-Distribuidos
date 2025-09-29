#include "calc.h"

void calc_prog_1(char *host, int x, int y, int opt) {
	CLIENT *clnt;
	int *result_1;
	numbers calc_1_arg;

	#ifndef DEBUG
	clnt = clnt_create(host, CALC_PROG, CALC_VERS, "udp");
	if (clnt == NULL)
	{
		clnt_pcreateerror(host);
		exit(1);
	}	
	#endif /* DEBUG */

	calc_1_arg.a = x;
	calc_1_arg.b = y;

	switch(opt) {
		case 1:
			result_1 = add_1(&calc_1_arg, clnt);
			break;
		case 2:
			result_1 = sub_1(&calc_1_arg, clnt);
			break;
		case 3:
			result_1 = mul_1(&calc_1_arg, clnt);
			break;
		case 4:
			result_1 = div_1(&calc_1_arg, clnt);
			break;
	}

	if (result_1 == (int *)NULL) {
		clnt_perror(clnt, "call failed");
	} else { 
		printf("Result: %d\n",*result_1);
	}

	#ifndef DEBUG
	clnt_destroy(clnt);
	#endif /* DEBUG */
}

int main(int argc, char *argv[]) {
	char *host;

	if (argc < 5) {
		printf("usage: %s server_host\n", argv[0]);
		exit(1);
	}

	host = argv[1];

	switch (argv[3][0]) {
		case '+':
			calc_prog_1(host, atoi(argv[2]), atoi(argv[4]), 1);	
			break;
		
		case '-':
			calc_prog_1(host, atoi(argv[2]), atoi(argv[4]), 2);	
			break;
		
		case 'x':
			calc_prog_1(host, atoi(argv[2]), atoi(argv[4]), 3);	
			break;
		
		case '/':
			calc_prog_1(host, atoi(argv[2]), atoi(argv[4]), 4);	
			break;
		
		default:
			printf ("usage: %s server_host NUMBER OPERATION NUMBER\n", argv[0]); //Essa linha foi alterada
			break;
	}
	exit(0);
}
