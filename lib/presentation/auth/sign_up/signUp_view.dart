import 'package:life_pulse/presentation/auth/sign_up/signUp_viewmodel.dart';
import 'package:life_pulse/presentation/resources/index.dart';
import 'package:life_pulse/presentation/widgets/button.dart';
import 'package:life_pulse/presentation/widgets/input_field.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final signUpController = Get.put(SignUpController());

  @override
  void dispose() {
    Get.delete<SignUpController>();
    super.dispose();
  }
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
          child: Form(
            key: signUpController.formKey,
          child: Column(
            children: [
               SizedBox(height: AppMargin.m20),
              Text(AppStrings.createAccount.tr, style: Theme.of(context).textTheme.displayLarge),
               SizedBox(height: AppMargin.m20),

              // Name
              InputField(
                controller: signUpController.nameTextController,
                prefix:  Icon(Icons.person_outline_rounded, size: AppSize.s20),
                hintText: AppStrings.name.tr,
                keyboardType: TextInputType.name,
                inputAction: TextInputAction.next,
                  validator: signUpController.validateName,
              ),
               SizedBox(height: AppMargin.m16),

              // Email
              InputField(
                controller: signUpController.emailTextController,
                prefix:  Icon(Icons.email_outlined, size: AppSize.s20),
                hintText: AppStrings.email.tr,
                keyboardType: TextInputType.emailAddress,
                inputAction: TextInputAction.next,
                  validator: signUpController.validateEmail,
              ),
               SizedBox(height: AppMargin.m16),

              InputField(
                controller: signUpController.mobileTextController,
                prefix:  Icon(Icons.phone_android_rounded, size: AppSize.s20),
                hintText: AppStrings.phoneNumber.tr,
                keyboardType: TextInputType.phone,
                inputAction: TextInputAction.next,
                  validator: signUpController.validateMobile,
              ),

              SizedBox(height: AppMargin.m16,),

              Obx(
                ()=> InputField(
                  controller: signUpController.passwordTextController,
                  prefix:  Icon(Icons.lock_outline_rounded, size: AppSize.s20),
                  hintText: AppStrings.password.tr,
                  keyboardType: TextInputType.text,
                  enableOptions: false,
                  isTextHidden: signUpController.isPasswordHidden.value,
                  suffix: GestureDetector(
                    onTap: () {
                      signUpController.isPasswordHidden.value = !signUpController.isPasswordHidden.value;
                    },
                    child: Icon(
                      signUpController.isPasswordHidden.value ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                      size: AppSize.s20,
                    ),
                  ),
                    validator: signUpController.validatePassword,
                ),
              ),
               SizedBox(height: AppMargin.m16),

              // Confirm Password
              Obx(
                () => InputField(
                  controller: signUpController.passwordConfirmationTextController,
                  prefix: Icon(Icons.lock_outline_rounded, size: AppSize.s20),
                  hintText: AppStrings.confirmPassword.tr,
                  keyboardType: TextInputType.text,
                  enableOptions: false,
                  isTextHidden: signUpController.isPasswordConfirmationHidden.value,
                  suffix: GestureDetector(
                    onTap: () {
                      signUpController.isPasswordConfirmationHidden.value = !signUpController.isPasswordConfirmationHidden.value;
                    },
                    child: Icon(
                      signUpController.isPasswordConfirmationHidden.value ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                      size: AppSize.s20,
                  ),
                ),
                    validator: signUpController.validateConfirmPassword,
              ),
              ),
                SizedBox(height: AppMargin.m40),
              Obx(
                    () => CustomButton(
                  onTap: () {
                    signUpController.register();
                  },
                  textButton: AppStrings.signUp.tr,
                  loading: signUpController.isLoading.value,
                ),
              ),
                SizedBox(height: AppMargin.m40),
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
                    SizedBox(width: AppPadding.p8),
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
      ),
    );
  }
}
