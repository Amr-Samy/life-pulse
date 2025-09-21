import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:life_pulse/presentation/home_tab/home/home_view.dart';
import 'package:life_pulse/presentation/resources/color_manager.dart';

import 'favorites_controller.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoritesController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
        backgroundColor: ColorManager.lightGreenColor,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.fetchFavorites(),
        backgroundColor: Theme.of(context).cardColor,
        color: ColorManager.primary,
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.favoriteCampaigns.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border,
                      size: 80, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  const Text(
                    'No Favorites Yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tap the heart icon on a campaign to add it here.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: controller.favoriteCampaigns.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.55,
            ),
            itemBuilder: (context, index) {
              final campaign = controller.favoriteCampaigns[index];
              return LatestCampaignCard(campaign: campaign);
            },
          );
        }),
      ),
    );
  }
}