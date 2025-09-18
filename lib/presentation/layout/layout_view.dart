
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:life_pulse/presentation/home_tab/home/home_view.dart';
import 'package:life_pulse/presentation/layout/layout_controller.dart';
import 'package:life_pulse/presentation/profile_tab/profile/profile_controller.dart';
import 'package:life_pulse/presentation/profile_tab/profile/profile_view.dart';
import 'package:life_pulse/presentation/resources/index.dart';
import 'package:life_pulse/presentation/transations_tab/transactions_view.dart';

class LayoutView extends StatefulWidget {
  LayoutView({super.key});
  @override
  State<LayoutView> createState() => _LayoutViewState();
}
class _LayoutViewState extends State<LayoutView> {
  final layoutController = Get.put(LayoutController(),tag: "LayoutController");
  List<Widget> screens = [
    const HomeView(),
    const TransactionsScreen(),
    const ProfileView(),
  ];
  final profileController = Get.put(
      ProfileController(
        // googleSignIn: GoogleSignIn(
        //   scopes: ['email', 'https://www.googleapis.com/auth/userinfo.profile'],
        //   serverClientId: AppStrings.serverClientId,
        // ),
      ),
      tag: "ProfileController"
  );
  @override
  void initState() {
    super.initState();
    // isGuest() ?(){} : profileController.getStudentData();

  }

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      //back button disabled
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: Obx(
          ()=> NavigationBar(
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

         ()=> IndexedStack(
            index: layoutController.currentPageIndex.value,
            children: screens,
          ),
        ),

      ),
    );
  }
}
