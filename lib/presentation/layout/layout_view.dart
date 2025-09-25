import 'package:life_pulse/presentation/home_tab/home/home_view.dart';
import 'package:life_pulse/presentation/layout/layout_controller.dart';
import 'package:life_pulse/presentation/profile_tab/profile/profile_controller.dart';
import 'package:life_pulse/presentation/profile_tab/profile/profile_view.dart';
import 'package:life_pulse/presentation/resources/index.dart';
import 'package:life_pulse/presentation/transations_tab/transactions_view.dart';

import '../donations_tab/donations_tab_view.dart';
import '../transations_tab/controllers/wallet_controller.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});
  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  final layoutController = Get.put(LayoutController(), tag: "LayoutController");

  List<Widget> screens = [
    const HomeView(),
    const TransactionsScreen(),
    const DonationsScreen(),
    const ProfileView(),
  ];
  final profileController = Get.put(ProfileController(), tag: "ProfileController");
  @override
  void initState() {
    Get.put(WalletController());
    super.initState();
    isGuest() ? () {} : profileController.fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //?back button disabled
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: Obx(
          () => NavigationBar(
            destinations: [
              NavigationDestination(
                icon: Image.asset(
                  ImageAssets.home,
                  height: AppSize.s24,
                ),
                selectedIcon: ColorFiltered(
                  colorFilter: const ColorFilter.mode(Colors.green, BlendMode.srcIn),
                  child: Image.asset(
                    ImageAssets.homeSelected,
                    height: AppSize.s24,
                  ),
                ),
                label: AppStrings.home.tr,
              ),
              NavigationDestination(
                icon: Image.asset(
                  ImageAssets.doc,
                  height: AppSize.s24,
                ),
                selectedIcon: ColorFiltered(
                  colorFilter: const ColorFilter.mode(Colors.green, BlendMode.srcIn),
                  child: Image.asset(
                    ImageAssets.docSelected,
                    height: AppSize.s24,
                  ),
                ),
                label: AppStrings.transactions.tr,
              ),
              NavigationDestination(
                icon: Image.asset(
                  ImageAssets.donateHeart,
                  height: AppSize.s24,
                ),
                selectedIcon: ColorFiltered(
                  colorFilter: const ColorFilter.mode(Colors.green, BlendMode.srcIn),
                  child: Image.asset(
                    ImageAssets.selectedDonateHeart,
                    height: AppSize.s24,
                  ),
                ),
                label: AppStrings.donations.tr,
              ),
              NavigationDestination(
                icon: Image.asset(
                  ImageAssets.profile,
                  height: AppSize.s24,
                ),
                selectedIcon: ColorFiltered(
                  colorFilter: const ColorFilter.mode(Colors.green, BlendMode.srcIn),
                  child: Image.asset(
                    ImageAssets.profileSelected,
                    height: AppSize.s24,
                  ),
                ),
                label: AppStrings.profile.tr,
              ),
            ],
            selectedIndex: layoutController.currentPageIndex.value,
            indicatorColor: Colors.transparent,
            onDestinationSelected: (int index) {
              layoutController.currentPageIndex.value = index;
            },
          ),
        ),
        body: Obx(
          () => IndexedStack(
            index: layoutController.currentPageIndex.value,
            children: screens,
          ),
        ),
      ),
    );
  }
}
