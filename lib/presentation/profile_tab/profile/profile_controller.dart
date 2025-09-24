import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile;
import 'package:get/get_connect/http/src/multipart/multipart_file.dart' hide MultipartFile;
import 'package:get_storage/get_storage.dart';
import 'package:life_pulse/data/network/api.dart';
import 'package:life_pulse/presentation/profile_tab/profile/user_model.dart';
import 'package:life_pulse/presentation/resources/helpers/storage.dart';
import 'package:life_pulse/presentation/resources/strings_manager.dart';
import '../../resources/helpers/functions.dart';
import '../../resources/validation_manager.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxString userName = ''.obs;
  RxString walletBalance = '00'.obs;
  RxString userEmail = ''.obs;
  RxnString userImage = RxnString('');
  RxString? selectedFavLanguage = "".obs;
  int? favLangId;
  UserModel? user;

  final _box = GetStorage();
  RxBool isAnonymous = false.obs;

  //? //////////////// Edit Profile Variables //////////////// //
  final ImagePicker _picker = ImagePicker();
  Rx<File?> selectedImage = Rx(null);

  TextEditingController emailTextController = TextEditingController();
  TextEditingController fullNameTextController = TextEditingController();
  TextEditingController nicknameTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
    isAnonymous.value = _box.read('isAnonymous') ?? true;
    if (!isGuest()) {
      try {
        user = await fetchUserProfile();
      } catch (e) {
        debugPrint("${AppStrings.failedToInitializeProfile.tr} $e");
      }
    }
  }

  void loadProfileData() {
    if (user != null) {
      fullNameTextController.text = user!.name;
      //nicknameTextController.text = user!.name;
      phoneTextController.text = user!.mobile;
      // emailTextController.text = user!.email ?? 'mail@example.com';
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
        // debugPrint(profileResponse.data.profileImage.toString() + ":::::::::::::::::::::::::::");

        if (profileResponse.success) {
          user = profileResponse.data;
          return profileResponse.data;
        } else {
          throw Exception(AppStrings.apiReturnedFalse.tr);
        }
      } else {
        throw Exception('${AppStrings.failedToLoadUserProfile.tr} ${response.statusCode}');
      }
    } catch (e) {
      showErrorSnackBar(message: e.toString());
      debugPrint('Error fetching user profile: $e');
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  void logout() async {
    var response = await Api().post(
      'logout',
    );
    if (response.statusCode == 200) {
      final secureStorage = TokenStorage();
      secureStorage.deleteToken();
      Get.deleteAll();
    }
  }

  void toggleAnonymous(bool value) {
    isAnonymous.value = value;
    _box.write('isAnonymous', value);
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  Future<void> editProfile() async {
    isLoading.value = true;
    try {
      if (selectedImage.value != null) {
        await _updateProfileImage();
      }

      dynamic body = {
        'name': fullNameTextController.text,
        'mobile': phoneTextController.text,
        // "current_password": "oldpassword",
        // "password": "newpassword",
        // "password_confirmation": "newpassword"
      };

      var response = await Api().post('profile', data: body);

      if (response.statusCode == 200 && response.data['success'] == true) {
        await fetchUserProfile();
        Get.back();
        showSuccessSnackBar(message: response.data['message']);
      } else {
        showErrorSnackBar(message: response.data['message'] ?? AppStrings.failedToUpdateProfile.tr);
      }
    } catch (e) {
      showErrorSnackBar(message: e.toString());
      debugPrint('Error updating profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _updateProfileImage() async {
    if (selectedImage.value == null) return;

    try {
      dynamic body = {
        'image': await MultipartFile.fromFile(selectedImage.value!.path),
      };

      var response = await Api().postFormData('profile/image', data: body);

      if (response.statusCode == 200 && response.data['success'] == true) {
        selectedImage.value = null;
      } else {
        throw Exception(response.data['message'] ?? AppStrings.failedToUpdateImage.tr);
      }
    } catch (e) {
      rethrow;
    }
  }

  RxInt selectedLanguage = 0.obs;
  onChanged(int value) {
    selectedLanguage.value = value;
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
      'en': 0,
      'ar': 6,
      'fr': 7,
      'es': 8,
      'de': 9,
      'ru': 10,
      'ur': 11,
      'cn': 12,
      'id': 13,
      'fa': 14,
      'tr': 15,
      'th': 16,
      'tl': 17,
      'ha': 18
    };
    return mapping[code] ?? 6;
  }

  String getCurrentLanguageName(BuildContext context) {
    final locale = Get.locale ?? const Locale('ar');
    final languageCode = locale.languageCode;

    final languageNames = {
      'en': AppStrings.englishUS.tr,
      'ar': AppStrings.arabic.tr, // Arabic
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

    return languageNames[languageCode] ?? AppStrings.arabicEG.tr;
  }
}
