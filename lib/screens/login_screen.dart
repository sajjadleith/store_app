import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:store/controllers/login_provider.dart';
import 'package:store/core/app_icons.dart';
import 'package:store/core/enums/request_state.dart';
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 48),

                    /// ✅ Email
                    CustomTextFormField(
                      controller: emailController,
                      icon: const Icon(Icons.email),
                      title: 'Email address',
                      obscure: false,
                    ),

                    const SizedBox(height: 20),

                    /// ✅ Password
                    CustomTextFormField(
                      controller: passwordController,
                      icon: const Icon(Icons.lock),
                      title: 'Password',
                      obscure: true,
                    ),

                    const SizedBox(height: 10),

                    /// ✅ Login Button مرتبط بالـ Provider
                    loginProvider.generalState.requestState == RequestState.loading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            onPressed: () {
                              context.read<LoginProvider>().login(
                                emailController.text,
                                passwordController.text,
                                context,
                              );
                            },
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
