import * as soap from 'soap';

async function testValidateDocument() {
  const url = 'http://localhost:3000/validator?wsdl';
  console.log('Executando teste: testValidateDocument (com lógica real)...');

  try {
    const client = await soap.createClientAsync(url);
    console.log('Cliente "validator" criado. WSDL lido com sucesso.');

    // CPF Valido (com formatacao)
    const argsCpfValido = {
      documentNumber: '263.231.350-83',
      documentType: 'CPF'
    };
    console.log(`\nChamando "validateDocument" com: ${JSON.stringify(argsCpfValido)}`);
    const [resultCpfValido] = await client.validateDocumentAsync(argsCpfValido);
    console.log('Resposta (CPF Válido):', resultCpfValido);

    // CPF Invalido (digito verificador errado)
    const argsCpfInvalido = {
      documentNumber: '26323135084',
      documentType: 'CPF'
    };
    console.log(`\nChamando "validateDocument" com: ${JSON.stringify(argsCpfInvalido)}`);
    const [resultCpfInvalido] = await client.validateDocumentAsync(argsCpfInvalido);
    console.log('Resposta (CPF Inválido - Dígito):', resultCpfInvalido);
    
    // CNPJ Valido (sem formatacao)
    const argsCnpjValido = {
      documentNumber: '54550752000155',
      documentType: 'CNPJ'
    };
    console.log(`\nChamando "validateDocument" com: ${JSON.stringify(argsCnpjValido)}`);
    const [resultCnpjValido] = await client.validateDocumentAsync(argsCnpjValido);
    console.log('Resposta (CNPJ Válido):', resultCnpjValido);

    // CNPJ Invalido (sequencia) 
    const argsCnpjInvalidoSeq = {
      documentNumber: '11.111.111/1111-11',
      documentType: 'CNPJ'
    };
    console.log(`\nChamando "validateDocument" com: ${JSON.stringify(argsCnpjInvalidoSeq)}`);
    const [resultCnpjInvalidoSeq] = await client.validateDocumentAsync(argsCnpjInvalidoSeq);
    console.log('Resposta (CNPJ Inválido - Sequência):', resultCnpjInvalidoSeq);

  } catch (err) {
    console.error('\nFalha ao chamar o serviço "validator":');
    if (err instanceof Error) {
      if ('response' in err && err.response) {
        const response = (err as any).response;
        console.error(`Status: ${response.status}`);
        console.error(`Body: ${response.data}`);
      } else {
        console.error(err.message);
      }
    } else {
      console.error('Um erro desconhecido ocorreu:', err);
    }
  }
}

async function main() {
  await testValidateDocument();
}

main();