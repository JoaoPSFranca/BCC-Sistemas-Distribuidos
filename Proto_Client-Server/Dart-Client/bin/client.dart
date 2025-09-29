import 'package:grpc/grpc.dart';

// Importa os arquivos gerados
import '../lib/src/generated/validator.pbgrpc.dart';

Future<void> main(List<String> args) async {
  final channel = ClientChannel(
    // informações da conexão
    'localhost',
    port: 50051,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );

  final client = ValidatorClient(channel);

  final request = ValidationRequest()..documentNumber = '123.456.789-00';

  try {
    // chama o rpc
    final response = await client.validateDocument(request);

    // responde
    print('✅ Validation successful!');
    print('Is the document valid? ${response.isValid}');
  } catch (e) {
    print('❌ Caught error: $e');
  }

  // fecha a conexão
  await channel.shutdown();
}
