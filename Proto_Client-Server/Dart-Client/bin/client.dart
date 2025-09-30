import 'dart:io';
import 'package:grpc/grpc.dart';
import '../lib/src/generated/validator.pbgrpc.dart';

Future<void> main(List<String> args) async {
  final channel = ClientChannel(
    'localhost',
    port: 50051,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );
  final client = ValidatorClient(channel);

  print('--- Document Validator ---');
  print("Insert an CPF/CNPJ to validate or 'exit' to close.");

  while (true) {
    stdout.write('\nInsert Document > ');
    final input = stdin.readLineSync();

    if (input == null || input.toLowerCase() == 'exit') {
      break;
    }

    if (input.isEmpty) {
      continue;
    }

    final request = ValidationRequest()..document = input;

    try {
      final response = await client.validateDocument(request);
      print('Server Response:');
      print('   Document type: ${response.documentType}');
      print('   Validate: ${response.isValid}');
    } catch (e) {
      print("❌ Couldn't call server: $e");
    }
  }

  print('Conection closing... ');
  await channel.shutdown();
}
