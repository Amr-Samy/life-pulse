import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  RxBool isLoading = true.obs;

  final RxInt selectedCampaignIndex = 0.obs;
  final RxInt currentCampaignIndex = 1.obs;
  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(
      initialPage: currentCampaignIndex.value,
      viewportFraction: 0.75,
    );
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void selectCampaign(int index) {
    selectedCampaignIndex.value = index;
  }
  void onPageChanged(int index) {
    currentCampaignIndex.value = index;
  }

}