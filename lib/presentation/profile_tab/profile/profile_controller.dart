import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:life_pulse/data/network/api.dart';
import 'package:life_pulse/presentation/profile_tab/profile/user_model.dart';
import 'package:life_pulse/presentation/resources/assets_manager.dart';
import 'package:life_pulse/presentation/resources/color_manager.dart';
import '../../resources/helpers/functions.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../widgets/dialog.dart';
class ProfileController extends GetxController{
  RxBool isLoading = false.obs;
  RxString userName = ''.obs;
  RxString walletBalance = '00'.obs;
  RxString userEmail = ''.obs;
  RxnString userImage = RxnString('');
  RxString? selectedFavLanguage= "".obs;
  int? favLangId ;
  UserModel? user ;
  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      user = await fetchUserProfile();
    } catch (e) {
      // Handle error in onInit if needed, e.g. show a general error message
      debugPrint("Failed to initialize profile: $e");
    }
  }

  Future<UserModel> fetchUserProfile() async {
    try {
      isLoading.value = true;
      dynamic response = await Api().get('me');

      if (response.statusCode == 200) {
        final profileResponse = profileResponseFromJson(json.encode(response.data));
        userName.value = profileResponse.data.name;
        userImage.value = profileResponse.data.profileImage;
        walletBalance.value = profileResponse.data.walletBalance.toString();
        debugPrint(profileResponse.data.profileImage.toString() + ":::::::::::::::::::::::::::");

        if (profileResponse.success) {
          return profileResponse.data;
        } else {
          throw Exception('API returned success: false');
        }
      } else {
        throw Exception('Failed to load user profile. Status code: ${response.statusCode}');
      }
    } catch (e) {
      showErrorSnackBar(message: e.toString());
      debugPrint('Error fetching user profile: $e');
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  void logout() async{
    var response = await Api().post('logout',);
    if(response.statusCode == 200){
      final storage = GetStorage();
      storage.remove("token");
      Get.deleteAll();
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
     'phone': phoneTextController.text,
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
        isLoading.value = false ; // Consider moving this to finally block if there are multiple exit points before it.

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
        isLoading.value = false ; // Also consider moving this to finally.

      }

    } catch (err) {
      showErrorSnackBar(message:  error.isNotEmpty ? error :  err.toString());
      isLoading.value = false ; // This is good, but a finally block is more robust.
      throw Exception(err.toString());
    } finally {
      // if isLoading was set to true at the start of editProfile unconditionally,
      // then it should be set to false here unconditionally.
      // However, the current logic sets isLoading = false in success/else/catch paths.
      // For consistency, consider a single finally block for isLoading = false for editProfile too.
    }
  }


  RxInt selectedLanguage = 0.obs;
  onChanged(int value) {
      selectedLanguage.value = value ;
  }

  void changeLanguage(String languageCode) async {
    final box = GetStorage();
    await box.write('language_code', languageCode);
    selectedLanguage.value = getIndexFromLangCode(languageCode);
    Api().languageCode = languageCode;
    Get.updateLocale(Locale(languageCode));
  }

  int getIndexFromLangCode(String code) {
    const mapping = {
      'en': 0, 'ar': 6, 'fr': 7, 'es': 8, 'de': 9,
      'ru': 10, 'ur': 11, 'cn': 12, 'id': 13, 'fa': 14,
      'tr': 15, 'th': 16 , 'tl': 17, 'ha': 18
    };
    return mapping[code] ?? 6;
  }
  String getCurrentLanguageName(BuildContext context) {
    final locale = Get.locale ?? const Locale('ar');
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

    return languageNames[languageCode] ?? 'Arabic (EG)';
  }

}