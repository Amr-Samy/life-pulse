import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:life_pulse/data/model/onboard.dart';
import 'package:life_pulse/presentation/resources/color_manager.dart';
import 'package:life_pulse/presentation/resources/constants_manager.dart';
import 'package:life_pulse/presentation/resources/strings_manager.dart';

class OnBoardingController extends GetxController{
  final storage = GetStorage();
  RxBool isLoading = false.obs;
  List<OnBoard> onBoardingList = [];

  @override
  void onInit() {
    super.onInit();
    getOnBoardingData();
  }

  // Check if onboarding has been completed before
  bool hasCompletedOnboarding() {
    return storage.read("firstRun") == "done";
    // return false;
  }

  // Mark onboarding as completed
  void completeOnboarding() {
    storage.write("firstRun", "done");
  }

  // Replace API call with static data
  List<OnBoard> getOnBoardingData() {
    onBoardingList = [
      OnBoard(
        text: "Welcome to Life Pulse! Track your health metrics easily.",
        imageUrl: "assets/images/boarding/boarding1.png",
      ),
      OnBoard(
        text: "Monitor your progress and set health goals.",
        imageUrl: "assets/images/boarding/boarding2.png",
      ),
      OnBoard(
        text: "Get personalized insights for better health.",
        imageUrl: "assets/images/boarding/boarding3.png",
      ),
    ];

    isLoading.value = false;
    return onBoardingList;
    }
  }