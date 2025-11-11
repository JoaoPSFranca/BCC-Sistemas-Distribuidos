import 'package:client_dart/soap_service.dart';
import 'package:client_dart/validation_result.dart'; // IMPORT ADICIONADO

void main(List<String> args) async {
  const endpoint = 'http://localhost:3000/validator';
  final service = SoapService(endpointUrl: endpoint);

  try {
    final testCpf = '26323135083';
    final ValidationResult cpfResult = await service.validateDocument(
      testCpf,
      'CPF',
    );
    print(cpfResult);

    final testCnpj = '54550752000155';
    final ValidationResult cpnjResult = await service.validateDocument(
      testCnpj,
      'CNPJ',
    );
    print(cpnjResult);
  } catch (e) {
    print('\nErro ao executar o cliente:');
    print(e);
  }
}
