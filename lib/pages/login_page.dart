import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final void Function() onTap;

  LoginPage({super.key, required this.onTap});

  final TextEditingController _mailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  void login(BuildContext context) async {
    String mail = _mailController.text.toString();
    String password = _passwordController.text.toString();

    final AuthService authService = AuthService();

    if (mail.isEmpty || password.isEmpty) {
      showErrorDialog(context, "Please Enter your Crententials");
    } else {
      try {
        await authService.signInwithEmailAndPassword(mail, password);
      } catch (e) {
        showErrorDialog(context, e.toString());
      }
    }
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(message),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.chat_bubble_2,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(height: 50),
              Text(
                "Welcome Back!!",
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              const SizedBox(height: 25),
              MyTextField(
                controller: _mailController,
                hintText: "Mail",
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: _passwordController,
                hintText: "Password",
                isPassword: true,
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 50),
              MyButton(
                buttonText: "Login",
                onTap: () {
                  login(context);
                },
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not Register Yet?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    Text(
                      " Register",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
