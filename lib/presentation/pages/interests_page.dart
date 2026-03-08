import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapp/core/constants/colors.dart';
import 'package:youapp/core/constants/text_style.dart';
import 'package:youapp/presentation/controller/interest_controller.dart';
import 'package:youapp/routes/app_routes.dart';

class InterestsPage extends StatefulWidget {
  InterestsPage({super.key});

  @override
  State<InterestsPage> createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage> {
  final interestController = Get.find<InterestController>();

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    interestController.getUserProfile();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(gradient: backgroundRadialGradientColor),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.offNamed(AppRoutes.profile);
            },
            icon: Icon(Icons.arrow_back_ios_new, color: primaryColor),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await interestController.submitInterests();
                Get.offNamed(AppRoutes.profile);
              },
              child: Text('Save', style: cTextMed.copyWith(color: Colors.blue)),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 75),
                Text(
                  'Tell everyone about yourself',
                  style: cTextBold.copyWith(color: goldenColor.colors.first),
                ),
                SizedBox(height: 12),
                Text('What interest you?', style: cTextBoldLg),
                SizedBox(height: 35),
                YouAppTagInputField(controller: _controller),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class YouAppTagInputField extends StatelessWidget {
  const YouAppTagInputField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final interestController = Get.find<InterestController>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorWhiteOpc06,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Obx(
        () => Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...interestController.interests.map(
              (tag) => Chip(
                backgroundColor: primaryColor.withOpacity(0.1),
                shadowColor: primaryColor.withOpacity(0.2),
                surfaceTintColor: primaryColor.withOpacity(0.1),
                label: Text(tag),
                clipBehavior: Clip.hardEdge,
                deleteIcon: const Icon(Icons.close, size: 18),
                onDeleted: () => interestController.removeInterest(tag),
              ),
            ),

            /// INPUT FIELD
            SizedBox(
              width: 120,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Add...",
                  hintStyle: cTextMedSM,
                ),
                onSubmitted: (value) {
                  interestController.addInterest(value);
                  controller.clear();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
