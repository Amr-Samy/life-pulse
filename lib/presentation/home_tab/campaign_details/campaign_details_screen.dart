import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:life_pulse/presentation/home_tab/campaign_details/widgets/campaign_header.dart';
import 'package:life_pulse/presentation/home_tab/campaign_details/widgets/campaign_info_card.dart';
import 'package:life_pulse/presentation/home_tab/campaign_details/widgets/content_section.dart';
import 'package:life_pulse/presentation/home_tab/campaign_details/widgets/summary_stats_section.dart';
import 'package:life_pulse/presentation/home_tab/campaign_details/widgets/updates_section.dart';

import 'controllers/campaign_details_controller.dart';

class CampaignDetailsScreen extends StatelessWidget {
  final int campaignId;
  const CampaignDetailsScreen({super.key, required this.campaignId});

  @override
  Widget build(BuildContext context) {
    final CampaignDetailsController controller =
        Get.put(CampaignDetailsController(campaignId: campaignId));

    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.campaign.value == null) {
          return const Center(child: Text('Campaign not found.'));
        }

        final campaign = controller.campaign.value!;

        return CustomScrollView(
        slivers: [
          CampaignHeader(
            imageUrl: campaign.firstImage,
            isFavorited: campaign.isFavorited,
            onFavoriteTap: () => controller.toggleFavorite(),
          ),

          SliverToBoxAdapter(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    CampaignInfoCard(campaign: campaign),
                    const SizedBox(height: 24),
                    if (campaign.description != null &&
                        campaign.description!.isNotEmpty) ...[
                  ContentSection(
                    title: 'Story',
                        content: campaign.description!,
                  ),
                      const SizedBox(height: 24),
                    ],
                  const SizedBox(height: 24),
                  UpdatesSection(campaign: campaign,),
                  const SizedBox(height: 24),
                  SummaryStatsSection(campaign: campaign),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          )
        ],
        );
      }),
    );
  }
}