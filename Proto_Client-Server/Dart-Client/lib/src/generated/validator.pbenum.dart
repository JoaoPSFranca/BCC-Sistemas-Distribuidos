// This is a generated file - do not edit.
//
// Generated from validator.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Enum para os tipos de documento
class DocumentType extends $pb.ProtobufEnum {
  static const DocumentType UNKNOWN =
      DocumentType._(0, _omitEnumNames ? '' : 'UNKNOWN');
  static const DocumentType CPF =
      DocumentType._(1, _omitEnumNames ? '' : 'CPF');
  static const DocumentType CNPJ =
      DocumentType._(2, _omitEnumNames ? '' : 'CNPJ');

  static const $core.List<DocumentType> values = <DocumentType>[
    UNKNOWN,
    CPF,
    CNPJ,
  ];

  static final $core.List<DocumentType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static DocumentType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const DocumentType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
