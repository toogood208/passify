import 'package:flutter/material.dart';
import 'package:passify/ui/views/home_view/home_view_model.dart';
import 'package:stacked/stacked.dart';

class CategoryView extends StatelessWidget {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        onDispose: (model) {
          _controller.dispose();
          _focusNode.dispose();
        },
        onViewModelReady: (model) {
          _focusNode.requestFocus();
        },
        viewModelBuilder: () => HomeViewModel(),
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
            ),
          );
        });
  }
}
