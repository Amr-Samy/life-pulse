import 'package:life_pulse/presentation/auth/sign_in/signIn_viewModel.dart';
import 'package:life_pulse/presentation/resources/index.dart';
import 'package:life_pulse/presentation/widgets/button.dart';
import 'package:life_pulse/presentation/widgets/input_field.dart';
class NewPasswordView extends StatefulWidget {
  const NewPasswordView({super.key});

  @override
  State<NewPasswordView> createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends State<NewPasswordView> {
  final signInController = Get.find<SignInController>(tag: "SignInController");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: AppSize.s0,
        automaticallyImplyLeading: true,
        title: Text(AppStrings.createNewPassword.tr),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppMargin.m16,),

              Center(
                child: Image.asset(
                  ImageAssets.newPassword,
                  width: MediaQuery.of(context).size.width * 0.65,
                ),
              ),

              SizedBox(height: AppMargin.m40,),

              Text(
                AppStrings.createYourNewPassword.tr,
                style: getLightStyle(
                    color: Theme.of(context).textTheme.displayLarge!.color!,
                    fontSize: FontSize.s18),
              ),

              SizedBox(height: AppMargin.m20,),

              Obx(
                    ()=> InputField(
                      controller: signInController.newPasswordController,
                      prefix: Icon(Icons.lock,size: AppSize.s20),
                      hintText: AppStrings.password.tr,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      enableOptions: false,
                      isTextHidden: signInController.isNewPasswordHidden.value,
                      suffix: GestureDetector(
                      onTap: (){signInController.isNewPasswordHidden.value = !signInController.isNewPasswordHidden.value;},
                      child: Icon(Icons.visibility_off_rounded,size: AppSize.s20)
                  ),

                ),
              ),

              SizedBox(height: AppMargin.m20,),

              Obx(
                    ()=> InputField(
                  controller: signInController.confirmPasswordController,
                  prefix: Icon(Icons.lock,size: AppSize.s20),
                  hintText: AppStrings.password.tr,
                  keyboardType: TextInputType.text,
                      inputAction: TextInputAction.next,
                  enableOptions: false,
                  isTextHidden: signInController.isConfirmPasswordHidden.value,
                  suffix: GestureDetector(
                      onTap: (){signInController.isConfirmPasswordHidden.value = !signInController.isConfirmPasswordHidden.value;},
                      child: Icon(Icons.visibility_off_rounded,size: AppSize.s20)
                  ),
                ),
              ),

              Center(
                child: IntrinsicWidth(
                  child: StatefulBuilder(
                      builder: (context,StateSetter stateUpdater) {
                        return CheckboxListTile(
                          title: Text(AppStrings.rememberMe.tr,
                            style: getLightStyle(
                                color: Theme.of(context).textTheme.displayLarge!.color!,
                                fontSize: FontSize.s16),
                          ),
                          visualDensity: const VisualDensity(horizontal: AppPadding.pNegative4),
                          value: signInController.newPasswordRememberValue.value,
                          onChanged: (newValue) { stateUpdater(() {
                            print(newValue);
                            signInController.newPasswordRememberValue.value = !signInController.newPasswordRememberValue.value;
                          }); },
                          controlAffinity: ListTileControlAffinity.leading,
                          checkboxShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSize.s5),
                          ),
                          side: BorderSide(color: ColorManager.primary,width: AppSize.s2,style: BorderStyle.solid),
                        );
                      }
                  ),
                ),
              ),

            ],
          ),
        ),
      ),

      bottomSheet:  Padding(
        padding: EdgeInsets.only(
          left: AppPadding.p16,
          right: AppPadding.p16,
          bottom: AppPadding.p16,
        ),
        child: CustomButton(
          loading: signInController.isLoading.value,
          onTap:  signInController.updatePasswordAndSignIn,
          textButton: AppStrings.continueOption.tr,
        ),
      ),
    );
  }
}