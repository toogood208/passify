import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import '../home_view_model.dart';

class HomeCategoryWidget extends ViewModelWidget<HomeViewModel> {
  const HomeCategoryWidget({
    Key? key,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context, viewModel) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 48,
          child: ListView.builder(
          shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: viewModel.categories.length,
              itemBuilder: (context, index) {
                final choice = viewModel.categories[index];
                return GestureDetector(
                  onTap: () => viewModel.selectChips(index),
                  child: Container(
                    width: 98.w,
                    height: 48.h,
                    margin: EdgeInsets.only(right: 16.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: const Color.fromRGBO(76, 166, 168, 1),
                    ),
                    child: Center(
                      child: Text(
                        choice.name!,
                        style: GoogleFonts.poppins(
                            fontSize: 14.sp, color: Colors.white),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}