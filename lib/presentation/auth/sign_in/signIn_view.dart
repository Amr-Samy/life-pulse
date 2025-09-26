import 'package:life_pulse/presentation/auth/sign_in/signIn_viewModel.dart';
import 'package:life_pulse/presentation/resources/index.dart';
import 'package:life_pulse/presentation/widgets/button.dart';
import 'package:life_pulse/presentation/widgets/input_field.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {

  @override

  Widget build(BuildContext context) {
    final signInController = Get.put(
        SignInController(),
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
          child: Form(
            key: signInController.formKey,
          child: Column(
            children: [
                SizedBox(height: AppMargin.m20),
                Text(AppStrings.ltya.tr, style: Theme.of(context).textTheme.displayLarge),
                SizedBox(height: AppMargin.m40),
              InputField(
                controller: signInController.mobileTextController,
                prefix: Icon(Icons.phone_android_rounded, size: AppSize.s20),
                hintText: AppStrings.phoneNumber.tr,
                keyboardType: TextInputType.phone,
                inputAction: TextInputAction.next,
                  validator: signInController.validateMobile,
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
                  onFieldSubmitted: (value){
                    signInController.signIn();
                  },
                  suffix: GestureDetector(
                      onTap: (){signInController.isPasswordHidden.value = !signInController.isPasswordHidden.value;},
                    child: Icon(
                      signInController.isPasswordHidden.value ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                      size: AppSize.s20,
                  ),
                ),
                    validator: signInController.validatePassword,
              ),
              ),

              SizedBox(height: AppMargin.m16,),

              Obx(
                  () => CustomButton(
                  onTap: () {
                    signInController.signIn();
                  },
                  textButton: AppStrings.signIn.tr,
                  loading: signInController.isLoading.value,
                ),
              ),

              SizedBox(height: AppMargin.m16,),

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
      ),
    );
  }
}
