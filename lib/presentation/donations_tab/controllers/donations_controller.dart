import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:life_pulse/data/network/api.dart';
import 'package:life_pulse/presentation/resources/helpers/functions.dart';
import 'package:life_pulse/presentation/resources/strings_manager.dart';
import 'package:life_pulse/presentation/transations_tab/controllers/wallet_controller.dart';
import '../../profile_tab/profile/profile_controller.dart';
import '../../resources/validation_manager.dart';
import '../../transations_tab/controllers/transactions_controller.dart';
import '../models/donation.dart';

class DonationsController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxBool isDonating = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxList<Donation> donations = <Donation>[].obs;

  int _currentPage = 1;
  int? _lastPage;

  Map<String, List<Donation>> get groupedDonations {
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
    return Map.fromEntries(data.entries.toList().reversed);
  }

  @override
  void onInit() {
    super.onInit();
    if (!isGuest()) fetchDonations(isRefresh: true);
  }

  Future<void> fetchDonations({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 1;
      _lastPage = null;
      isLoading(true);
    }
    if (isLoadingMore.value || (_lastPage != null && _currentPage > _lastPage!)) {
      return;
  }

    if (!isRefresh) {
      isLoadingMore(true);
    }

    try {
      final response = await Api().get('donations?page=$_currentPage');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final donationsResponse = donationsResponseFromJson(response.toString());
        final newDonations = donationsResponse.data;
        _lastPage = donationsResponse.meta.lastPage;

        if (isRefresh) {
          donations.clear();
        }

        donations.addAll(newDonations);
        _currentPage++;
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
      isLoadingMore(false);
    }
  }

  Future<void> loadMore() async {
    await fetchDonations();
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
        await Future.wait([
          fetchDonations(isRefresh: true),
          Get.find<ProfileController>(tag: "ProfileController").fetchUserProfile(),
          Get.find<TransactionsController>().fetchTransactions(isRefresh: true),
          Get.find<WalletController>(tag: "WalletController").fetchWalletData(),

        ]);
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
      if (kDebugMode) {
        print('API Status Code: ${response.statusCode}');
        print('API Response Body: ${response.data}');
      }

      if (response.statusCode == 200 && response.data['success'] == true) {
        await Future.wait([
          fetchDonations(isRefresh: true),
          Get.find<ProfileController>(tag: "ProfileController").fetchUserProfile(),
          Get.find<TransactionsController>().fetchTransactions(isRefresh: true),
          Get.find<WalletController>(tag: "WalletController").fetchWalletData(),
        ]);
        // Get.back();
        // showSuccessSnackBar(message: "تم التبرع بنجاح!");

        return true;
      } else {
        // showErrorSnackBar(message: response.data['message'] ?? AppStrings.failedToProcessDonation.tr);
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
    }