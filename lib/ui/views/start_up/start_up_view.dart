import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passify/ui/views/start_up/start_up_view_model.dart';
import 'package:stacked/stacked.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUPViewModel>.reactive(
        viewModelBuilder: () => StartUPViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 26.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 136.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Pass",
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500,
                            fontSize: 46.sp,
                            color: const Color(0xFF5AC97A)),
                      ),
                      Text(
                        "'ify",
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500,
                            fontSize: 46.sp,
                            color: const Color(0xFF000000)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 36.h,
                  ),
                  Image.asset(
                    "assets/images/onboarding.png",
                    width: 304.w,
                    height: 304.h,
                  ),
                  SizedBox(
                    height: 17.h,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Manage Your",
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.w500,
                                fontSize: 24.sp,
                                color: const Color(0xFF5AC97A)),
                          ),
                          Text(
                            " Passwords",
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.w500,
                                fontSize: 24.sp,
                                color: const Color(0xFF000000)),
                          ),
                        ],
                      ),
                      Text(
                        "All in one Place",
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500,
                            fontSize: 24.sp,
                            color: const Color(0xFF000000)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 36.h,
                  ),
                  Container(
                    width: 36.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                        color: const Color(0xFF5AC97A),
                        borderRadius: BorderRadius.circular(8.r)),
                  ),
                  SizedBox(
                    height: 70.h,
                  ),
                  StartupButton(onTap: model.goToHomePage),
                  SizedBox(
                    height: 40.h,
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class StartupButton extends StatelessWidget {
  const StartupButton({
    super.key,
    required this.onTap,
  });
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        width:double.infinity,
        height: 54.h,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(76, 166, 168, 1),
            borderRadius: BorderRadius.circular(12.r)),
        child: Center(
          child: Text(
            "Next",
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
