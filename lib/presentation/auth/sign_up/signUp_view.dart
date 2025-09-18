// import 'package:google_sign_in/google_sign_in.dart';
import 'package:life_pulse/presentation/auth/sign_up/signUp_strategy.dart';
import 'package:life_pulse/presentation/auth/sign_up/signUp_viewmodel.dart';
import 'package:life_pulse/presentation/resources/index.dart';
import 'package:life_pulse/presentation/widgets/button.dart';
import 'package:life_pulse/presentation/widgets/divider.dart';
import 'package:life_pulse/presentation/widgets/icon_button.dart';
import 'package:life_pulse/presentation/widgets/input_field.dart';

import '../../../data/network/api.dart';
import 'factory/registration_factory.dart';


class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final signUpController = Get.put(SignUpController(
    registrationFactory: RegistrationFactory(
      Api(),
      // GoogleSignIn(),
    ),
  ));
  @override
  Widget build(BuildContext context) {


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
              SizedBox(
                height: AppMargin.m20,
              ),

              Text(AppStrings.createAccount.tr,style: Theme.of(context).textTheme.displayLarge,),


              SizedBox(
                height: AppMargin.m20,
              ),

              SizedBox(
                height: AppMargin.m16,
              ),

              InputField(
                controller: signUpController.emailTextController,
                prefix: Icon(Icons.email_rounded,size: AppSize.s20),
                hintText: AppStrings.email.tr,
                keyboardType: TextInputType.emailAddress,
                inputAction: TextInputAction.next,
              ),

              SizedBox(height: AppMargin.m16,),

              Obx(
                ()=> InputField(
                  controller: signUpController.passwordTextController,
                  prefix: Icon(Icons.lock,size: AppSize.s20),
                  hintText: AppStrings.password.tr,
                  keyboardType: TextInputType.text,
                  enableOptions: false,
                  isTextHidden: signUpController.isPasswordHidden.value,
                  suffix: GestureDetector(
                      onTap: (){signUpController.isPasswordHidden.value = !signUpController.isPasswordHidden.value;},
                      child: Icon(Icons.visibility_off_rounded,size: AppSize.s20)
                  ),
                ),
              ),

              // Center(
              //   child: IntrinsicWidth(
              //     child: StatefulBuilder(
              //         builder: (context,StateSetter stateUpdater) {
              //           return CheckboxListTile(
              //             splashRadius: AppSize.s0,
              //             title: Text(AppStrings.rememberMe.tr),
              //             visualDensity: const VisualDensity(horizontal: AppPadding.pNegative4),
              //             value: signUpController.checkedValue,
              //             onChanged: (newValue) { stateUpdater(() {
              //               print(newValue);
              //               signUpController.checkedValue = !signUpController.checkedValue;
              //             }); },
              //             controlAffinity: ListTileControlAffinity.leading,
              //             checkboxShape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(AppSize.s5),
              //             ),
              //             side: BorderSide(color: ColorManager.primary,width: AppSize.s2,style: BorderStyle.solid),
              //           );
              //         }
              //     ),
              //   ),
              // ),

              //todo disabled color

              SizedBox(height: AppMargin.m40,),


              Obx(
                    () => CustomButton(
                  onTap: () {
                    signUpController.signUpWithEmail();
                  },
                  textButton: AppStrings.signUp.tr,
                  loading: signUpController.isLoading.value,
                ),
              ),

              SizedBox(height: AppMargin.m40,),

              CustomDivider(text: AppStrings.continueWith.tr,),

              SizedBox(height: AppMargin.m20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconButton(
                    icon: ImageAssets.facebook,
                    onTap: () {
                      signUpController.signUpWithFacebook();
                    },
                  ),
                  CustomIconButton(
                    icon: ImageAssets.google,
                    onTap: () {
                      signUpController.signUpWithGoogle();
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
                    AppStrings.alreadyHave.tr,
                    style: getLightStyle(
                        color: Theme.of(context).textTheme.displayLarge!.color!,
                        fontSize: FontSize.s14
                    ),
                  ),
                  SizedBox(width: AppPadding.p8,),

                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, Routes.signInRoute);
                    },
                    child: Text(
                      AppStrings.signIn.tr,
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
