// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String NameValueKey = 'name';
const String PinValueKey = 'pin';
const String EmailValueKey = 'email';

final Map<String, TextEditingController> _AddNewPasswordTextEditingControllers =
    {};

final Map<String, FocusNode> _AddNewPasswordFocusNodes = {};

final Map<String, String? Function(String?)?> _AddNewPasswordTextValidations = {
  NameValueKey: null,
  PinValueKey: null,
  EmailValueKey: null,
};

mixin $AddNewPassword {
  TextEditingController get nameController =>
      _getFormTextEditingController(NameValueKey);
  TextEditingController get pinController =>
      _getFormTextEditingController(PinValueKey);
  TextEditingController get emailController =>
      _getFormTextEditingController(EmailValueKey);
  FocusNode get nameFocusNode => _getFormFocusNode(NameValueKey);
  FocusNode get pinFocusNode => _getFormFocusNode(PinValueKey);
  FocusNode get emailFocusNode => _getFormFocusNode(EmailValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_AddNewPasswordTextEditingControllers.containsKey(key)) {
      return _AddNewPasswordTextEditingControllers[key]!;
    }

    _AddNewPasswordTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _AddNewPasswordTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_AddNewPasswordFocusNodes.containsKey(key)) {
      return _AddNewPasswordFocusNodes[key]!;
    }
    _AddNewPasswordFocusNodes[key] = FocusNode();
    return _AddNewPasswordFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormViewModel model) {
    nameController.addListener(() => _updateFormData(model));
    pinController.addListener(() => _updateFormData(model));
    emailController.addListener(() => _updateFormData(model));
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    nameController.addListener(() => _updateFormData(model));
    pinController.addListener(() => _updateFormData(model));
    emailController.addListener(() => _updateFormData(model));
  }

  static const bool _autoTextFieldValidation = true;
  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          NameValueKey: nameController.text,
          PinValueKey: pinController.text,
          EmailValueKey: emailController.text,
        }),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _AddNewPasswordTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _AddNewPasswordFocusNodes.values) {
      focusNode.dispose();
    }

    _AddNewPasswordTextEditingControllers.clear();
    _AddNewPasswordFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get nameValue => this.formValueMap[NameValueKey] as String?;
  String? get pinValue => this.formValueMap[PinValueKey] as String?;
  String? get emailValue => this.formValueMap[EmailValueKey] as String?;

  set nameValue(String? value) {
    this.setData(
      this.formValueMap
        ..addAll({
          NameValueKey: value,
        }),
    );

    if (_AddNewPasswordTextEditingControllers.containsKey(NameValueKey)) {
      _AddNewPasswordTextEditingControllers[NameValueKey]?.text = value ?? '';
    }
  }

  set pinValue(String? value) {
    this.setData(
      this.formValueMap
        ..addAll({
          PinValueKey: value,
        }),
    );

    if (_AddNewPasswordTextEditingControllers.containsKey(PinValueKey)) {
      _AddNewPasswordTextEditingControllers[PinValueKey]?.text = value ?? '';
    }
  }

  set emailValue(String? value) {
    this.setData(
      this.formValueMap
        ..addAll({
          EmailValueKey: value,
        }),
    );

    if (_AddNewPasswordTextEditingControllers.containsKey(EmailValueKey)) {
      _AddNewPasswordTextEditingControllers[EmailValueKey]?.text = value ?? '';
    }
  }

  bool get hasName =>
      this.formValueMap.containsKey(NameValueKey) &&
      (nameValue?.isNotEmpty ?? false);
  bool get hasPin =>
      this.formValueMap.containsKey(PinValueKey) &&
      (pinValue?.isNotEmpty ?? false);
  bool get hasEmail =>
      this.formValueMap.containsKey(EmailValueKey) &&
      (emailValue?.isNotEmpty ?? false);

  bool get hasNameValidationMessage =>
      this.fieldsValidationMessages[NameValueKey]?.isNotEmpty ?? false;
  bool get hasPinValidationMessage =>
      this.fieldsValidationMessages[PinValueKey]?.isNotEmpty ?? false;
  bool get hasEmailValidationMessage =>
      this.fieldsValidationMessages[EmailValueKey]?.isNotEmpty ?? false;

  String? get nameValidationMessage =>
      this.fieldsValidationMessages[NameValueKey];
  String? get pinValidationMessage =>
      this.fieldsValidationMessages[PinValueKey];
  String? get emailValidationMessage =>
      this.fieldsValidationMessages[EmailValueKey];
}

extension Methods on FormViewModel {
  setNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[NameValueKey] = validationMessage;
  setPinValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PinValueKey] = validationMessage;
  setEmailValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EmailValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    nameValue = '';
    pinValue = '';
    emailValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      NameValueKey: getValidationMessage(NameValueKey),
      PinValueKey: getValidationMessage(PinValueKey),
      EmailValueKey: getValidationMessage(EmailValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _AddNewPasswordTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _AddNewPasswordTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormViewModel model) => model.setValidationMessages({
      NameValueKey: getValidationMessage(NameValueKey),
      PinValueKey: getValidationMessage(PinValueKey),
      EmailValueKey: getValidationMessage(EmailValueKey),
    });
