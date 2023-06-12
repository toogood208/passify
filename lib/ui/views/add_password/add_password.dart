import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passify/core/models/category/category.dart';
import 'package:passify/core/models/password/password.dart';
import 'package:passify/ui/views/add_password/add_password_view_model.dart';
import 'package:stacked/stacked.dart';

class AddNewPassword extends StatelessWidget {
  AddNewPassword({super.key, this.password});
  final Password? password;

  final nameController = TextEditingController();
  final pinController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddPasswordViewModel>.reactive(
        viewModelBuilder: () => AddPasswordViewModel(),
        onViewModelReady: (model) {
          if (password != null) {
            nameController.text = password!.name;
            emailController.text = password!.email;
            pinController.text = password!.pin;
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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text("Category"),
                        SizedBox(width: 10.w),
                        model.categories.isEmpty
                            ? IconButton(
                                onPressed:model.navigateToCategoryView,
                                icon: const Icon(
                                  Icons.add,
                                  color: Color.fromRGBO(26, 29, 30, 1),
                                ),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  DropdownButton<Category>(
                                      value: model.dropdownValue,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      items: model.categories
                                          .map<DropdownMenuItem<Category>>(
                                              (Category e) {
                                        return DropdownMenuItem<Category>(
                                            value: e, child: Text(e.name!));
                                      }).toList(),
                                      onChanged: model.changeCategory),
                                  IconButton(
                                    onPressed: model.navigateToCategoryView,
                                    icon: const Icon(
                                      Icons.add,
                                      color: Color.fromRGBO(26, 29, 30, 1),
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                    SizedBox(
                      width: 50.w,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field cannot be empty';
                        }
                        return null;
                      },
                      onTap: () => model.requestNameFocus(context),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(26, 29, 30, 1),
                      ),
                      controller: nameController,
                      focusNode: model.nameFocus,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(76, 166, 168, 1),
                                width: 2.0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 10.w),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.r)),
                          fillColor: Colors.white,
                          labelText: "Account Name",
                          labelStyle: GoogleFonts.lato(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: model.nameFocus.hasFocus
                                  ? const Color.fromRGBO(76, 166, 168, 1)
                                  : Colors.black)),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field cannot be empty';
                        }
                        return null;
                      },
                      onTap: () => model.requestEmailFocus(context),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(26, 29, 30, 1),
                      ),
                      focusNode: model.emailFocus,
                      controller: emailController,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(76, 166, 168, 1),
                                width: 2.0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 10.w),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.r)),
                          hintText: "we@gmail.com",
                          fillColor: Colors.white,
                          labelText: "Account Email",
                          labelStyle: GoogleFonts.lato(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: model.emailFocus.hasFocus
                                  ? const Color.fromRGBO(76, 166, 168, 1)
                                  : Colors.black)),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    TextFormField(
                      controller: pinController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field cannot be empty';
                        }
                        return null;
                      },
                      onTap: () => model.requestPinFocus(context),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(26, 29, 30, 1),
                      ),
                      focusNode: model.pinFocus,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(76, 166, 168, 1),
                                width: 2.0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 10.w),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.r)),
                          hintText: "*********",
                          fillColor: Colors.white,
                          labelText: "Account Password",
                          labelStyle: GoogleFonts.lato(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: model.pinFocus.hasFocus
                                  ? const Color.fromRGBO(76, 166, 168, 1)
                                  : Colors.black)),
                    ),
                    CheckboxListTile(
                        activeColor: const Color.fromRGBO(76, 166, 168, 1),
                        title: const Text("Generate Password"),
                        value: model.checkBoxValue,
                        onChanged: (bool? val) {
                          model.generatePassword();
                          if (model.checkBoxValue == true) {
                            pinController.text = model.generatedPassword;
                          }
                        }),
                    SizedBox(
                      height: 50.h,
                    ),
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          model.generatedPassword;
                          password != null
                              ? model.update(
                                  id: password!.id!,
                                  name: password!.name,
                                  email: password!.email,
                                  pin: password!.pin,
                                  obscure: password!.obscure,
                                  category: password?.category ??
                                      model.dropdownValue?.name)
                              : model.addPassword(Password(
                                id: model.uuid.v4(),
                                category: model.dropdownValue!.name!, 
                                email:emailController.text, 
                                 name: pinController.text, 
                                 obscure: true, 
                                 pin: pinController.text)
                              );
                        }
                      },
                      child: Ink(
                        width: 335.w,
                        height: 54.h,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(76, 166, 168, 1),
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
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
