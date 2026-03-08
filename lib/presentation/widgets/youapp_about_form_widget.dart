import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:youapp/core/constants/assets.dart';
import 'package:youapp/core/constants/colors.dart';
import 'package:youapp/core/constants/text_style.dart';
import 'package:youapp/domain/entities/user_response.dart';
import 'package:youapp/presentation/controller/update_about_user_controller.dart';
import 'package:youapp/presentation/controller/user_controller.dart';
import 'package:youapp/presentation/widgets/youapp_info_about_user_widget.dart';
import 'package:youapp/presentation/widgets/youapp_date_picker_field_widget.dart';
import 'package:youapp/presentation/widgets/youapp_text_form_field_widget.dart';

class YouAppAboutFormWidget extends StatefulWidget {
  const YouAppAboutFormWidget({super.key});

  @override
  State<YouAppAboutFormWidget> createState() => _YouAppAboutFormWidgetState();
}

class _YouAppAboutFormWidgetState extends State<YouAppAboutFormWidget> {
  final controller = Get.find<UpdateAboutUserController>();
  final userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    final user = userController.user.value;

    controller.setInitialData(user);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 16),
      decoration: BoxDecoration(
        color: childCardBackgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text('About', style: cTextBold),
                Obx(() {
                  if (controller.isForm.value) {
                    return TextButton(
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          controller.submit();
                          userController.getUserProfile();
                        }

                        controller.toggleForm();
                      },
                      child: Text(
                        'Save & Update',
                        style: cTextMedXS.copyWith(
                          color: goldenColor.colors.first,
                        ),
                      ),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        controller.toggleForm();
                        controller.setInitialData(userController.user.value);
                      },
                      child: Image.asset(Assets.icEdit, width: 17, height: 17),
                    );
                  }
                }),
              ],
            ),
            SizedBox(height: 33),
            Obx(() {
              if (controller.isForm.value) {
                return Column(
                  children: [
                    /// Display Name
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Display Name:',
                            style: cTextMedSM.copyWith(color: colorWhiteOpc52),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: YouappTextFormFieldWidget(
                            controller: controller.nameController,
                            hintText: 'Enter Name',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Display name required";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),

                    /// TODO : Gender Uncomment when API ready
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       flex: 1,
                    //       child: Text(
                    //         'Gender:',
                    //         style: cTextMedSM.copyWith(color: colorWhiteOpc52),
                    //       ),
                    //     ),

                    //     Expanded(
                    //       flex: 3,
                    //       child: YouappDropdownWidget<String>(
                    //         hintText: "Select Gender",
                    //         value: controller.selectedGender.value,
                    //         onChanged: (value) {
                    //           controller.setSelectedGender(value);
                    //         },
                    //         items: const [
                    //           DropdownMenuItem(
                    //             value: "male",
                    //             child: Text("Male"),
                    //           ),
                    //           DropdownMenuItem(
                    //             value: "female",
                    //             child: Text("Female"),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 12),

                    /// Birthday
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Birthday:',
                            style: cTextMedSM.copyWith(color: colorWhiteOpc52),
                          ),
                        ),

                        Expanded(
                          flex: 3,
                          child: YouappDatePickerFieldWidget(
                            controller: controller.birthdateController,
                            hintText: 'DD MM YYYY',
                            onDateSelected: (date) {
                              controller.setBirthDate(date);
                              // Optionally, you can also set the horoscope based on the selected date
                              controller.horoscopeController.text =
                                  controller.horoscope.value ?? '--';
                              controller.zodiacController.text =
                                  controller.zodiac.value ?? '--';
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),

                    /// Horoscope
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Horoscope:',
                            style: cTextMedSM.copyWith(color: colorWhiteOpc52),
                          ),
                        ),

                        Expanded(
                          flex: 3,
                          child: YouappTextFormFieldWidget(
                            controller: controller.horoscopeController,
                            isReadonly: true,
                            hintText: '--',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),

                    /// Zodiac
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Zodiac:',
                            style: cTextMedSM.copyWith(color: colorWhiteOpc52),
                          ),
                        ),

                        Expanded(
                          flex: 3,
                          child: YouappTextFormFieldWidget(
                            controller: controller.zodiacController,
                            isReadonly: true,
                            hintText: '--',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),

                    /// Height
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Height:',
                            style: cTextMedSM.copyWith(color: colorWhiteOpc52),
                          ),
                        ),

                        Expanded(
                          flex: 3,
                          child: YouappTextFormFieldWidget(
                            controller: controller.heightController,
                            keyboardType: TextInputType.number,
                            hintText: 'Add height',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Height required";
                              }

                              final height = int.tryParse(value);

                              if (height == null) {
                                return "Height must be number";
                              }

                              if (height < 50 || height > 300) {
                                return "Invalid height";
                              }

                              return null;
                            },
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Weight:',
                            style: cTextMedSM.copyWith(color: colorWhiteOpc52),
                          ),
                        ),

                        Expanded(
                          flex: 3,
                          child: YouappTextFormFieldWidget(
                            controller: controller.weightController,
                            keyboardType: TextInputType.number,
                            hintText: 'Add weight',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Weight required";
                              }

                              final weight = int.tryParse(value);

                              if (weight == null) {
                                return "Weight must be number";
                              }

                              if (weight < 20 || weight > 300) {
                                return "Invalid weight";
                              }

                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                final user = userController.user.value;

                if (user.hasValues) {
                  return Column(
                    children: [
                      if (user.birthday != null) ...[
                        YouAppInfoAboutUserWidget(
                          title: 'Birthday:',
                          value:
                              '${DateFormat('dd/MM/yyyy').format(user.birthday!)} (Age ${user.age})',
                        ),
                        SizedBox(height: 12),
                      ],

                      if (user.horoscope != null) ...[
                        YouAppInfoAboutUserWidget(
                          title: 'Horoscope:',
                          value: user.horoscope!,
                        ),

                        SizedBox(height: 12),
                      ],

                      if (user.zodiac != null) ...[
                        YouAppInfoAboutUserWidget(
                          title: 'Zodiac:',
                          value: user.zodiac!,
                        ),
                        SizedBox(height: 12),
                      ],

                      if (user.height != null) ...[
                        YouAppInfoAboutUserWidget(
                          title: 'Height:',
                          value: '${user.height} cm',
                        ),
                        SizedBox(height: 12),
                      ],

                      if (user.weight != null) ...[
                        YouAppInfoAboutUserWidget(
                          title: 'Weight:',
                          value: '${user.weight} kg',
                        ),
                        SizedBox(height: 12),
                      ],
                    ],
                  );
                } else {
                  return Text(
                    'Add in your about information to help others know you better',
                    style: cTextMedSM.copyWith(color: colorWhiteOpc52),
                  );
                }
              }
            }),
          ],
        ),
      ),
    );
  }
}
