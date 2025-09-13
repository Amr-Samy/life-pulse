import 'package:life_pulse/presentation/resources/index.dart';
import 'package:life_pulse/presentation/widgets/button.dart';
import 'package:life_pulse/presentation/widgets/setting_tile.dart';
import 'package:life_pulse/presentation/widgets/switch.dart';

class SecuritySettingsView extends StatefulWidget {
  const SecuritySettingsView({super.key});

  @override
  State<SecuritySettingsView> createState() => _SecuritySettingsViewState();
}

class _SecuritySettingsViewState extends State<SecuritySettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: ApplicationToolbar(
        title: AppStrings.security.tr,
        actions: [
          SizedBox.shrink(),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            SettingTile(
              title: AppStrings.rememberMe.tr,
              onTap: () {  },
              trailing: StyledSwitch(
                onToggled: (bool isToggled) {
                },
                isToggled: true,
              ),
            ),

            SizedBox(height: AppPadding.p16,),

            // SettingTile(
            //   title: AppStrings.faceID.tr,
            //   onTap: () {  },
            //   trailing: StyledSwitch(
            //     onToggled: (bool isToggled) {
            //     },
            //     isToggled: false,
            //   ),
            // ),


            // SettingTile(
            //   title: AppStrings.biometricID.tr,
            //   onTap: () {  },
            //   trailing: StyledSwitch(
            //     onToggled: (bool isToggled) {
            //     },
            //     isToggled: true,
            //   ),
            // ),

            // SettingTile(
            //   title: 'Google Authenticator',
            //   onTap: () {
            //
            //   },
            //   trailing: Icon(
            //     Icons.arrow_forward_ios_rounded,
            //     color: ColorManager.primary,
            //     size: AppSize.s20,
            //   ),
            // ),

            // Padding(
            //   padding:  EdgeInsets.symmetric(vertical: AppPadding.p16),
            //   child: CustomButton(
            //     loading: false,
            //     textButton: AppStrings.changePIN.tr,
            //     textColor: ColorManager.primary,
            //     color:  isDarkMode() ? ColorManager.dark3 : ColorManager.blueTransparent.withOpacity(0.15),
            //     onTap: (){
            //       // Navigator.pop(context);
            //       print(isDarkMode().toString());
            //     },
            //   ),
            // ),


            CustomButton(
              loading: false,
              textButton: AppStrings.changePassword.tr,
              textColor: ColorManager.primary,
              color: isDarkMode() ? ColorManager.dark3 :  ColorManager.blueTransparent.withOpacity(0.15),
              onTap: (){
                Navigator.pop(context);
              },
            ),


          ],
        ),
      ),

    );
  }
}
