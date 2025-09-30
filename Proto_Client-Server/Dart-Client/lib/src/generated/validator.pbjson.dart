// This is a generated file - do not edit.
//
// Generated from validator.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use documentTypeDescriptor instead')
const DocumentType$json = {
  '1': 'DocumentType',
  '2': [
    {'1': 'UNKNOWN', '2': 0},
    {'1': 'CPF', '2': 1},
    {'1': 'CNPJ', '2': 2},
  ],
};

/// Descriptor for `DocumentType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List documentTypeDescriptor = $convert.base64Decode(
    'CgxEb2N1bWVudFR5cGUSCwoHVU5LTk9XThAAEgcKA0NQRhABEggKBENOUEoQAg==');

@$core.Deprecated('Use validationRequestDescriptor instead')
const ValidationRequest$json = {
  '1': 'ValidationRequest',
  '2': [
    {'1': 'document', '3': 1, '4': 1, '5': 9, '10': 'document'},
  ],
};

/// Descriptor for `ValidationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validationRequestDescriptor = $convert.base64Decode(
    'ChFWYWxpZGF0aW9uUmVxdWVzdBIaCghkb2N1bWVudBgBIAEoCVIIZG9jdW1lbnQ=');

@$core.Deprecated('Use validationResponseDescriptor instead')
const ValidationResponse$json = {
  '1': 'ValidationResponse',
  '2': [
    {'1': 'is_valid', '3': 1, '4': 1, '5': 8, '10': 'isValid'},
    {
      '1': 'document_type',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.validator.DocumentType',
      '10': 'documentType'
    },
  ],
};

/// Descriptor for `ValidationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validationResponseDescriptor = $convert.base64Decode(
    'ChJWYWxpZGF0aW9uUmVzcG9uc2USGQoIaXNfdmFsaWQYASABKAhSB2lzVmFsaWQSPAoNZG9jdW'
    '1lbnRfdHlwZRgCIAEoDjIXLnZhbGlkYXRvci5Eb2N1bWVudFR5cGVSDGRvY3VtZW50VHlwZQ==');
