import 'package:flutter/material.dart';
import 'package:passify/ui/views/password_search/password_search_viewmodel.dart';
import 'package:passify/ui/widgets/app_spinner.dart';
import 'package:passify/ui/widgets/list_item_widget.dart';
import 'package:stacked/stacked.dart';

class PasswordSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: Colors.white,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.black),
      primaryTextTheme: theme.textTheme,
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
      ),
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ViewModelBuilder<PasswordSearchViewModel>.reactive(
        viewModelBuilder: () => PasswordSearchViewModel(),
        onViewModelReady: (model) => model.getPasswordList(query),
        builder: (context, model, child) {
          return model.isBusy
              ? const AppSpinner()
              : model.passwordList.isEmpty
                  ? const Center(child: Text("no password"))
                  : const PasswordListNotEmpty();
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ViewModelBuilder<PasswordSearchViewModel>.reactive(
        onViewModelReady: (model) => model.getPasswordList(query),
        viewModelBuilder: () => PasswordSearchViewModel(),
        builder: (context, model, child) {
          final suggestions1 = model.passwordList;
          final suggestions = query.isEmpty
              ? model.passwordList
              : suggestions1
                  .where(
                      (element) => element.name.toLowerCase().contains(query))
                  .toList();

          return suggestions1.isEmpty
              ? const Center(child: Text('No results found'))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    itemCount: suggestions.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 40.0),
                    itemBuilder: (context, index) {
                      final password = suggestions[index];
                      return ListItemWidget(
                        password: password,
                        onUpdate: () => model.goToAddPasswordView(password),
                        onCopyPin: () => model.copyData(password.pin),
                        onShowPassword: () => model.showPassword(password),
                      );
                    },
                  ),
                );
        });
  }
}

class PasswordListNotEmpty extends ViewModelWidget<PasswordSearchViewModel> {
  const PasswordListNotEmpty({super.key});

  @override
  Widget build(BuildContext context, PasswordSearchViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: viewModel.passwordList.length,
        itemBuilder: (context, index) {
          final password = viewModel.passwordList[index];
          return ListItemWidget(
            password: password,
            onUpdate: () => viewModel.goToAddPasswordView(password),
            onCopyPin: () => viewModel.copyData(password.pin),
            onShowPassword: () => viewModel.showPassword(password),
          );
        },
      ),
    );
  }
}
