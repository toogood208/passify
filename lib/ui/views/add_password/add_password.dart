import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passify/core/models/password/password.dart';
import 'package:passify/ui/views/category/category.dart';
import 'package:passify/ui/views/home_view/home_view_model.dart';

final passwordProvider = ChangeNotifierProvider((_) => HomeViewModel());

class AddNewPassword extends ConsumerWidget {
  const AddNewPassword({super.key, this.existingPassword});
  final Password? existingPassword;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final pinController = TextEditingController();
    final emailController = TextEditingController();

    bool? obscure = existingPassword?.obscure ?? true;
    String? name = existingPassword?.name;
    String? pin = existingPassword?.pin;
    String? email = existingPassword?.email;

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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CategoryView()));
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: const Color.fromRGBO(26, 29, 30, 1),
              ),
              controller: nameController,
              onChanged: (value) => name = value,
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.r)),
                hintText: "Spotify",
                fillColor: Colors.white,
                label: const Text("Name"),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            TextFormField(
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: const Color.fromRGBO(26, 29, 30, 1),
              ),
              controller: emailController,
              onChanged: (value) => name = value,
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.r)),
                hintText: "we@gmail.com",
                fillColor: Colors.white,
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            TextFormField(
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: const Color.fromRGBO(26, 29, 30, 1),
              ),
              controller: pinController,
              obscureText: true,
              onChanged: (value) => name = value,
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.r)),
                hintText: "*********",
                fillColor: Colors.white,
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            InkWell(
              onTap: () {
                final model = ref.read(passwordProvider);
                model.addPassword(Password()
                  ..pin = pin!
                  ..name = name!
                  ..email = email!
                  ..createdTime = DateTime.now()
                  ..obscure = obscure);
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
            ElevatedButton(
              onPressed: () {
                final model = ref.read(passwordProvider);
                model.addPassword(Password()
                  ..pin = pin!
                  ..name = name!
                  ..email = email!
                  ..createdTime = DateTime.now()
                  ..obscure = obscure);
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
