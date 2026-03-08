import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapp/core/constants/assets.dart';
import 'package:youapp/core/constants/colors.dart';
import 'package:youapp/core/constants/text_style.dart';
import 'package:youapp/presentation/controller/user_controller.dart';
import 'package:youapp/routes/app_routes.dart';

class YouAppInterestWidget extends StatelessWidget {
  const YouAppInterestWidget({super.key, required this.usercontroller});

  final UserController usercontroller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 16),
      decoration: BoxDecoration(
        color: childCardBackgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Interest', style: cTextBold),
              GestureDetector(
                onTap: () {
                  Get.offAllNamed(AppRoutes.interests);
                },
                child: Image.asset(Assets.icEdit, width: 17, height: 17),
              ),
            ],
          ),
          SizedBox(height: 33),
          Obx(() {
            if (usercontroller.user.value.interests.isEmpty) {
              return Text(
                'Add in your interest to find a better match',
                style: cTextMedSM.copyWith(color: colorWhiteOpc52),
              );
            } else {
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: usercontroller.user.value.interests
                    .map(
                      (interest) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          interest,
                          style: cTextMedSM.copyWith(color: primaryColor),
                        ),
                      ),
                    )
                    .toList(),
              );
            }
          }),
        ],
      ),
    );
  }
}
