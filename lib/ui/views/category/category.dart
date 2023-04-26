import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passify/core/models/category/category.dart';
import 'package:passify/ui/views/home_view/home_view_model.dart';

final passwordProvider = ChangeNotifierProvider((_) => HomeViewModel());

class CategoryView extends ConsumerStatefulWidget {
  const CategoryView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryViewState();
}

class _CategoryViewState extends ConsumerState<CategoryView> {
  late FocusNode _focusNode;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = TextEditingController();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.read(passwordProvider);
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
  }
}
