function clean(doc: string): string {
  return doc.replace(/[^\d]/g, '');
}

function isInvalidSequence(doc: string): boolean {
  return /^(.)\1+$/.test(doc);
}

function calculateCheckDigit(doc: string, weights: number[]): number {
  let sum = 0;
  for (let i = 0; i < doc.length; i++) {
    sum += parseInt(doc[i]) * weights[i];
  }
  const remainder = sum % 11;
  const digit = remainder < 2 ? 0 : 11 - remainder;
  return digit;
}

export function validateCPF(cpf: string): boolean {
  const cleanedCpf = clean(cpf);

  if (cleanedCpf.length !== 11 || isInvalidSequence(cleanedCpf)) {
    return false;
  }

  const baseDigits = cleanedCpf.substring(0, 9);
  const checkDigits = cleanedCpf.substring(9);

  const weights1 = [10, 9, 8, 7, 6, 5, 4, 3, 2];
  const digit1 = calculateCheckDigit(baseDigits, weights1);

  const weights2 = [11, 10, 9, 8, 7, 6, 5, 4, 3, 2];
  const digit2 = calculateCheckDigit(baseDigits + digit1, weights2);

  return checkDigits === `${digit1}${digit2}`;
}

export function validateCNPJ(cnpj: string): boolean {
  const cleanedCnpj = clean(cnpj);

  if (cleanedCnpj.length !== 14 || isInvalidSequence(cleanedCnpj)) {
    return false;
  }

  const baseDigits = cleanedCnpj.substring(0, 12);
  const checkDigits = cleanedCnpj.substring(12);

  const weights1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
  const digit1 = calculateCheckDigit(baseDigits, weights1);

  const weights2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
  const digit2 = calculateCheckDigit(baseDigits + digit1, weights2);

  return checkDigits === `${digit1}${digit2}`;
}