import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passify/core/models/password/password.dart';
import 'package:passify/ui/views/home_view/home_view_model.dart';
import 'package:passify/ui/views/home_view/widgets/home_view_category_widget.dart';
import 'package:passify/ui/views/password_search/password_search.dart';
import 'package:passify/ui/widgets/list_item_widget.dart';
import 'package:stacked/stacked.dart';

final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                "Pass'ify",
                style: GoogleFonts.lato(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromRGBO(26, 29, 30, 1),
                ),
              ),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Search your passwords",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                                color: const Color.fromRGBO(199, 199, 199, 1))),
                        IconButton(
                            onPressed: () {
                              showSearch(
                                  context: context, delegate: PasswordSearch());
                            },
                            icon: const Icon(Icons.search))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),

                  model.categories.isEmpty
                      ? const SizedBox.shrink()
                      : const HomeCategoryWidget(),
                  model.passwords.isEmpty
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 40.h,
                            ),
                            const Text("No Passwords"),
                          ],
                        ))
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: model.passwords.length,
                          itemBuilder: (context, index) {
                            return Slidable(
                              endActionPane: ActionPane(
                                  motion: const StretchMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (_) => model.deletePassword(
                                          model.passwords[index]),
                                      icon: CupertinoIcons.delete,
                                      backgroundColor:
                                          const Color.fromRGBO(76, 166, 168, 1),
                                      label: "Delete",
                                    ),
                                  ]),
                              child: ListItemWidget(
                                key: ValueKey<Password>(model.passwords[index]),
                                password: model.passwords[index],
                                onCopyPin: () =>
                                    model.copyData(model.passwords[index].pin),
                                onShowPassword: () =>
                                    model.showPassword(model.passwords[index]),
                              ),
                            );
                          }),
                  // AnimatedList(
                  //     key: _listKey,
                  //     shrinkWrap: true,
                  //     scrollDirection: Axis.vertical,
                  //     initialItemCount: model.passwords.length,
                  //     itemBuilder: (context, index, animation) {
                  //       return SlideTransition(
                  //         position: animation.drive(Tween<Offset>(
                  //           begin: const Offset(1, 0),
                  //           end: Offset.zero,
                  //         )),
                  //         child: Slidable(
                  //           endActionPane: ActionPane(
                  //             motion: const StretchMotion(),
                  //             children: [
                  //               SlidableAction(
                  //                 onPressed: (_) =>
                  //                     removePasswordFromList(
                  //                         model.passwords[index],
                  //                         index: index,
                  //                         model: model),
                  //                 icon: CupertinoIcons.delete,
                  //                 backgroundColor: const Color.fromRGBO(
                  //                     76, 166, 168, 1),
                  //                 label: "Delete",
                  //               ),
                  //             ],
                  //           ),
                  //           child: SizeTransition(
                  //             sizeFactor: animation,
                  //             child: ListItemWidget(
                  //               key: ValueKey<Password>(
                  //                   model.passwords[index]),
                  //               password: model.passwords[index],
                  //               onUpdate: () =>
                  //                   model.navigateToAddPassword(
                  //                       password: model.passwords[index]),
                  //               onCopyPin: () => model
                  //                   .copyData(model.passwords[index].pin),
                  //               onShowPassword: () => model
                  //                   .showPassword(model.passwords[index]),
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     }),
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
        child: ListItemWidget(
          password: password,
          onShowPassword: () {},
          onCopyPin: () {},
        ),
      ),
      duration: const Duration(milliseconds: 500),
    );
    model.deletePassword(password);
  }

  void addPasswordToList() => _listKey.currentState
      ?.insertItem(0, duration: const Duration(milliseconds: 500));
}
