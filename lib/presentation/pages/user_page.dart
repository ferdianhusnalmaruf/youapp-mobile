import 'package:flutter/material.dart';
import 'package:youapp/core/constants/assets.dart';
import 'package:get/get.dart';
import 'package:youapp/core/constants/colors.dart';
import 'package:youapp/core/constants/text_style.dart';
import 'package:youapp/presentation/controller/user_controller.dart';
import 'package:youapp/presentation/widgets/youapp_about_form_widget.dart';
import 'package:youapp/presentation/widgets/youapp_interest_widget.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final usercontroller = Get.find<UserController>();

  @override
  initState() {
    super.initState();
    usercontroller.getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Obx(
          () => Text(
            '@${usercontroller.user.value.username ?? 'username'}',
            style: cTextMedSM,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RefreshIndicator(
          onRefresh: () async {
            await usercontroller.getUserProfile();
          },
          child: ListView(
            children: [
              Container(
                height: 190,
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: headerCardBackgroundColor,
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Spacer(),
                    Obx(() {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '@${usercontroller.user.value.username ?? 'username'},',
                            style: cTextBold,
                          ),
                          Row(
                            children: [
                              if (usercontroller.user.value.horoscope != null)
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: colorWhiteOpc06,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      usercontroller.user.value.horoscope!,
                                      style: cTextMedSM,
                                    ),
                                  ),
                                ),

                              if (usercontroller.user.value.zodiac != null)
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: colorWhiteOpc06,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      usercontroller.user.value.zodiac!,
                                      style: cTextMedSM,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
              SizedBox(height: 24),
              YouAppAboutFormWidget(),
              SizedBox(height: 18),
              YouAppInterestWidget(usercontroller: usercontroller),
            ],
          ),
        ),
      ),
    );
  }
}
