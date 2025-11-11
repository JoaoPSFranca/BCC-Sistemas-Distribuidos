interface IHelloInput {
  name: string;
}

interface IHelloOutput {
  greeting: string;
}

export const helloService = {
  HelloService: {
    HelloPort: {
      sayHello: (args: IHelloInput): IHelloOutput => {
        return {
          greeting: `Olá, ${args.name}!`,
        };
      },
    },
  },
};