import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:life_pulse/data/model/languages.dart';
import 'package:life_pulse/data/network/api.dart';
import 'package:life_pulse/presentation/resources/assets_manager.dart';
import 'package:life_pulse/presentation/resources/color_manager.dart';


import '../../resources/helpers/functions.dart';
import '../../resources/helpers/storage.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../widgets/dialog.dart';
class ProfileController extends GetxController{
  final GoogleSignIn _googleSignIn;
  ProfileController({required GoogleSignIn googleSignIn}) : _googleSignIn = googleSignIn;
  RxBool isLoading = true.obs;
  RxString studentName = ''.obs;
  RxString studentEmail = ''.obs;
  RxString studentImage = ''.obs;
  RxString studentGender = ''.obs;
  RxString? selectedFavLanguage= "".obs;
  int? favLangId ;
  RxBool isProfileComplete = false.obs;

  @override
  void onInit() {
    super.onInit();
    getLanguages();
  }



//? //////////////// 50- get languages //////////////// //
  LanguagesModel? languagesModel;
  List<Language> languageList=[];
  List<String> languages=[];

 getLanguages() async {
    try {
      // isLoading.value = true ;
      var  res = await Api().get('languages');
      languagesModel =  LanguagesModel.fromJson(res.data);
      languageList = languagesModel?.languages ?? [];
      for(Language lang in languageList){
        languages.add(lang.name!);
      }
      // isLoading.value = false ;
    } catch (err) {
      throw Exception(err.toString());
    }
  }
//? //////////////// Edit Profile //////////////// //
  String error = '';
  TextEditingController emailTextController = TextEditingController();
  TextEditingController fullNameTextController = TextEditingController();
  TextEditingController nicknameTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController dateTextController = TextEditingController();

  Future<void> editProfile() async {
    isLoading.value = true ;
    dynamic body = {
     'full_name': fullNameTextController.text,
     'nickname': nicknameTextController.text,
     'date_of_birth': dateTextController.text,
     'phone': phoneTextController.text,
     'gender': studentGender.value,
     'language_id': favLangId,
    };

    try {
      var  req = await Api().post(
        'update_account',
        data: body,
      );

      dynamic responseData = req.data;
      if (responseData is String) {
        // Handle the case where response is a String
        responseData = json.decode(responseData);
      }
      // Read values
      String status = responseData['status'];
      String message = responseData['message'];

      if(status == "success")
      {
        isLoading.value = false ;

        showDialog<void>(
            context: Get.context!,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              content: SuccessDialog(
                image: ImageAssets.congrats,
                title: AppStrings.congratulations.tr,
                subTitle: AppStrings.accountReady.tr,
                actions: ColorFiltered(
                  colorFilter: ColorFilter.mode(ColorManager.primary, BlendMode.srcIn),
                  child: Image.asset(
                    ImageAssets.loading,
                    height: 60,
                  ),
                ),
              ),
            )
        );

        Timer(const Duration(seconds: 1), () {
          Navigator.pop(Get.context!, true);
          Navigator.pushNamedAndRemoveUntil(
              Get.context!,
              Routes.mainRoute,
                  (Route<dynamic> route) => false
          );
        });

      } else{
        error = message ?? "";
        showErrorSnackBar(message:  error.isNotEmpty ? error :"");
        isLoading.value = false ;

      }

    } catch (err) {
      showErrorSnackBar(message:  error.isNotEmpty ? error :  err.toString());
      isLoading.value = false ;
      throw Exception(err.toString());
    }
  }


  void logout() async{
    final secureStorage = TokenStorage();
    secureStorage.deleteToken();
    Get.deleteAll();
    if (await _googleSignIn.isSignedIn()) {
    await _googleSignIn.signOut();
    debugPrint("Google Sign-In session cleared");
    }

    // Get.offAllNamed(Routes.letsInRoute);
  }

  //? Language /////////////////////////////////////////////////////
  RxInt selectedLanguage = 0.obs;
  onChanged(int value) {
      selectedLanguage.value = value ;
  }

  // Add this to ProfileController
  void changeLanguage(String languageCode) async {
    final box = GetStorage();
    await box.write('language_code', languageCode); // Store language
    selectedLanguage.value = getIndexFromLangCode(languageCode);
    Api().languageCode = languageCode;
    Get.updateLocale(Locale(languageCode)); // Update app locale
  }

  int getIndexFromLangCode(String code) {
    // Map language codes to radio button indices
    const mapping = {
      'en': 0, 'ar': 6, 'fr': 7, 'es': 8, 'de': 9,
      'ru': 10, 'ur': 11, 'cn': 12, 'id': 13, 'fa': 14,
      'tr': 15, 'th': 16 , 'tl': 17, 'ha': 18
    };
    return mapping[code] ?? 0; // Default to English
  }
  String getCurrentLanguageName(BuildContext context) {
    final locale = Get.locale ?? const Locale('en');
    final languageCode = locale.languageCode;

    final languageNames = {
      'en': 'English (US)',
      'ar': 'العربية', // Arabic
      'fr': 'Français', // French
      'es': 'Español', // Spanish
      'de': 'Deutsch', // German
      'ru': 'Русский', // Russian
      'ur': 'اردو', // Urdu
      'cn': '中文', // Chinese
      'id': 'Bahasa Indonesia', // Indonesian
      'fa': 'فارسی', // Persian
      'tr': 'Türkçe', // Turkish
      'tl': 'Tagalog', // Tagalog
      'ha': 'Hausa', // Hausa
      'th': 'ไทย', // Thai
    };

    return languageNames[languageCode] ?? 'English (US)';
  }

}