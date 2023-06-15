import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passify/core/models/password/password.dart';

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({
    super.key,
    required this.password,
    required this.onCopyPin,
    required this.onShowPassword,
  });

  final Password password;
  final VoidCallback onCopyPin;
  final VoidCallback onShowPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327.w,
      height: 87.h,
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 10.h,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                password.name,
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.sp,
                  color: const Color.fromRGBO(55, 58, 77, 1),
                ),
              ),
              GestureDetector(
                  onTap: onCopyPin,
                  child: Icon(
                    Icons.copy,
                    size: 19.r,
                  )),
            ],
          ),
          Text(
            password.email,
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: const Color.fromRGBO(116, 116, 116, 1),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                !password.obscure ? password.pin : "****************",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: const Color.fromRGBO(55, 58, 77, 1),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: onShowPassword,
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
    );
  }
}