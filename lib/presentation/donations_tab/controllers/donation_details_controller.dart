import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:life_pulse/data/network/api.dart';
import 'package:life_pulse/presentation/resources/helpers/functions.dart';
import '../models/donation.dart';

class DonationDetailsController extends GetxController {
  final int donationId;
  DonationDetailsController({required this.donationId});

  final RxBool isLoading = true.obs;
  final Rx<Donation?> donation = Rx<Donation?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchDonationDetails();
  }

  Future<void> fetchDonationDetails() async {
    try {
      isLoading(true);
      final response = await Api().get('donations/$donationId');

      if (response.statusCode == 200 && response.data['success'] == true) {
        donation.value = Donation.fromJson(response.data['data']);
      } else {
        final errorMessage = response.data['message'] ?? 'Failed to load donation details.';
        showErrorSnackBar(message: errorMessage);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching donation details: $e');
      }
      showErrorSnackBar(message: 'An error occurred.');
    } finally {
      isLoading(false);
    }
  }
}