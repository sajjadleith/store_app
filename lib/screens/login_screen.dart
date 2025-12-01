import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/controllers/login_provider.dart';
import 'package:store/core/enums/request_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController emailController = TextEditingController(
    // text: "user@example.com",
  );
  final TextEditingController passwordController = TextEditingController(
    // text: "string",
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Page")),
      body: Consumer<LoginProvider>(
        builder: (context, loginProvider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 10,
                ),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(label: Text("Enter Email")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 10,
                ),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(label: Text("Enter Password")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 10,
                ),
                child:
                    loginProvider.generalState.requestState ==
                        RequestState.loading
                    ? Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () {
                          context.read<LoginProvider>().login(
                            emailController.text,
                            passwordController.text,
                            context,
                          );
                        },
                        child: Center(child: Text("Login")),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
