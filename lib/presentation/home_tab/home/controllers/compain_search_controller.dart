import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/network/api.dart';
import '../../../../presentation/resources/helpers/functions.dart';
import '../models/campaign_model.dart';

class CampaignSearchController extends GetxController {
  final TextEditingController searchEditingController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxList<Campaign> searchResults = <Campaign>[].obs;

  final RxInt currentPage = 1.obs;
  final RxBool hasMore = true.obs;
  final RxBool isLoadingMore = false.obs;

  final RxString _query = ''.obs;

  @override
  void onInit() {
    super.onInit();
    debounce(_query, (_) => _searchCampaigns(isNewSearch: true), time: const Duration(milliseconds: 500));
  }

  void onSearchChanged(String val) {
    _query.value = val;
  }

  Future<void> _searchCampaigns({bool isNewSearch = false}) async {
    if (_query.value.trim().isEmpty) {
      searchResults.clear();
      isLoading.value = false;
      return;
    }

    if (isNewSearch) {
      isLoading.value = true;
      currentPage.value = 1;
      hasMore.value = true;
      searchResults.clear();
    }

    try {
      final response = await Api().get(
        'campaigns',
        queryParameters: {
          'search': _query.value,
          'page': currentPage.value,
        },
      );

      if (response.statusCode == 200) {
        final campaignsResponse = CampaignsResponse.fromJson(response.data);
        searchResults.addAll(campaignsResponse.data);

        final meta = campaignsResponse.meta;
        if (meta.currentPage! >= meta.lastPage!) {
          hasMore.value = false;
        } else {
          currentPage.value++;
        }
      } else {
        showErrorSnackBar(message: 'Failed to load search results.');
      }
    } catch (e) {
      showErrorSnackBar(message: 'An error occurred: $e');
      debugPrint("Search Campaigns Error: $e");
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore.value || !hasMore.value) return;

    isLoadingMore.value = true;
    await _searchCampaigns();
  }

  @override
  void onClose() {
    searchEditingController.dispose();
    super.onClose();
  }
}
