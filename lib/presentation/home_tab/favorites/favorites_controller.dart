import 'package:get/get.dart';
import 'package:life_pulse/data/network/api.dart';
import 'package:life_pulse/presentation/resources/helpers/functions.dart';

import '../home/models/campaign_model.dart';

class FavoritesController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxList<Campaign> favoriteCampaigns = <Campaign>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFavorites();
  }

  Future<void> fetchFavorites() async {
    try {
      isLoading(true);
      final response = await Api().get('favorites');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List<dynamic> campaignData = response.data['data'];
        favoriteCampaigns.value = campaignData
            .map((data) => Campaign.fromJson(data).copyWith(isFavorited: true))
            .toList();
      } else {
        showErrorSnackBar(message: 'Failed to load favorite campaigns.');
      }
    } catch (e) {
      showErrorSnackBar(message: 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }
}