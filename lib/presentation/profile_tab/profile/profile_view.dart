import 'package:life_pulse/app/app.dart';
import 'package:life_pulse/presentation/layout/layout_view.dart';
import 'package:life_pulse/presentation/resources/index.dart';
import 'package:life_pulse/presentation/widgets/button.dart';
import 'package:life_pulse/presentation/widgets/empty_state_place_holder.dart';
import '../../widgets/setting_tile.dart';
import '../../widgets/switch.dart';
import 'profile_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final profileController = Get.find<ProfileController>(tag: "ProfileController");

  bool isLightMode = false;
  @override
  void initState() {
    super.initState();
    isLightMode = isDarkMode();
  }
  @override
  Widget build(BuildContext context) {
    return isGuest() ?
      Scaffold(
        body: GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, Routes.letsInRoute);
          },
          child:  EmptyStateHolder(
              image: ImageAssets.profile,
              description: AppStrings.logInHint.tr
          ),
        ),
      ):
      Scaffold(
      appBar: ApplicationToolbar(
      leading: ImageAssets.leadingLogo,
      title: AppStrings.profile.tr,
        actions: const [
          SizedBox.shrink(),
        ],
      ),

     body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: AppSize.s48,
                backgroundColor: ColorManager.lightPrimary,
                child: Obx(
                    ()=> ClipRRect(
                      borderRadius: BorderRadius.circular(AppSize.s48),
                      child:
                      Image.network(
                          AppStrings.baseUrl+(profileController.studentImage.value),
                        height: double.infinity,
                        width: double.infinity,
                      fit: BoxFit.cover,
                      )
                    ),
                ),
              ),
              GestureDetector(
                onTap: (){
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s8),
                    color: ColorManager.primary,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(AppPadding.p4),
                    child: Icon(
                      Icons.edit,
                      size: AppSize.s18,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: AppMargin.m16,),

          Obx(
            ()=> Text(
              profileController.studentName.value,
              style: getSemiBoldStyle(
                  color: Get.textTheme.displayLarge!.color!,
                  fontSize: FontSize.s26
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          Obx(
            ()=> Text(
              profileController.studentEmail.value,
              style: getLightStyle(
                  color: Get.textTheme.displayLarge!.color!,
                  fontSize: FontSize.s16),
            ),
          ),

          SizedBox(height: AppMargin.m16,),

          Padding(
            padding: EdgeInsets.symmetric(vertical: AppPadding.p8,),
            child: Divider(
              height: AppSize.s2,
              thickness: AppSize.s02,
              endIndent: AppPadding.p16,
              indent: AppPadding.p16,
            ),
          ),

          SettingTile(
            icon: ImageAssets.profile,
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


          /// Notifications
          // SettingTile(
          //   icon: ImageAssets.notification,
          //   title: AppStrings.notifications.tr,
          //   onTap: () {
          //     Navigator.pushNamed(context, Routes.notificationsSettingsRoute);
          //   },
          //   trailing: Icon(
          //     Icons.arrow_forward_ios_rounded,
          //     color: Theme.of(context).textTheme.displayLarge!.color!,
          //     size: AppSize.s20,
          //   ),
          // ),
          /// Payment
          SettingTile(
            icon: ImageAssets.wallet,
            title: AppStrings.payment.tr,
            onTap: () {  },
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Theme.of(context).textTheme.displayLarge!.color!,
              size: AppSize.s20,
            ),
          ),
          /// Security
          SettingTile(
            icon: ImageAssets.security,
            title: AppStrings.security.tr,
            onTap: () {
              Navigator.pushNamed(context, Routes.securitySettingsRoute);
            },
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Theme.of(context).textTheme.displayLarge!.color!,
              size: AppSize.s20,
            ),
          ),
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
                    profileController.getCurrentLanguageName(context), // Dynamic language name
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
          SettingTile(
            icon: ImageAssets.theme,
            title: AppStrings.darkMode.tr,
            onTap: () {
              ThemeService().switchTheme();
              isLightMode = !isLightMode;
            },
            trailing: StyledSwitch(
              onToggled: (bool isToggled) {
                ThemeService().switchTheme();
                isLightMode = !isLightMode;
              },
              isToggled: isLightMode,
            ),
          ),
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