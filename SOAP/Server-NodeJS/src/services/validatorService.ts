import { validateCPF, validateCNPJ } from '../utils/validators';

type DocumentType = 'CPF' | 'CNPJ';

interface IDocumentInput {
  documentNumber: string;
  documentType: DocumentType;
}

interface IValidationOutput {
  isValid: boolean;
  message: string;
}

export const validatorService = {
  ValidatorService: {
    ValidatorPort: {
      validateDocument: (args: IDocumentInput): IValidationOutput => {
        const { documentNumber, documentType } = args;

        let isValid = false;
        let message = '';

        if (documentType === 'CPF') {
          isValid = validateCPF(documentNumber);
          message = isValid ? 'CPF válido' : 'CPF inválido';
        } else if (documentType === 'CNPJ') {
          isValid = validateCNPJ(documentNumber);
          message = isValid ? 'CNPJ válido' : 'CNPJ inválido';
        } else {
          isValid = false; 
          message = 'Tipo de documento desconhecido';
        }

        return {
          isValid: isValid,
          message: message,
        };
      },
    },
  },
};