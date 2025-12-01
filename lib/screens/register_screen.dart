import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/controllers/register_provider.dart';
import 'package:store/core/enums/request_state.dart';
import 'package:store/core/widgets/navigate_back_widget.dart';
import 'package:store/screens/login_screen.dart';
import 'package:store/screens/widgets/custom_button.dart';
import 'package:store/screens/widgets/custom_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFBF5F4),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<RegisterProvider>(
            builder: (context, registerProvider, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    NavigateBackWidget(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                      },
                    ),
                    Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 48),
                    CustomTextFormField(
                      controller: userController,
                      icon: Icon(Icons.email),
                      title: 'Username',
                      obscure: false,
                    ),
                    SizedBox(height: 20),
                    CustomTextFormField(
                      controller: emailController,
                      icon: Icon(Icons.email),
                      title: 'Email address',
                      obscure: false,
                    ),
                    SizedBox(height: 20),
                    CustomTextFormField(
                      controller: passwordController,
                      icon: Icon(Icons.lock),
                      title: 'password',
                      obscure: true,
                    ),
                    SizedBox(height: 10),
                    registerProvider.generalState.requestState ==
                            RequestState.loading
                        ? Center(child: CircularProgressIndicator())
                        : CustomButton(
                            onPressed: () {
                              context.read<RegisterProvider>().register(
                                userController.text,
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
