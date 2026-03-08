import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:youapp/domain/entities/user_response.dart';
import 'package:youapp/presentation/controller/user_controller.dart';

class UpdateAboutUserController extends GetxController {
  final isForm = false.obs;

  final selectedGender = Rxn<String>();
  final birthDate = Rxn<DateTime>();
  final horoscope = Rxn<String>();
  final zodiac = Rxn<String>();

  /// FORM KEY
  final formKey = GlobalKey<FormState>();

  /// CONTROLLERS
  final nameController = TextEditingController();
  final birthdateController = TextEditingController();
  final horoscopeController = TextEditingController();
  final zodiacController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  final userController = Get.find<UserController>();

  void toggleForm() {
    isForm.value = !isForm.value;
  }

  void setSelectedGender(String? gender) {
    selectedGender.value = gender;
  }

  void setBirthDate(DateTime date) {
    birthDate.value = date;

    horoscope.value = getHoroscope(date);
    zodiac.value = getChineseZodiac(date);

    horoscopeController.text = horoscope.value ?? '';
    zodiacController.text = zodiac.value ?? '';
  }

  /// SUBMIT WITH VALIDATION
  Future<void> submit() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    //     {
    //        "name": "Cantok",
    //        "birthday": "2000-12-13",
    //        "height": 180,
    //        "weight": 70,
    //        "gender": "male",
    //        "interests": [
    //          "string"
    //         ]
    //     }

    final body = {
      "name": nameController.text,
      // "gender": selectedGender.value,
      "birthday": DateFormat(
        'yyyy-MM-dd',
      ).format(birthDate.value ?? DateTime.now()),
      "height": int.tryParse(heightController.text),
      "weight": int.tryParse(weightController.text),
    };

    await userController.updateProfile(body);

    isForm.value = false;
  }

  /// HOROSCOPE
  String getHoroscope(DateTime date) {
    final d = date.day;
    final m = date.month;

    if ((m == 3 && d >= 21) || (m == 4 && d <= 19)) return 'Aries';
    if ((m == 4 && d >= 20) || (m == 5 && d <= 20)) return 'Taurus';
    if ((m == 5 && d >= 21) || (m == 6 && d <= 21)) return 'Gemini';
    if ((m == 6 && d >= 22) || (m == 7 && d <= 22)) return 'Cancer';
    if ((m == 7 && d >= 23) || (m == 8 && d <= 22)) return 'Leo';
    if ((m == 8 && d >= 23) || (m == 9 && d <= 22)) return 'Virgo';
    if ((m == 9 && d >= 23) || (m == 10 && d <= 23)) return 'Libra';
    if ((m == 10 && d >= 24) || (m == 11 && d <= 21)) return 'Scorpio';
    if ((m == 11 && d >= 22) || (m == 12 && d <= 21)) return 'Sagittarius';
    if ((m == 12 && d >= 22) || (m == 1 && d <= 19)) return 'Capricorn';
    if ((m == 1 && d >= 20) || (m == 2 && d <= 18)) return 'Aquarius';

    return 'Pisces';
  }

  /// CHINESE ZODIAC
  String getChineseZodiac(DateTime date) {
    const animals = [
      'Rat',
      'Ox',
      'Tiger',
      'Rabbit',
      'Dragon',
      'Snake',
      'Horse',
      'Goat',
      'Monkey',
      'Rooster',
      'Dog',
      'Pig',
    ];

    final index = (date.year - 2020) % 12;

    return animals[index < 0 ? index + 12 : index];
  }

  void setInitialData(User user) {
    nameController.text = user.name ?? '';

    selectedGender.value = user.gender;

    if (user.birthday != null) {
      final date = user.birthday;

      birthDate.value = date;
      birthdateController.text = "${date?.day}/${date?.month}/${date?.year}";

      if (date != null) {
        horoscope.value = getHoroscope(date);
        zodiac.value = getChineseZodiac(date);
      }

      horoscopeController.text = horoscope.value ?? '';
      zodiacController.text = zodiac.value ?? '';
    }

    heightController.text = user.height?.toString() ?? '';
    weightController.text = user.weight?.toString() ?? '';
  }
}
