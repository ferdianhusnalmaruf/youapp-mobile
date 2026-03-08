import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapp/core/constants/colors.dart';
import 'package:youapp/core/constants/text_style.dart';
import 'package:youapp/presentation/controller/auth_controller.dart';
import 'package:youapp/presentation/widgets/youapp_password_form_field_widget.dart';
import 'package:youapp/presentation/widgets/youapp_text_form_field_widget.dart';
import 'package:youapp/presentation/widgets/youapp_button_widget.dart';
import 'package:youapp/routes/app_routes.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = Get.find<AuthController>();

  final emailController = TextEditingController();
  final passController = TextEditingController();

  bool isEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkExistingToken();

    emailController.addListener(() {
      setState(() {
        isEnabled =
            emailController.text.isNotEmpty && passController.text.isNotEmpty;
      });
    });

    passController.addListener(() {
      setState(() {
        isEnabled =
            emailController.text.isNotEmpty && passController.text.isNotEmpty;
      });
    });
  }

  Future<void> _checkExistingToken() async {
    final token = await controller.getToken();
    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      Get.offNamed(AppRoutes.profile);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(gradient: backgroundRadialGradientColor),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 60),
              Text('Login', style: cTextBoldXL),
              SizedBox(height: 25),
              YouappTextFormFieldWidget(
                labelText: 'Email',
                controller: emailController,
              ),
              SizedBox(height: 20),
              YouappPasswordFormFieldWidget(
                labelText: 'Password',
                controller: passController,
              ),
              SizedBox(height: 50),
              YouAppButtonWidget(
                label: 'Login',
                onPressed: isEnabled
                    ? () {
                        String email = '';
                        String username = '';

                        if (emailController.text.contains('@')) {
                          email = emailController.text;
                        } else {
                          username = emailController.text;
                        }

                        controller.login(email, username, passController.text);
                      }
                    : null,
              ),
              SizedBox(height: 52),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'No account?',
                    style: cTextMedSM,
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Register here',
                        style: cTextMedSM.copyWith(
                          color: goldenColor.colors.first,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(AppRoutes.register);
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
