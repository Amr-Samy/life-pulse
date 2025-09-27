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

class DonationsScreen extends StatelessWidget {
  const DonationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DonationsController controller = Get.put(DonationsController());

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

                if (controller.isLoading.value && controller.groupedDonations.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.groupedDonations.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: controller.fetchDonations,
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

                return RefreshIndicator(
                  onRefresh: controller.fetchDonations,
                  color: Colors.green,

                  child: ListView.builder(

                  itemCount: controller.groupedDonations.keys.length,
                  itemBuilder: (context, index) {
                    final String month = controller.groupedDonations.keys.elementAt(index);
                    final donations = controller.groupedDonations[month]!;

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
                                print("Tapped donation ID: ${donations[itemIndex].id}");
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
