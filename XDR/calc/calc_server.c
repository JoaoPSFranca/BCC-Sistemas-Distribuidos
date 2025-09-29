#include "calc.h"

int *add_1_svc(numbers *argp, struct svc_req *rqstp) {
	static int result;

	printf("add(%d, %d) was called\n",argp->a, argp->b);
	result = argp->a + argp->b;

	return &result;
}

int *sub_1_svc(numbers *argp, struct svc_req *rqstp) {
	static int result;

	printf("sub(%d, %d) was called\n",argp->a, argp->b);
	result = argp->a - argp->b;

	return &result;
}

int *mul_1_svc(numbers *argp, struct svc_req *rqstp) {
	static int result;

	printf("mul(%d, %d) was called\n",argp->a, argp->b);
	result = argp->a * argp->b;

	return &result;
}

int *div_1_svc(numbers *argp, struct svc_req *rqstp) {
	static int result;

	if(argp->b == 0)
		return NULL;

	printf("div(%d, %d) was called\n",argp->a, argp->b);
	result = argp->a / argp->b;

	return &result;
}
