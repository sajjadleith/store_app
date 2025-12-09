import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/controllers/change_password_provider.dart';
import 'package:store/controllers/profile_provider.dart';
import 'package:store/core/app_constains.dart';
import 'package:store/core/enums/request_state.dart';
import 'package:store/core/services/shared_pref_service.dart';
import 'package:store/core/widgets/custom_button_widget.dart';
import 'package:store/screens/custom_appbar.dart';
import 'package:store/screens/login_screen.dart';
import 'package:store/screens/widgets/custom_button.dart';
import 'package:store/screens/widgets/custom_text_form_field.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  @override
  void initState() {
    Future.microtask(() {
      context.read<ProfileProvider>().getProfile();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAppbarWidget(title: 'Profile Screen'),

              SizedBox(height: 50),

              Consumer<ProfileProvider>(
                builder: (context, profileProvider, child) {
                  final state = profileProvider.generalState.requestState;

                  if (state == RequestState.loading) {
                    return const Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state == RequestState.error) {
                    return const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("Failed to load profile ❌"),
                    );
                  }

                  final user = profileProvider.generalState.data!;

                  return Column(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.black12,
                        child: Icon(Icons.person, size: 40),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        user.userName,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(user.email, style: const TextStyle(color: Colors.grey)),
                      const SizedBox(height: 30),
                    ],
                  );
                },
              ),

              /// ✅ Old Password
              CustomTextFormField(
                controller: oldPasswordController,
                icon: Icon(Icons.lock),
                title: "Old Password",
                obscure: true,
              ),

              SizedBox(height: 12),

              /// ✅ New Password
              CustomTextFormField(
                controller: newPasswordController,
                icon: Icon(Icons.lock_outline),
                title: "New Password",
                obscure: true,
              ),

              SizedBox(height: 30),

              /// ✅ Change Button (متصل بالـ Provider)
              Consumer<ChangePasswordProvider>(
                builder: (context, provider, child) {
                  if (provider.generalState.requestState == RequestState.loading) {
                    return CustomButtonWidget(title: "Loading...", onPressed: () {});
                  }

                  return CustomButtonWidget(
                    title: "Change",
                    onPressed: () async {
                      final oldPass = oldPasswordController.text.trim();
                      final newPass = newPasswordController.text.trim();

                      if (oldPass.isEmpty || newPass.isEmpty) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text("Please fill all fields")));
                        return;
                      }

                      await provider.changePassword(oldPassword: oldPass, newPassword: newPass);

                      final state = provider.generalState.requestState;

                      if (state == RequestState.success && provider.generalState.data == true) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text("Password changed successfully ✅")));

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => LoginScreen()),
                          (route) => false,
                        );
                      } else if (state == RequestState.error) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text("Old password is wrong ❌")));
                      }
                    },
                  );
                },
              ),

              SizedBox(height: 15),

              /// ✅ Sign Out Button
              CustomButtonWidget(
                title: "Sign Out",
                onPressed: () async {
                  await SharedPrefServcie.removeData(AppConstain.token);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
