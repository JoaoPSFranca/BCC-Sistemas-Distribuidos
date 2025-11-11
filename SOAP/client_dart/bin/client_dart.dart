import 'package:client_dart/soap_service.dart';
import 'package:client_dart/validation_result.dart'; // IMPORT ADICIONADO

void main(List<String> args) async {
  const endpoint = 'http://localhost:3000/validator';
  final service = SoapService(endpointUrl: endpoint);

  final testCpf = '26323135083'; // CPF Inválido
  final testType = 'CPF';

  print('Iniciando chamada SOAP para $endpoint...');

  try {
    // A variável agora é um objeto ValidationResult!
    final ValidationResult result = await service.validateDocument(
      testCpf,
      testType,
    );

    print('\n--- Resultado da Validação ---');
    print(result); // Isso vai usar nosso método toString()
    print('O documento é válido? ${result.isValid}');
    print('Mensagem do servidor: "${result.message}"');
    print('--------------------------------');

    // Teste com um CNPJ Válido
    final testCnpj = '54550752000155';
    print('\nTestando um CNPJ válido...');
    final cpnjResult = await service.validateDocument(testCnpj, 'CNPJ');
    print(cpnjResult);
  } catch (e) {
    print('\nErro ao executar o cliente:');
    print(e);
  }
}
