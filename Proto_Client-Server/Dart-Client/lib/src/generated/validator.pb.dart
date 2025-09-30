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

import 'validator.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'validator.pbenum.dart';

class ValidationRequest extends $pb.GeneratedMessage {
  factory ValidationRequest({
    $core.String? document,
  }) {
    final result = create();
    if (document != null) result.document = document;
    return result;
  }

  ValidationRequest._();

  factory ValidationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ValidationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ValidationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'validator'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'document')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidationRequest clone() => ValidationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidationRequest copyWith(void Function(ValidationRequest) updates) =>
      super.copyWith((message) => updates(message as ValidationRequest))
          as ValidationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidationRequest create() => ValidationRequest._();
  @$core.override
  ValidationRequest createEmptyInstance() => create();
  static $pb.PbList<ValidationRequest> createRepeated() =>
      $pb.PbList<ValidationRequest>();
  @$core.pragma('dart2js:noInline')
  static ValidationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ValidationRequest>(create);
  static ValidationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get document => $_getSZ(0);
  @$pb.TagNumber(1)
  set document($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDocument() => $_has(0);
  @$pb.TagNumber(1)
  void clearDocument() => $_clearField(1);
}

class ValidationResponse extends $pb.GeneratedMessage {
  factory ValidationResponse({
    $core.bool? isValid,
    DocumentType? documentType,
  }) {
    final result = create();
    if (isValid != null) result.isValid = isValid;
    if (documentType != null) result.documentType = documentType;
    return result;
  }

  ValidationResponse._();

  factory ValidationResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ValidationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ValidationResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'validator'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'isValid')
    ..e<DocumentType>(
        2, _omitFieldNames ? '' : 'documentType', $pb.PbFieldType.OE,
        defaultOrMaker: DocumentType.UNKNOWN,
        valueOf: DocumentType.valueOf,
        enumValues: DocumentType.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidationResponse clone() => ValidationResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidationResponse copyWith(void Function(ValidationResponse) updates) =>
      super.copyWith((message) => updates(message as ValidationResponse))
          as ValidationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidationResponse create() => ValidationResponse._();
  @$core.override
  ValidationResponse createEmptyInstance() => create();
  static $pb.PbList<ValidationResponse> createRepeated() =>
      $pb.PbList<ValidationResponse>();
  @$core.pragma('dart2js:noInline')
  static ValidationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ValidationResponse>(create);
  static ValidationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isValid => $_getBF(0);
  @$pb.TagNumber(1)
  set isValid($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIsValid() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsValid() => $_clearField(1);

  @$pb.TagNumber(2)
  DocumentType get documentType => $_getN(1);
  @$pb.TagNumber(2)
  set documentType(DocumentType value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasDocumentType() => $_has(1);
  @$pb.TagNumber(2)
  void clearDocumentType() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
