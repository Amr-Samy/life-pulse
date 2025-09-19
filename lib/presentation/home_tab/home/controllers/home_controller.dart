import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:life_pulse/presentation/resources/helpers/functions.dart';
import '../../../../data/network/api.dart';
import '../models/campaign_model.dart';

class HomeController extends GetxController{
  RxBool isLoading = true.obs;
  final RxBool isLoadingFeatured = true.obs;
  final RxBool isLoadingLatest = true.obs;

  final RxList<Campaign> featuredCampaigns = <Campaign>[].obs;
  final RxInt featuredCurrentPage = 1.obs;
  final RxBool hasMoreFeatured = true.obs;
  final RxBool isLoadingMoreFeatured = false.obs;

  final RxList<Campaign> latestCampaigns = <Campaign>[].obs;
  final RxInt latestCurrentPage = 1.obs;
  final RxBool hasMoreLatest = true.obs;
  final RxBool isLoadingMoreLatest = false.obs;

  late PageController pageController;
  final RxInt currentCampaignIndex = 1.obs;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(
      initialPage: currentCampaignIndex.value,
      viewportFraction: 0.75,
    );
    once(featuredCampaigns, (_) {
      if (pageController.hasClients && featuredCampaigns.length > currentCampaignIndex.value) {
        pageController.animateToPage(
          currentCampaignIndex.value,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
        );
      }
    });

    fetchData();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  Future<void> fetchData() async {
    featuredCampaigns.clear();
    featuredCurrentPage.value = 1;
    hasMoreFeatured.value = true;
    isLoadingFeatured.value = true;

    latestCampaigns.clear();
    latestCurrentPage.value = 1;
    hasMoreLatest.value = true;
    isLoadingLatest.value = true;
    await Future.wait([
      _getCampaigns(
        campaignList: featuredCampaigns,
        currentPage: featuredCurrentPage,
        hasMore: hasMoreFeatured,
        isLoading: isLoadingFeatured,
        isLoadingMore: isLoadingMoreFeatured,
        queryParams: {'priority': true, 'per_page': 3},
        errorType: "Featured",
      ),
      _getCampaigns(
        campaignList: latestCampaigns,
        currentPage: latestCurrentPage,
        hasMore: hasMoreLatest,
        isLoading: isLoadingLatest,
        isLoadingMore: isLoadingMoreLatest,
        queryParams: {'per_page': 2},
        errorType: "Latest",
      ),
    ]);
  }

  Future<void> _getCampaigns({
    required RxList<Campaign> campaignList,
    required RxInt currentPage,
    required RxBool hasMore,
    required RxBool isLoading,
    required RxBool isLoadingMore,
    required Map<String, dynamic> queryParams,
    required String errorType,
  }) async {
    try {
      final response = await Api().get(
        'campaigns',
        queryParameters: {
          ...queryParams,
          'page': currentPage.value,
        },
      );

      if (response.statusCode == 200) {
        final campaignsResponse = CampaignsResponse.fromJson(response.data);
        campaignList.addAll(campaignsResponse.data);

        // Update pagination state from meta
        final meta = campaignsResponse.meta;
        if (meta.currentPage! >= meta.lastPage!) {
          hasMore.value = false;
      } else {
          currentPage.value++;
    }
      } else {
        showErrorSnackBar(message: 'Failed to load $errorType campaigns.');
      }
    } catch (e) {
      showErrorSnackBar(message: 'An error occurred: $e');
      debugPrint("$errorType Campaigns Error: $e");
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  Future<void> loadMoreFeatured() async {
    if (isLoadingMoreFeatured.value || !hasMoreFeatured.value) return;
    isLoadingMoreFeatured.value = true;
    await _getCampaigns(
      campaignList: featuredCampaigns,
      currentPage: featuredCurrentPage,
      hasMore: hasMoreFeatured,
      isLoading: isLoadingFeatured,
      isLoadingMore: isLoadingMoreFeatured,
      queryParams: {'priority': true, 'per_page': 3},
      errorType: "Featured",
    );
    }

  Future<void> loadMoreLatest() async {
    if (isLoadingMoreLatest.value || !hasMoreLatest.value) return;
    isLoadingMoreLatest.value = true;
    await _getCampaigns(
      campaignList: latestCampaigns,
      currentPage: latestCurrentPage,
      hasMore: hasMoreLatest,
      isLoading: isLoadingLatest,
      isLoadingMore: isLoadingMoreLatest,
      queryParams: {'per_page': 2},
      errorType: "Latest",
    );
  }

  void onPageChanged(int index) {
    currentCampaignIndex.value = index;
    if (index >= featuredCampaigns.length - 2 && hasMoreFeatured.value) {
      loadMoreFeatured();
  }
  }
}