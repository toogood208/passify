import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passify/core/models/password/password.dart';
import 'package:passify/ui/views/home_view/home_view_model.dart';

final passwordProvider = ChangeNotifierProvider((_) => HomeViewModel());

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(passwordProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Passify"),
      ),
      body: model.passwords.isEmpty
          ? const Center(
              child: Text("No Passwords"),
            )
          : SizedBox(
              height: 100,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: model.count,
                  itemBuilder: (context, index) {
                    final password = model.passwords[index];
                    return GestureDetector(
                      onTap: () async {
                        final updatedPassword =
                            await createOrUpdatePasswordDialog(
                          context: context,
                          existingPassword: password,
                        );
                        if (updatedPassword != null) {
                          model.update(updatedPassword);
                        }
                      },
                      child: Text(password.name),
                    );
                  }),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final password = await createOrUpdatePasswordDialog(context: context);
          if (password != null) {
            final model = ref.read(passwordProvider);
            model.addPassword(password);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

final nameController = TextEditingController();
final pinController = TextEditingController();
final emailController = TextEditingController();

Future<Password?> createOrUpdatePasswordDialog({
  required BuildContext context,
  Password? existingPassword,
}) async {
  String? name = existingPassword?.name;
  String? pin = existingPassword?.pin;
  String? email = existingPassword?.email;

  nameController.text = name ?? "";
  pinController.text = pin ?? "";
  emailController.text = email ?? "";

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
              existingPassword == null ? "Create Password" : "Update Password"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                onChanged: (value) => name = value,
                decoration: const InputDecoration(
                  labelText: "Enter name of account",
                  hintText: "Spotify",
                ),
              ),
              TextField(
                controller: emailController,
                onChanged: (value) => email = value,
                decoration: const InputDecoration(
                  labelText: "Enter email of account",
                  hintText: "we@gmail.com",
                ),
              ),
              TextField(
                controller: pinController,
                onChanged: (value) => pin = value,
                //: obscure,
                decoration: const InputDecoration(
                  labelText: "Enter password",
                  hintText: "***********",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                
                
              },
              // onPressed: () {
              //   if (name != null && pin != null && email != null) {
              //     if (existingPassword != null) {
              //       final newPerson = existingPassword.update(
              //           name: name, pin: pin, email: email, obscure: obscure);
              //       Navigator.of(context).pop(newPerson);
              //     } else {
              //   //     Navigator.of(context).pop(Password(
              //   //       id: 0,
              //   //         pin: pin!,
              //   //         email: email!,
              //   //         name: name!,
              //   //         obscure: obscure));
              //   //   }
              //   // } else {
              //   //   Navigator.of(context).pop();
              //   // }
              // },
              child: const Text("Save"),
            ),
          ],
        );
      });
}
