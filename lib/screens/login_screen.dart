import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:store/controllers/login_provider.dart';
import 'package:store/core/app_icons.dart';
import 'package:store/core/enums/request_state.dart';
import 'package:store/screens/register_screen.dart';
import 'package:store/screens/widgets/custom_button.dart';
import 'package:store/screens/widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController(text: "admin@admin.com");

  final TextEditingController passwordController = TextEditingController(text: "12345678");

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFBF5F4),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<LoginProvider>(
            builder: (context, loginProvider, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),

                    const Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 6),

                    const SizedBox(height: 50),
                    CustomTextFormField(
                      controller: emailController,
                      icon: const Icon(Icons.email),
                      title: 'Email address',
                      obscure: false,
                    ),

                    const SizedBox(height: 16),

                    CustomTextFormField(
                      controller: passwordController,
                      icon: const Icon(Icons.lock),
                      title: 'Password',
                      obscure: true,
                    ),

                    const SizedBox(height: 24),

                    loginProvider.generalState.requestState == RequestState.loading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            title: "Login",
                            onPressed: () {
                              context.read<LoginProvider>().login(
                                emailController.text,
                                passwordController.text,
                                context,
                              );
                            },
                          ),

                    const SizedBox(height: 20),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Forget Password?",
                        style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                      ),
                    ),

                    const SizedBox(height: 40),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("You are new? ", style: TextStyle(fontSize: 14)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const RegisterScreen()),
                            );
                          },
                          child: Text(
                            "Create new",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffE85C3A),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
