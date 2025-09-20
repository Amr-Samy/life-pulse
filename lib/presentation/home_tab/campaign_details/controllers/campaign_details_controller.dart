import 'package:get/get.dart';
import 'package:life_pulse/data/network/api.dart';
import 'package:life_pulse/presentation/resources/helpers/functions.dart';

import '../../home/controllers/home_controller.dart';
import '../../home/models/campaign_model.dart';

class CampaignDetailsController extends GetxController {
  final int campaignId;
  CampaignDetailsController({required this.campaignId});

  final RxBool isLoading = true.obs;
  final Rx<Campaign?> campaign = Rx<Campaign?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchCampaignDetails();
  }

  Future<void> fetchCampaignDetails() async {
    try {
      isLoading(true);
      final response = await Api().get('campaigns/$campaignId');

      if (response.statusCode == 200 && response.data['success'] == true) {
        campaign.value = Campaign.fromJson(response.data['data']);
      } else {
        showErrorSnackBar(
            message: 'Failed to load campaign details. Please try again.');
      }
    } catch (e) {
      showErrorSnackBar(message: 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  void toggleFavorite() {
    final homeController = Get.find<HomeController>(tag: "HomeController");
    homeController.toggleFavorite(campaignId);
  }

}