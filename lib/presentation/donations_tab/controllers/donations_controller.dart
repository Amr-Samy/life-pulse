import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:life_pulse/data/network/api.dart';
import 'package:life_pulse/presentation/resources/helpers/functions.dart';
import 'package:life_pulse/presentation/resources/strings_manager.dart';
import '../../profile_tab/profile/profile_controller.dart';
import '../../resources/validation_manager.dart';
import '../../transations_tab/controllers/transactions_controller.dart';
import '../models/donation.dart';

class DonationsController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxBool isDonating = false.obs;
  final RxMap<String, List<Donation>> groupedDonations = <String, List<Donation>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    if (!isGuest()) fetchDonations();
  }

  Future<void> fetchDonations() async {
    try {
      isLoading(true);
      final response = await Api().get('donations');
      if (kDebugMode) {
        print(response.data);
      }
      if (response.statusCode == 200 && response.data['success'] == true) {
        final List<Donation> donations =
            (response.data['data'] as List).map((item) => Donation.fromJson(item)).toList();
        _groupDonations(donations);
        print("donations fetched successfully.");
      } else {
        showErrorSnackBar(message: AppStrings.failedToLoadDonations.tr);
      }
    } catch (e) {
      if (kDebugMode) {
        print('${AppStrings.errorFetchingDonations.tr} $e');
      }
      showErrorSnackBar(message: AppStrings.anErrorOccurredFetchingDonations.tr);
    } finally {
      isLoading(false);
    }
  }

  Future<bool> makeDonation({
    required int campaignId,
    required int amount,
    required bool isAnonymous,
  }) async {
    isDonating(true);
    try {
      final response = await Api().post(
        'campaigns/$campaignId/donate',
        data: {
          "amount": amount,
          "is_anonymous": isAnonymous ? 1 : 0,
        },
      );

      if (response.statusCode == 201 && response.data['success'] == true) {
        final profileController = Get.find<ProfileController>(tag: "ProfileController");
        final transactionsController = Get.find<TransactionsController>();

        fetchDonations();
        profileController.fetchUserProfile();
        transactionsController.fetchTransactions();
        // Get.back();

        return true;
      } else {
        showErrorSnackBar(message: response.data['message'] ?? AppStrings.failedToProcessDonation.tr);
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('${AppStrings.errorMakingDonation.tr} $e');
      }
      showErrorSnackBar(message: AppStrings.anErrorOccurredPleaseTryAgain.tr);
      return false;
    } finally {
      isDonating(false);
    }
  }

  Future<bool> quickDonation({
    required int amount,
    required bool isAnonymous,
  }) async {
    isDonating(true);
    try {
      final response = await Api().post(
        'quick-donate',
        data: {
          "amount": amount,
          "is_anonymous": isAnonymous ? 1 : 0,
        },
      );

      if (response.statusCode == 201 && response.data['success'] == true) {
        final profileController = Get.find<ProfileController>(tag: "ProfileController");
        final transactionsController = Get.find<TransactionsController>();

        fetchDonations();
        profileController.fetchUserProfile();
        transactionsController.fetchTransactions();
        Get.back();

        return true;
      } else {
        showSuccessSnackBar(message: response.data['message'] ?? AppStrings.failedToProcessDonation.tr);
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('${AppStrings.errorMakingDonation.tr} $e');
      }
      showErrorSnackBar(message: AppStrings.anErrorOccurredPleaseTryAgain.tr);
      return false;
    } finally {
      isDonating(false);
    }
  }

  void _groupDonations(List<Donation> donations) {
    final data = SplayTreeMap<String, List<Donation>>();
    final now = DateTime.now();

    for (var donation in donations) {
      String groupKey;
      if (donation.createdAt.year == now.year && donation.createdAt.month == now.month) {
        groupKey = AppStrings.thisMonth.tr;
      } else {
        groupKey = DateFormat('MMM yyyy').format(donation.createdAt);
      }

      data.putIfAbsent(groupKey, () => []).add(donation);
    }
    groupedDonations.value = Map.fromEntries(data.entries.toList().reversed);
  }
}
