import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:life_pulse/data/network/api.dart';
import '../models/campaign_update_model.dart';

class CampaignUpdatesController extends GetxController {
  final int campaignId;
  CampaignUpdatesController({required this.campaignId});

  final RxBool isLoading = true.obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool hasMore = true.obs;
  final RxInt currentPage = 1.obs;
  final RxList<CampaignUpdate> updates = <CampaignUpdate>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUpdates();
  }

  Future<void> fetchUpdates({bool isLoadMore = false}) async {
    if (isLoadingMore.value || !hasMore.value && isLoadMore) return;

    if (isLoadMore) {
      isLoadingMore(true);
    } else {
      isLoading(true);
    }

    try {
      final response = await Api().get(
        'campaigns/$campaignId/updates',
        queryParameters: {'page': currentPage.value},
      );

      if (response.statusCode == 200) {
        final List<dynamic> updatesData = response.data['data'];
        final meta = response.data['meta'];

        updates.addAll(updatesData.map((data) => CampaignUpdate.fromJson(data)));

        if (meta['current_page'] >= meta['last_page']) {
          hasMore(false);
        } else {
          currentPage.value++;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching updates: $e');
      }
    } finally {
      if (isLoadMore) {
        isLoadingMore(false);
      } else {
        isLoading(false);
      }
    }
  }
}