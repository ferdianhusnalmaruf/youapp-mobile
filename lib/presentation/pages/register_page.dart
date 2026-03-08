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

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controller = Get.find<AuthController>();

  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passController = TextEditingController();
  final passConfirmController = TextEditingController();

  bool isEnabled = false;

  @override
  void initState() {
    super.initState();

    emailController.addListener(() {
      setState(() {
        isEnabled =
            emailController.text.isNotEmpty &&
            usernameController.text.isNotEmpty &&
            passController.text.isNotEmpty &&
            passConfirmController.text.isNotEmpty;
      });
    });

    usernameController.addListener(() {
      setState(() {
        isEnabled =
            emailController.text.isNotEmpty &&
            usernameController.text.isNotEmpty &&
            passController.text.isNotEmpty &&
            passConfirmController.text.isNotEmpty;
      });
    });

    passController.addListener(() {
      setState(() {
        isEnabled =
            emailController.text.isNotEmpty &&
            usernameController.text.isNotEmpty &&
            passController.text.isNotEmpty &&
            passConfirmController.text.isNotEmpty;
      });
    });

    passConfirmController.addListener(() {
      setState(() {
        isEnabled =
            emailController.text.isNotEmpty &&
            usernameController.text.isNotEmpty &&
            passController.text.isNotEmpty &&
            passConfirmController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passController.dispose();
    passConfirmController.dispose();
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
          child: ListView(
            children: [
              SizedBox(height: 60),
              Text('Register', style: cTextBoldXL),
              SizedBox(height: 25),
              YouappTextFormFieldWidget(
                labelText: 'Enter Email',
                controller: emailController,
              ),
              SizedBox(height: 20),
              YouappTextFormFieldWidget(
                labelText: 'Enter Username',
                controller: usernameController,
              ),
              SizedBox(height: 20),
              YouappPasswordFormFieldWidget(
                labelText: 'Create Password',
                controller: passController,
              ),
              SizedBox(height: 20),
              YouappPasswordFormFieldWidget(
                labelText: 'Confirm Password',
                controller: passConfirmController,
              ),
              SizedBox(height: 50),
              YouAppButtonWidget(
                label: 'Register',
                onPressed: isEnabled
                    ? () {
                        if (passController.text == passConfirmController.text) {
                          controller.register(
                            emailController.text,
                            usernameController.text,
                            passController.text,
                          );
                        } else {
                          Get.snackbar(
                            'Error',
                            'Password confirmation does not match',
                            snackPosition: SnackPosition.BOTTOM,
                            colorText: Get.theme.colorScheme.onError,
                          );
                        }
                      }
                    : null,
              ),
              SizedBox(height: 52),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Have an account?',
                    style: cTextMedSM,
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Login here',
                        style: cTextMedSM.copyWith(
                          color: goldenColor.colors.first,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(AppRoutes.login);
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
