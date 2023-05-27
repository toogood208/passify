import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passify/ui/views/category/category_view_model.dart';
import 'package:stacked/stacked.dart';

class CategoryView extends StatelessWidget {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoryViewModel>.reactive(
        onDispose: (model) {
          _controller.dispose();
          _focusNode.dispose();
        },
        onViewModelReady: (model) {
          _focusNode.requestFocus();
        },
        viewModelBuilder: () => CategoryViewModel(),
        builder: (context, model, child) {
          return WillPopScope(
            onWillPop: () async {
              model.onWillPop(_controller.text);
              return true;
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                iconTheme: const IconThemeData(
                  color: Colors.black, //change your color here
                ),
                title: TextField(
                  cursorColor: Colors.black,
                  controller: _controller,
                  focusNode: _focusNode,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: "Enter a category"),
                ),

              ),
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 24.h,),
                    Text("Categories", style:
                      GoogleFonts.lato(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.sp,
                        color:const Color(0xFF373A4D)
                      ),),
                    SizedBox(height: 24.h,),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: model.categories.length,
                          itemBuilder: (context,index){
                          final category = model.categories[index];
                          return Container(
                            padding: EdgeInsets.all(12.r),
                            margin: EdgeInsets.only(bottom: 16.h),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(category.name,style:
                                GoogleFonts.lato(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                    color:const Color(0xFF373A4D)
                                ),),
                                IconButton(onPressed: (){
                                  model.deleteCategory(category.id);
                                },
                                    icon: Icon( CupertinoIcons.delete,
                                    color: Colors.red,
                                    size: 20.r,),)
                              ],
                            ),
                          );

                          }),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
