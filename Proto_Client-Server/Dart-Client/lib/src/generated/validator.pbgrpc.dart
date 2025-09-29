// This is a generated file - do not edit.
//
// Generated from validator.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'validator.pb.dart' as $0;

export 'validator.pb.dart';

@$pb.GrpcServiceName('Validator')
class ValidatorClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  ValidatorClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.ValidationResponse> validateDocument(
    $0.ValidationRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$validateDocument, request, options: options);
  }

  // method descriptors

  static final _$validateDocument =
      $grpc.ClientMethod<$0.ValidationRequest, $0.ValidationResponse>(
          '/Validator/ValidateDocument',
          ($0.ValidationRequest value) => value.writeToBuffer(),
          $0.ValidationResponse.fromBuffer);
}

@$pb.GrpcServiceName('Validator')
abstract class ValidatorServiceBase extends $grpc.Service {
  $core.String get $name => 'Validator';

  ValidatorServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.ValidationRequest, $0.ValidationResponse>(
        'ValidateDocument',
        validateDocument_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ValidationRequest.fromBuffer(value),
        ($0.ValidationResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.ValidationResponse> validateDocument_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ValidationRequest> $request) async {
    return validateDocument($call, await $request);
  }

  $async.Future<$0.ValidationResponse> validateDocument(
      $grpc.ServiceCall call, $0.ValidationRequest request);
}
