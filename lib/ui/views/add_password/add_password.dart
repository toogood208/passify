import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passify/core/models/category/category.dart';
import 'package:passify/core/models/password/password.dart';
import 'package:passify/ui/views/add_password/add_password.form.dart';
import 'package:passify/ui/views/add_password/add_password_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

@FormView(fields: [
  FormTextField(name: 'name'),
  FormTextField(name: 'pin'),
  FormTextField(name: 'email'),
])
class AddNewPassword extends StatelessWidget with $AddNewPassword {
  AddNewPassword({super.key, this.password});
  final Password? password;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddPasswordViewModel>.reactive(
        viewModelBuilder: () => AddPasswordViewModel(password),
        onDispose:(model)=> disposeForm(),
        onViewModelReady: (model) {
          syncFormWithViewModel(model);
          if (password != null) {
            nameController.text = password!.name;
            emailController.text = password!.email;
            pinController.text = password!.pin;
            if (model.dropdownValue != null) {
              model.dropdownValue!.name = password!.category;
            }
          }
        },
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: const Color.fromRGBO(251, 251, 251, 1),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: const Color.fromRGBO(251, 251, 251, 1),
              centerTitle: true,
              title: Text(
                "Add Account",
                style: GoogleFonts.poppins(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromRGBO(26, 29, 30, 1),
                ),
              ),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AddPasswordCategoryWidget(),
                  SizedBox(
                    width: 50.h,
                  ),
                  CustomTextField(
                    controller: nameController,
                    requestFocus: () => model.requestNameFocus(context),
                    focusNode: model.nameFocus,
                    labelText: "name",
                    hintText: "account name",
                    hasValidationMessage: model.hasNameValidationMessage,
                    validationMessage: model.nameValidationMessage,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomTextField(
                    controller: emailController,
                    requestFocus: () => model.requestEmailFocus(context),
                    focusNode: model.emailFocus,
                    labelText: "email",
                    hintText: "account email",
                    hasValidationMessage: model.hasEmailValidationMessage,
                    validationMessage: model.emailValidationMessage,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomTextField(
                    controller: pinController,
                    requestFocus: () => model.requestPinFocus(context),
                    focusNode: model.pinFocus,
                    labelText: "password",
                    hintText: "password",
                    hasValidationMessage: model.hasPinValidationMessage,
                    validationMessage: model.pinValidationMessage,
                  ),
                  AddPassswordCheckBoxWidget(pinController: pinController),
                  SizedBox(
                    height: 50.h,
                  ),
                  AppButton(
                    password: password,
                    onTap: () => model.addNewPassword(),
                    disableButton: model.disableButton,
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.password,
    required this.onTap,
    this.disableButton = false,
  });

  final Password? password;
  final VoidCallback onTap;
  final bool disableButton;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disableButton ? () {} : onTap,
      child: Ink(
        width: 335.w,
        height: 54.h,
        decoration: BoxDecoration(
            color: disableButton
                ? Colors.grey
                : const Color.fromRGBO(76, 166, 168, 1),
            borderRadius: BorderRadius.circular(12.r)),
        child: Center(
          child: Text(
            password != null ? "Update" : "Save",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class AddPassswordCheckBoxWidget extends ViewModelWidget<AddPasswordViewModel> {
  const AddPassswordCheckBoxWidget({
    super.key,
    required this.pinController,
  });

  final TextEditingController pinController;

  @override
  Widget build(BuildContext context, viewModel) {
    return CheckboxListTile(
        activeColor: const Color.fromRGBO(76, 166, 168, 1),
        title: const Text("Generate Password"),
        value: viewModel.checkBoxValue,
        onChanged: (bool? val) {
          viewModel.generatePassword();
          if (viewModel.checkBoxValue == true) {
            pinController.text = viewModel.generatedPassword;
          }
        });
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.requestFocus,
    required this.focusNode,
    required this.labelText,
    required this.hintText,
    this.validationMessage,
    this.hasValidationMessage = false,
  });

  final TextEditingController controller;
  final VoidCallback requestFocus;
  final FocusNode focusNode;
  final String labelText;
  final String hintText;
  final String? validationMessage;
  final bool hasValidationMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          onTap: requestFocus, //() => model.requestEmailFocus(context),
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: const Color.fromRGBO(26, 29, 30, 1),
          ),
          focusNode: focusNode, // model.emailFocus,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromRGBO(76, 166, 168, 1), width: 2.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              filled: true,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(9.r)),
              hintText: hintText,
              fillColor: Colors.white,
              labelText: labelText,
              labelStyle: GoogleFonts.lato(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: focusNode.hasFocus
                      ? const Color.fromRGBO(76, 166, 168, 1)
                      : Colors.black)),
        ),
        Text(
          validationMessage ?? "",
          style: const TextStyle(
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}

class AddPasswordCategoryWidget extends ViewModelWidget<AddPasswordViewModel> {
  const AddPasswordCategoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, viewModel) {
    return Row(
      children: [
        const Text("Category"),
        SizedBox(width: 10.w),
        viewModel.categories.isEmpty
            ? IconButton(
                onPressed: viewModel.navigateToCategoryView,
                icon: const Icon(
                  Icons.add,
                  color: Color.fromRGBO(26, 29, 30, 1),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButton<Category>(
                      value: viewModel.dropdownValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      items: viewModel.categories
                          .map<DropdownMenuItem<Category>>((Category e) {
                        return DropdownMenuItem<Category>(
                            value: e, child: Text(e.name!));
                      }).toList(),
                      onChanged: viewModel.changeCategory),
                  IconButton(
                    onPressed: viewModel.navigateToCategoryView,
                    icon: const Icon(
                      Icons.add,
                      color: Color.fromRGBO(26, 29, 30, 1),
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
