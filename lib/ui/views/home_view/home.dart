import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passify/core/models/password/password.dart';
import 'package:passify/ui/views/home_view/home_view_model.dart';
import 'package:stacked/stacked.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: ()=> HomeViewModel(),
        builder: (context,model,child){
          return  Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: const Color.fromRGBO(251, 251, 251, 1),
              centerTitle: true,
              title: Text(
                "Pass-Save",
                style: GoogleFonts.poppins(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromRGBO(26, 29, 30, 1),
                ),
              ),
            ),
            body: model.passwords.isEmpty
                ? const Center(
              child: Text("No Passwords"),
            )
                : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    width: 335.w,
                    height: 45.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          spreadRadius: 4.0,
                          blurRadius: 15.0,
                          offset: Offset(0.0, 0.0),
                        )
                      ],
                    ),
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: const Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                            hintText: "Search your passwords",
                            hintStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                                color: const Color.fromRGBO(199, 199, 199, 1))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    "Category",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 24.sp,
                        color: const Color.fromRGBO(55, 58, 77, 1)),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  SizedBox(
                    height: 48.h,
                    child: ListView.builder(
                        itemCount: model.categories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final category = model.categories[index].name;
                          return Container(
                            width: 98.w,
                            height: 48.h,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(90, 201, 112, 1),
                                borderRadius: BorderRadius.circular(8.r)),
                            child: Center(
                              child: Text(
                                category,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    "Passwords",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 24.sp,
                        color: const Color.fromRGBO(55, 58, 77, 1)),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: model.count,
                      itemBuilder: (context, index) {
                        final password = model.passwords[index];
                        return GestureDetector(
                          onTap: ()  {
                            model.navigateToAddPassword(password: password);
                          },
                          child: Container(
                            width: 327.w,
                            height: 87.h,
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                            ),
                            margin: EdgeInsets.symmetric(vertical: 16.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.1),
                                  spreadRadius: 4.0,
                                  blurRadius: 15.0,
                                  offset: Offset(0.0, 0.0),
                                )
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      password.name,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.sp,
                                        color:
                                        const Color.fromRGBO(55, 58, 77, 1),
                                      ),
                                    ),
                                    GestureDetector(
                                        child: Icon(
                                          Icons.copy,
                                          size: 19.r,
                                        )),
                                  ],
                                ),
                                Text(
                                  password.email,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp,
                                    color:
                                    const Color.fromRGBO(116, 116, 116, 1),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      !password.obscure
                                          ? password.pin
                                          : "********************",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        color:
                                        const Color.fromRGBO(55, 58, 77, 1),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                            onTap: () =>
                                                model.showPassword(password),
                                            child: Icon(
                                              Icons.visibility,
                                              size: 19.r,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
               model.navigateToAddPassword();
              },
              child: const Icon(Icons.add),
            ),
          );
        }
    );

  }
}

final nameController = TextEditingController();
final pinController = TextEditingController();
final emailController = TextEditingController();

Future<Password?> createOrUpdatePasswordDialog({
  required BuildContext context,
  Password? existingPassword,
}) async {
  String? name = existingPassword?.name;
  String? pin = existingPassword?.pin;
  String? email = existingPassword?.email;

  nameController.text = name ?? "";
  pinController.text = pin ?? "";
  emailController.text = email ?? "";

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
              existingPassword == null ? "Create Password" : "Update Password"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                onChanged: (value) => name = value,
                decoration: const InputDecoration(
                  labelText: "Enter name of account",
                  hintText: "Spotify",
                ),
              ),
              TextField(
                controller: emailController,
                onChanged: (value) => email = value,
                decoration: const InputDecoration(
                  labelText: "Enter email of account",
                  hintText: "we@gmail.com",
                ),
              ),
              TextField(
                controller: pinController,
                onChanged: (value) => pin = value,
                //: obscure,
                decoration: const InputDecoration(
                  labelText: "Enter password",
                  hintText: "***********",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {},
              // onPressed: () {
              //   if (name != null && pin != null && email != null) {
              //     if (existingPassword != null) {
              //       final newPerson = existingPassword.update(
              //           name: name, pin: pin, email: email, obscure: obscure);
              //       Navigator.of(context).pop(newPerson);
              //     } else {
              //   //     Navigator.of(context).pop(Password(
              //   //       id: 0,
              //   //         pin: pin!,
              //   //         email: email!,
              //   //         name: name!,
              //   //         obscure: obscure));
              //   //   }
              //   // } else {
              //   //   Navigator.of(context).pop();
              //   // }
              // },
              child: const Text("Save"),
            ),
          ],
        );
      });
}
