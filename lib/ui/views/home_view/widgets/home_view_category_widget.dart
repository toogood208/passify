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
      children: <Widget>[
        SizedBox(
          height: 30,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: viewModel.categories.length,
              itemBuilder: (context, index) {
                final choice = viewModel.categories[index];
                return Container(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: ChoiceChip(
                    padding: EdgeInsets.symmetric(vertical: 50.h),
                    label: Text(choice.name!),
                    labelStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                   fontSize: 14.sp,
                   color: Colors.white,
                ),

                    backgroundColor: const Color.fromRGBO(
                     76, 166, 168, 1),
                    selectedColor: const Color.fromRGBO(
                        76, 166, 168, 1),
                    selected: viewModel.selectedTypeIndex == index,
                    onSelected: (value) {
                      viewModel.selectChips(value, index);
                    },
                  ),
                );
              }),
        ),
      ],
    );
  }
}
// class HomeCategoryWidget extends ViewModelWidget<HomeViewModel> {
//   const HomeCategoryWidget({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context, viewModel) {
//     return Container(
//       margin: EdgeInsets.only(top: 24.h),
//       height: 48.h,
//       child: ListView.builder(
//           itemCount: viewModel.categories.length,
//           scrollDirection: Axis.horizontal,
//           itemBuilder: (context, index) {
//             final category =
//                 viewModel.categories[index].name;
//             return Container(
//               margin: EdgeInsets.only(
//                 right: 26.w,
//               ),
//               width: 98.w,
//               height: 48.h,
//               decoration: BoxDecoration(
//                   color: const Color.fromRGBO(
//                       76, 166, 168, 1),
//                   borderRadius:
//                   BorderRadius.circular(8.r)),
//               child: Center(
//                 child: Text(
//                   category!,
//                   style: GoogleFonts.poppins(
//                     fontWeight: FontWeight.w500,
//                     fontSize: 14.sp,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             );
//           }),
//     );
//   }
// }