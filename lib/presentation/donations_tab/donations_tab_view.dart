import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:life_pulse/presentation/donations_tab/widgets/donation_list_item_widget.dart';
import 'package:life_pulse/presentation/transations_tab/widgets/section_header_widget.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/validation_manager.dart';
import '../widgets/empty_state_place_holder.dart';
import 'controllers/donations_controller.dart';
import 'donation_details_view.dart';

class DonationsScreen extends StatefulWidget {
  const DonationsScreen({super.key});

  @override
  State<DonationsScreen> createState() => _DonationsScreenState();
}

class _DonationsScreenState extends State<DonationsScreen> {
    final DonationsController controller = Get.put(DonationsController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        controller.loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isGuest()
        ? Scaffold(
            body: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.letsInRoute);
              },
              child: EmptyStateHolder(image: ImageAssets.profile, description: AppStrings.logInHint.tr),
            ),
          )
        : Scaffold(
            backgroundColor: const Color(0xFFF8FDF7),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              titleSpacing: 25,
              title: Text(
                AppStrings.myDonations.tr,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: const Color(0xFFD7F0E3),
              elevation: 0,
              flexibleSpace: Image.asset(
                'assets/images/background_pattern.png',
                fit: BoxFit.cover,
              ),
            ),
            body: SafeArea(
              child: Obx(() {
                if (controller.isLoading.value && controller.donations.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.donations.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: () => controller.fetchDonations(isRefresh: true),
                    color: ColorManager.primary,
                    backgroundColor: Theme.of(context).cardColor,

                    child: Stack(
                      children: [
                        ListView(),
                        Center(child: Text(AppStrings.noDonationsYet.tr)),
                      ],
                    ),
                  );
                }

                final groupedDonations = controller.groupedDonations;
                final months = groupedDonations.keys.toList();

                return RefreshIndicator(
                  onRefresh: () => controller.fetchDonations(isRefresh: true),
                  color: Colors.green,

                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: months.length + (controller.isLoadingMore.value ? 1 : 0),
                  itemBuilder: (context, index) {
                      if (index == months.length) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      final String month = months[index];
                      final donations = groupedDonations[month]!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionHeaderWidget(title: month),
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: donations.length,
                          itemBuilder: (context, itemIndex) {
                            return DonationListItemWidget(
                              donation: donations[itemIndex],
                              onTap: () {
                                Get.to(() => DonationDetailsScreen(donationId: donations[itemIndex].id));
                                //print("Tapped donation ID: ${donations[itemIndex].id}");
                              },
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(
                            height: 1,
                            indent: 16,
                            endIndent: 16,
                          ),
                        ),
                      ],
                    );
                  },
                  ),
                );
              }),
            ),
          );
  }
}
