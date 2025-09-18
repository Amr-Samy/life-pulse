import 'package:life_pulse/presentation/resources/index.dart';
import 'package:life_pulse/presentation/widgets/button.dart';
import 'package:life_pulse/presentation/widgets/divider.dart';
import 'package:life_pulse/presentation/widgets/text_icon_button.dart';

import '../../../data/network/api.dart';
import '../../resources/helpers/storage.dart';
import '../sign_in/auth_strategy.dart';
import '../sign_in/factory/auth_factory.dart';
import '../sign_in/signIn_viewModel.dart';

class LetsInView extends StatelessWidget {
  const LetsInView({super.key});
  @override
  Widget build(BuildContext context) {
    // final signInController = Get.put(
    //     SignInController(
    //       authFactory: AuthenticationFactory(
    //         Api(), // Your API instance
    //         GoogleSignIn(
    //           scopes: ['email', 'https://www.googleapis.com/auth/userinfo.profile'],
    //           serverClientId: AppStrings.serverClientId,
    //         ), // Your GoogleSignIn instance
    //       ),
    //       secureStorage: TokenStorage(), // Your secure storage instance
    //     ),
    //     tag: "SignInController"
    // );

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: ListView(
          children: [
            SizedBox(
              height: AppMargin.m20,
            ),
            Image.asset(
              (ImageAssets.onboardingLogo1),
              height: MediaQuery.of(context).size.height * .32,
            ),
            Center(
              child: Text(AppStrings.let.tr,style: Theme.of(context).textTheme.displayLarge,),
            ),

            SizedBox(
              height: AppMargin.m16,
            ),
            TextIconButton(
              icon: ImageAssets.facebook,
              textButton: AppStrings.cwf.tr,
              onTap: () {
                // signInController.signInWithFacebook();
              },
            ),
            ///signInWithGoogle
            TextIconButton(
              icon: ImageAssets.google,
              textButton: AppStrings.cwg.tr,
              onTap: () {
                // signInController.signInWithGoogle();
              },
            ),
            TextIconButton(
              icon:  isDarkMode()? ImageAssets.apple : ImageAssets.darkApple,
              textButton: AppStrings.cwa.tr,
              onTap: () {

              },
            ),

            SizedBox(
              height: AppMargin.m20,
            ),
            //or
            CustomDivider(text: AppStrings.or.tr,),

            SizedBox(
              height: AppMargin.m20,
            ),

            CustomButton(
              loading: false,
              onTap: () {
                Navigator.pushNamed(context, Routes.signInRoute);
              },
              textButton: AppStrings.signWPassword.tr,
            ),

            SizedBox(
              height: AppMargin.m20,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.dontHaveAccount.tr,
                  style: getLightStyle(
                      color: Theme.of(context).textTheme.displayLarge!.color!,
                      fontSize: FontSize.s14
                  ),
                ),
                SizedBox(
                  width: AppPadding.p8,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.signUpRoute);
                  },
                  child: Text(
                    AppStrings.signUp.tr,
                    style: getSemiBoldStyle(
                        color: ColorManager.primary,
                        fontSize: FontSize.s14
                    ),
                  ),
                )
              ],
            ),

            SizedBox(
              height: AppMargin.m20,
            ),
          ],
        ),
      ),
    );
  }
}
