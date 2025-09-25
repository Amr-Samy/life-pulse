import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:life_pulse/presentation/home_tab/campaign_details/controllers/campaign_updates_controller.dart';
import 'package:life_pulse/presentation/home_tab/campaign_details/widgets/updates_section.dart';

import '../../resources/strings_manager.dart';

class CampaignUpdatesScreen extends StatefulWidget {
  final int campaignId;
  const CampaignUpdatesScreen({super.key, required this.campaignId});

  @override
  State<CampaignUpdatesScreen> createState() => _CampaignUpdatesScreenState();
}

class _CampaignUpdatesScreenState extends State<CampaignUpdatesScreen> {
  late final CampaignUpdatesController controller;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller = Get.put(CampaignUpdatesController(campaignId: widget.campaignId));
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      controller.fetchUpdates(isLoadMore: true);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppStrings.campaignUpdates.tr),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.updates.isEmpty) {
          return const Center(child: Text('No updates found for this campaign.'));
        }
        return ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
          itemCount: controller.updates.length +
              (controller.isLoadingMore.value ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == controller.updates.length) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final update = controller.updates[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: UpdateCard(update: update),
            );
          },
        );
      }),
    );
  }
}