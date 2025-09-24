import 'package:flutter/foundation.dart';
import 'package:life_pulse/presentation/layout/layout_view.dart';
import 'package:life_pulse/presentation/resources/index.dart';
import 'package:life_pulse/presentation/widgets/button.dart';
import '../../transations_tab/presentation/top_up_screen.dart';
import '../../transations_tab/widgets/wallet_header_widget.dart';
import '../../widgets/empty_state_place_holder.dart';
import '../../widgets/setting_tile.dart';
import '../../widgets/switch.dart';
import '../partners/success_partners_screen.dart';
import 'profile_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the controller instance
  final profileController = Get.find<ProfileController>(tag: "ProfileController");

  return isGuest()
      ? Scaffold(
        body: GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, Routes.letsInRoute);
          },
          child:  EmptyStateHolder(
              image: ImageAssets.profile,
                description: AppStrings.logInHint.tr),
          ),
        )
      : Scaffold(
          body: SingleChildScrollView(
      child: Column(
        children: [

                Obx(() => _ProfileHeader(
                  isAnonymous: profileController.isAnonymous.value,
                  userName: profileController.userName.value,
                  walletBalance: profileController.walletBalance.value,
                    )),

          const SizedBox(height: 24),

          const WalletHeaderWidget(),

          const SizedBox(height: 24),

          SettingTile(
            icon: ImageAssets.editUsers,
            title: AppStrings.editProfile.tr,
            onTap: () {
              Navigator.pushNamed(context, Routes.editProfileRoute);
            },
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Theme.of(context).textTheme.displayLarge!.color!,
              size: AppSize.s20,
            ),
          ),


                Obx(() => SettingTile(
            icon: ImageAssets.anonymous,
            title: AppStrings.anonymous.tr,
            onTap: () {
              profileController.toggleAnonymous(!profileController.isAnonymous.value);
            },
            trailing: StyledSwitch(
                    onToggled: (value) => profileController.toggleAnonymous(value),
                    isToggled: profileController.isAnonymous.value,
            ),
                    )),

          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //   child: _MenuList(
          //     isAnonymous: _isAnonymous,
          //     onAnonymousToggle: (value) {
          //       setState(() {
          //         _isAnonymous = value;
          //       });
          //     },
          //   ),
          // ),


          /// Language
          SettingTile(
            icon: ImageAssets.language,
            title: AppStrings.language.tr,
            onTap: () {
              Navigator.pushNamed(context, Routes.languageSettingsRoute);
            },
            trailing: IntrinsicWidth(
              child: Row(
                children: [
                  Text(
                    profileController.getCurrentLanguageName(context),
                    style: getRegularStyle(
                      color: Theme.of(context).textTheme.displayLarge!.color!,
                      fontSize: FontSize.s16,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Theme.of(context).textTheme.displayLarge!.color!,
                    size: AppSize.s20,
                  ),
                ],
              ),
            ),
          ),
          ///Theme
          // SettingTile(
          //   icon: ImageAssets.theme,
          //   title: AppStrings.darkMode.tr,
          //   onTap: () {
          //     ThemeService().switchTheme();
          //     isLightMode = !isLightMode;
          //   },
          //   trailing: StyledSwitch(
          //     onToggled: (bool isToggled) {
          //       ThemeService().switchTheme();
          //       isLightMode = !isLightMode;
          //     },
          //     isToggled: isLightMode,
          //   ),
          // ),
          /// Terms & Conditions
          SettingTile(
            icon: ImageAssets.locked,
            title: AppStrings.privacyPolicy.tr,
            onTap: () {
              Navigator.pushNamed(context, Routes.privacyPolicyRoute);
            },
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Theme.of(context).textTheme.displayLarge!.color!,
              size: AppSize.s20,
            ),
          ),
          /// Help Center
          SettingTile(
            icon: ImageAssets.info,
            title: AppStrings.helpCenter.tr,
            onTap: () {
              Navigator.pushNamed(context, Routes.helpCenterRoute);
            },
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Theme.of(context).textTheme.displayLarge!.color!,
              size: AppSize.s20,
            ),
          ),

          //Success partners ( Hidden on release )
          if (!kReleaseMode)
            SettingTile(
            icon: ImageAssets.donateHeartFlower,
            title: "شركاء النجاح",
            onTap: () {
              Get.to(SuccessPartnersScreen());
            },
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Theme.of(context).textTheme.displayLarge!.color!,
              size: AppSize.s20,
            ),
          ),

          SettingTile(
            icon: ImageAssets.users,
            title: AppStrings.inviteFriends.tr,
            onTap: () {
              //TODO : share app link

            },
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Theme.of(context).textTheme.displayLarge!.color!,
              size: AppSize.s20,
            ),
          ),
          ///Logout
          ColorFiltered(
            colorFilter: ColorFilter.mode(
                ColorManager.error,
                BlendMode.srcIn
            ),
            child: SettingTile(
              icon: ImageAssets.logout,
              title: AppStrings.logout.tr,
              onTap: () {
                showConfirmationSheet(context);
              },
              trailing: const SizedBox.shrink(),
            ),
          ),


        ],
      ),
    ),

    );
  }

  void showConfirmationSheet(BuildContext context) {

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(AppSize.s32),
          topEnd: Radius.circular(AppSize.s32),
        ),
      ),

      builder: (context) => SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsetsDirectional.only(
            start: AppPadding.p16,
            end: AppPadding.p16,
            bottom: AppPadding.p32,
            top: AppPadding.p8,
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: AppSize.s32,
                height: AppSize.s2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s12),
                  color: isDarkMode()? ColorManager.dark3 : ColorManager.grey,
                ),
              ),

              SizedBox(height: AppPadding.p16),

              Text(AppStrings.logout.tr,
                style: getSemiBoldStyle(
                  color: ColorManager.error,
                  fontSize: FontSize.s20,
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: AppPadding.p16,),
                child: Divider(
                  height: AppSize.s1,thickness: AppSize.s01,
                ),
              ),

              Text(AppStrings.confirmLogout.tr,
                style: getSemiBoldStyle(
                  color: Theme.of(context).textTheme.displayLarge!.color!,
                  fontSize: FontSize.s16,
                ),
              ),

              SizedBox(height: AppPadding.p16),

              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      loading: false,
                      textButton: AppStrings.cancel.tr,
                      textColor: ColorManager.primary,
                      color:  isDarkMode() ? ColorManager.dark3 : ColorManager.blueTransparent.withOpacity(0.15),
                      onTap: (){
                        Navigator.pop(context);
                      },
                    ),
                  ),

                  Expanded(
                    child: CustomButton(
                      loading: false,
                      textButton: AppStrings.yesLogout.tr,
                      onTap: (){
                        final profileController = Get.find<ProfileController>(tag: "ProfileController");
                        profileController.logout();
                        Navigator.of(context).popUntil((route) => false);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LayoutView()),
                        );
                      },
                    ),
                  ),
                ],
              )

            ],
          )),
    );
  }

}

class _ProfileHeader extends StatelessWidget {
  final bool isAnonymous;
  final String userName;
  final String walletBalance;

  const _ProfileHeader({
    required this.isAnonymous,
    required this.userName,
    required this.walletBalance,
  });

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>(tag: "ProfileController");
    return ClipPath(
      clipper: WaveClipper(),
      child: Container(
        height: 220,
        decoration: const BoxDecoration(
          color: Color(0xFFD7F0E3),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/background_pattern.png',
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                         CircleAvatar(
                          radius: 35,
                           backgroundColor: Colors.white,
                      backgroundImage: isAnonymous
                          ? const AssetImage(ImageAssets.anonymous)
                          : (profileController.userImage.value != null && profileController.userImage.value!.isNotEmpty)
                              ? NetworkImage(profileController.userImage.value!)
                              : const AssetImage('assets/images/profile_placeholder.png') as ImageProvider,
                    ),
                    const SizedBox(width: 15),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isAnonymous ? 'Hello, Anonymous' : 'Hello, $userName',
                          style: const TextStyle(
                            color: Color(0xFF1E2F38),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // const SizedBox(height: 4),
                        // if (!isAnonymous)
                        // Text(
                        //     'Donated \$$walletBalance',
                        //   style: TextStyle(
                        //     color: Colors.grey[700],
                        //     fontSize: 14,
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
    Offset(size.width - (size.width / 4), size.height - 60);
    var secondEndPoint = Offset(size.width, size.height - 80);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _DonationWalletCard extends StatelessWidget {
  const _DonationWalletCard();

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>(tag: "ProfileController");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF00C853),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Donation wallet',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Obx(() => Text(
                  'EGP ${profileController.walletBalance.value}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => const TopUpScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('Top up'),
            ),
          ],
        ),
      ),
    );
  }
}
