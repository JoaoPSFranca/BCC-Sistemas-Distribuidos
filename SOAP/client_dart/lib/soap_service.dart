import 'package:client_dart/validation_result.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class SoapService {
  final String _endpointUrl;
  final http.Client _client;

  SoapService({required String endpointUrl, http.Client? client})
    : _endpointUrl = endpointUrl,
      _client = client ?? http.Client();

  String _buildValidateDocumentEnvelope(
    String documentNumber,
    String documentType,
  ) {
    final builder = xml.XmlBuilder();
    builder.processing('xml', 'version="1.0" encoding="UTF-8"');

    builder.element(
      'soap:Envelope',
      attributes: {'xmlns:soap': 'http://schemas.xmlsoap.org/soap/envelope/'},
      nest: () {
        builder.element(
          'soap:Body',
          nest: () {
            builder.element(
              'm:validateDocument',
              attributes: {'xmlns:m': 'http://example.com/validator'},
              nest: () {
                builder.element('m:documentNumber', nest: documentNumber);
                builder.element('m:documentType', nest: documentType);
              },
            );
          },
        );
      },
    );

    final document = builder.buildDocument();
    return document.toXmlString(pretty: true);
  }

  Future<http.Response> _sendRequest(String soapAction, String envelope) async {
    final uri = Uri.parse(_endpointUrl);

    final response = await _client.post(
      uri,
      headers: {
        'Content-Type': 'text/xml; charset=utf-8',
        'SOAPAction': soapAction,
      },
      body: envelope,
    );

    return response;
  }

  ValidationResult _parseResponse(String responseBody) {
    try {
      final document = xml.XmlDocument.parse(responseBody);
      const namespaceUri = 'http://example.com/validator';

      final isValidStr = document
          .findAllElements('isValid', namespace: namespaceUri)
          .first
          .innerText;

      final message = document
          .findAllElements('message', namespace: namespaceUri)
          .first
          .innerText;

      return ValidationResult(
        isValid: isValidStr.toLowerCase() == 'true',
        message: message,
      );
    } catch (e) {
      throw Exception('Falha ao parsear a resposta SOAP: $e');
    }
  }

  Future<ValidationResult> validateDocument(
    String documentNumber,
    String documentType,
  ) async {
    const soapAction = 'validateDocument';

    final envelope = _buildValidateDocumentEnvelope(
      documentNumber,
      documentType,
    );

    try {
      final response = await _sendRequest(soapAction, envelope);

      if (response.statusCode == 200) {
        return _parseResponse(response.body);
      } else {
        print('--- FALHA SOAP (Recebida) ---');
        print(response.body);
        print('-----------------------------');
        throw Exception('Falha na chamada SOAP: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao conectar ao servidor: $e');
    }
  }
}
