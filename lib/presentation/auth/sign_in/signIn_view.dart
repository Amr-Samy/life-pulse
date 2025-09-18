// import 'package:google_sign_in/google_sign_in.dart';
import 'package:life_pulse/presentation/auth/sign_in/signIn_viewModel.dart';
import 'package:life_pulse/presentation/resources/index.dart';
import 'package:life_pulse/presentation/widgets/button.dart';
import 'package:life_pulse/presentation/widgets/divider.dart';
import 'package:life_pulse/presentation/widgets/icon_button.dart';
import 'package:life_pulse/presentation/widgets/input_field.dart';

import '../../../data/network/api.dart';
import '../../resources/helpers/storage.dart';
import 'auth_strategy.dart';
import 'factory/auth_factory.dart';


class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {

  @override

  Widget build(BuildContext context) {
    final signInController = Get.put(
        SignInController(
          authFactory: AuthenticationFactory(
            Api(), // Your API instance
            // GoogleSignIn(), // Your GoogleSignIn instance
          ),
          secureStorage: TokenStorage(), // Your secure storage instance
        ),
        tag: "SignInController"
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: AppSize.s0,
        automaticallyImplyLeading: true,
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: AppMargin.m20,),

              Text(AppStrings.ltya.tr,style: Theme.of(context).textTheme.displayLarge,),

              SizedBox(height: AppMargin.m40,),

              InputField(
                controller: signInController.emailTextController,
                prefix: Icon(Icons.email_rounded,size: AppSize.s20),
                hintText: AppStrings.email.tr,
                keyboardType: TextInputType.emailAddress,
                inputAction: TextInputAction.next,
              ),

              SizedBox(height: AppMargin.m16,),

              Obx(
                ()=> InputField(
                  controller: signInController.passwordTextController,
                  prefix: Icon(Icons.lock,size: AppSize.s20),
                  hintText: AppStrings.password.tr,
                  keyboardType: TextInputType.text,
                  enableOptions: false,
                  isTextHidden: signInController.isPasswordHidden.value,
                  suffix: GestureDetector(
                      onTap: (){signInController.isPasswordHidden.value = !signInController.isPasswordHidden.value;},
                      child: Icon(Icons.visibility_off_rounded,size: AppSize.s20)
                  ),
                ),
              ),

              SizedBox(height: AppMargin.m16,),

              Obx(
                  () => CustomButton(
                  onTap: () {
                    signInController.signInWithEmail();
                  },
                  textButton: AppStrings.signIn.tr,
                  loading: signInController.isLoading.value,
                ),
              ),

              SizedBox(height: AppMargin.m16,),

              GestureDetector(
                onTap: signInController.goToForgotPassword,
                child: Center(
                  child: Text(
                    AppStrings.forgot.tr,
                    style: getSemiBoldStyle(
                        color: ColorManager.primary,
                        fontSize: FontSize.s16),
                  ),
                ),
              ),

              SizedBox(height: AppMargin.m40,),

              CustomDivider(text: AppStrings.continueWith.tr,),

              SizedBox(height: AppMargin.m20,),
              /// Social Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconButton(
                    icon: ImageAssets.facebook,
                    onTap: () {
                      signInController.signInWithFacebook();
                    },
                  ),
                  CustomIconButton(
                    icon: ImageAssets.google,
                    onTap: () {
                      signInController.signInWithGoogle();
                    },
                  ),
                  CustomIconButton(
                    icon:  isDarkMode()? ImageAssets.apple : ImageAssets.darkApple,
                    onTap: () {
                    },
                  ),
                ],
              ),

              SizedBox(height: AppMargin.m20,),

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
                  SizedBox(width: AppPadding.p8,),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, Routes.signUpRoute);
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
            ],
          ),
        ),
      ),
    );
  }
}
