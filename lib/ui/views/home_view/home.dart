import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passify/core/models/password/password.dart';
import 'package:passify/ui/views/home_view/home_view_model.dart';
import 'package:stacked/stacked.dart';

final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

class HomePage extends StatelessWidget {
  const HomePage({super.key});




  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: const Color.fromRGBO(251, 251, 251, 1),
              centerTitle: true,
              title: Text(
                "Pass-Save",
                style: GoogleFonts.lato(
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
                              onChanged: (name)=> model.searchPassword(controller.text),
                              controller: controller,
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
                                      color: const Color.fromRGBO(
                                          199, 199, 199, 1))),
                            ),
                          ),
                        ),
                        model.categories.isNotEmpty
                            ? Container(
                                margin: EdgeInsets.only(top: 24.h),
                                height: 48.h,
                                child: ListView.builder(
                                    itemCount: model.categories.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final category =
                                          model.categories[index].name;
                                      return Container(
                                        margin: EdgeInsets.only(
                                          right: 26.w,
                                        ),
                                        width: 98.w,
                                        height: 48.h,
                                        decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                76, 166, 168, 1),
                                            borderRadius:
                                                BorderRadius.circular(8.r)),
                                        child: Center(
                                          child: Text(
                                            category!,
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            : const SizedBox.shrink(),
                        SizedBox(
                          height: 24.h,
                        ),
                        Text(
                          "Passwords",
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.w500,
                              fontSize: 24.sp,
                              color: const Color.fromRGBO(55, 58, 77, 1)),
                        ),
                        AnimatedList(
                          key: _listKey,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            initialItemCount: model.passwords.length,
                            itemBuilder: (context, index, animation) {
                              final password = model.passwords[index];
                              return SlideTransition(
                                position: animation.drive(
                                  Tween<Offset>(
                                    begin: const Offset(1,0),
                                    end: Offset.zero,
                                  )
                                ),
                                child: Slidable(
                                  endActionPane: ActionPane(
                                    motion: const StretchMotion(),
                                    children: [
                                      SlidableAction(
                                          onPressed: (_)=>
                                              removePasswordFromList(
                                                  password, index: index,
                                                  model: model),
                                      icon: CupertinoIcons.delete,
                                      backgroundColor: const Color.fromRGBO(76, 166, 168, 1),
                                      label: "Delete",),
                                    ],
                                  ),

                                  child: SizeTransition(
                                    sizeFactor: animation,
                                    child: ListItemWidget(
                                      password: password,
                                      onUpdate: () => model.navigateToAddPassword(
                                          password: password),
                                      onCopyPin: () => model.copyData(password.pin),
                                      onShowPassword: () =>
                                          model.showPassword(password),

                                    ),
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color.fromRGBO(76, 166, 168, 1),
              onPressed: () {
                model.navigateToAddPassword().then((bool passwordAdded) {
                  if (passwordAdded) {
                    addPasswordToList();
                  }
                });
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          );
        });
  }
  void removePasswordFromList(
      Password password, {
        required int index,
        required HomeViewModel model,
      }) {
    _listKey.currentState?.removeItem(
      index,
          (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: ListItemWidget(password: password,
          onUpdate: (){},
          onShowPassword: (){},
          onCopyPin: (){},),
      ),
      duration: const Duration(milliseconds: 500),
    );
    model.deletePassword(password);
  }
  void addPasswordToList() => _listKey.currentState?.insertItem(0);
}





class ListItemWidget extends StatelessWidget {
  const ListItemWidget({
    super.key,
    required this.password,
    required this.onUpdate,
    required this.onCopyPin,
    required this.onShowPassword,
  });

  final Password password;
  final VoidCallback onUpdate;
  final VoidCallback onCopyPin;
  final VoidCallback onShowPassword;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onUpdate,
      child: Container(
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
      ),
    );
  }
}
