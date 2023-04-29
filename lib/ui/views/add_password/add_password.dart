import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passify/core/models/category/category.dart';
import 'package:passify/core/models/password/password.dart';
import 'package:passify/ui/views/category/category.dart';
import 'package:passify/ui/views/home_view/home_view_model.dart';

final passwordProvider = ChangeNotifierProvider((_) => HomeViewModel());

class AddNewPassword extends ConsumerStatefulWidget {
  const AddNewPassword({super.key});

  @override
  ConsumerState<AddNewPassword> createState() => _AddNewPasswordState();
}

class _AddNewPasswordState extends ConsumerState<AddNewPassword> {
  final nameController = TextEditingController();
  final pinController = TextEditingController();
  final emailController = TextEditingController();
  late FocusNode nameFocuse = FocusNode();
  late FocusNode emailFocuse = FocusNode();
  late FocusNode pinFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  void requestNameFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(nameFocuse);
    });
  }

  void requestEmailFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(emailFocuse);
    });
  }

  void requestPinFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(pinFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    final models = ref.watch(passwordProvider);

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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CategoryView()));
            },
            icon: const Icon(
              Icons.add,
              color: Color.fromRGBO(26, 29, 30, 1),
            ),
          ),
        ],
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
                  const Text("Categories"),
                  SizedBox(width: 10.w),
                  models.categories.isEmpty
                      ? IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CategoryView()));
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Color.fromRGBO(26, 29, 30, 1),
                          ),
                        )
                      : DropdownButton<Categories>(
                          value: models.dropdownValue,
                          icon: const Icon(Icons.arrow_drop_down),
                          items: models.categories
                              .map<DropdownMenuItem<Categories>>(
                                  (Categories e) {
                            return DropdownMenuItem<Categories>(
                                value: e, child: Text(e.name));
                          }).toList(),
                          onChanged: models.changeCategory),
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
                onTap: requestNameFocus,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: const Color.fromRGBO(26, 29, 30, 1),
                ),
                controller: nameController,
                focusNode: nameFocuse,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(76, 166, 168, 1), width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9.r)),
                    fillColor: Colors.white,
                    labelText: "Account Name",
                    labelStyle: GoogleFonts.lato(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: nameFocuse.hasFocus
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
                onTap: requestEmailFocus,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: const Color.fromRGBO(26, 29, 30, 1),
                ),
                focusNode: emailFocuse,
                controller: emailController,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(76, 166, 168, 1), width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9.r)),
                    hintText: "we@gmail.com",
                    fillColor: Colors.white,
                    labelText: "Account Email",
                    labelStyle: GoogleFonts.lato(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: emailFocuse.hasFocus
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
                onTap: requestPinFocus,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: const Color.fromRGBO(26, 29, 30, 1),
                ),
                controller: pinController,
                focusNode: pinFocus,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(76, 166, 168, 1), width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9.r)),
                    hintText: "*********",
                    fillColor: Colors.white,
                    labelText: "Account Password",
                    labelStyle: GoogleFonts.lato(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: pinFocus.hasFocus
                            ? const Color.fromRGBO(76, 166, 168, 1)
                            : Colors.black)),
              ),
              SizedBox(
                height: 50.h,
              ),
              InkWell(
                onTap: () {
                  final model = ref.read(passwordProvider);
                  if(_formKey.currentState!.validate()){
                      model.addPassword(Password()
                    ..pin = pinController.text
                    ..name = nameController.text
                    ..email = emailController.text
                    ..createdTime = DateTime.now()
                    ..obscure = true
                    ..category.value = models.dropdownValue);

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
                      "Save",
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
  }
}
