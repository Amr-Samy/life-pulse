import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:life_pulse/presentation/resources/strings_manager.dart';
import 'controllers/donation_details_controller.dart';

class DonationDetailsScreen extends StatelessWidget {
  final int donationId;

  const DonationDetailsScreen({super.key, required this.donationId});

  @override
  Widget build(BuildContext context) {
    final DonationDetailsController controller =
    Get.put(DonationDetailsController(donationId: donationId));

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.donationDetails.tr),
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.donation.value == null) {
            return Center(
              child: Text(
                AppStrings.donationNotFound.tr,
                style: const TextStyle(fontSize: 16),
              ),
            );
          }

          final donation = controller.donation.value!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Campaign Information Card
                Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (donation.campaign.firstImage != null)
                        Image.network(
                          donation.campaign.firstImage!,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                          const SizedBox(
                            height: 180,
                            child: Icon(Icons.broken_image, size: 50),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          donation.campaign.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Donation Details Section
                 Text(
                  AppStrings.details.tr,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                  ),
                ),
                const Divider(height: 20),
                _buildDetailRow(AppStrings.amount.tr,
                    '\$${donation.amount.toStringAsFixed(2)}',
                    valueColor: Colors.green),
                _buildDetailRow(AppStrings.statusLabel.tr, donation.status.capitalizeFirst ?? donation.status),
                if (donation.paymentMethod != null)
                _buildDetailRow(AppStrings.paymentMethodLabel.tr, donation.paymentMethod!.capitalizeFirst ?? donation.paymentMethod!),
                if (donation.transactionId != null)
                  _buildDetailRow(AppStrings.transactionIdLabel.tr, donation.transactionId!),
                _buildDetailRow(AppStrings.dateLabel.tr,
                    DateFormat('d MMMM yyyy, hh:mm a').format(donation.createdAt)),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}
