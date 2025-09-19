import 'package:life_pulse/presentation/resources/index.dart';
import 'package:life_pulse/presentation/widgets/button.dart';

class LetsInView extends StatelessWidget {
  const LetsInView({super.key});
  @override
  Widget build(BuildContext context) {
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
              height: MediaQuery.of(context).size.height * .5,
            ),
            Center(
              child: Text(AppStrings.let.tr,style: Theme.of(context).textTheme.displayLarge,),
            ),

            SizedBox(
              height: AppMargin.m40,
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
