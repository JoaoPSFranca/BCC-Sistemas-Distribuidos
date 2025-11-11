import { validatorService } from './validatorService';

interface IServiceDefinition {
  name: string;
  path: string;
  service: any;
  wsdlFile: string;
}

export const allServices: IServiceDefinition[] = [
  {
    name: 'ValidatorService',
    path: '/validator',
    service: validatorService,
    wsdlFile: 'validator.wsdl',
  },
];