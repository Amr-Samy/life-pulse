import 'package:flutter/scheduler.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:life_pulse/presentation/resources/index.dart';
import 'package:life_pulse/presentation/widgets/button.dart';
import 'package:life_pulse/presentation/widgets/dialog.dart';

class ConfirmPaymentView extends StatefulWidget {
  const ConfirmPaymentView({super.key});

  @override
  State<ConfirmPaymentView> createState() => _ConfirmPaymentViewState();
}

class _ConfirmPaymentViewState extends State<ConfirmPaymentView> {
  TextEditingController otpController = TextEditingController();
  RxString code = ''.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: AppSize.s0,
        automaticallyImplyLeading: true,
        title: Text(AppStrings.confirmPayment.tr),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(
                  AppStrings.enterPIN.tr,
                  style: getLightStyle(
                      color: Theme.of(context).textTheme.displayLarge!.color!,
                      fontSize: FontSize.s16),
                ),

                SizedBox(height: AppMargin.m40,),

                Center(
                  //todo fix secure text dot size
                  //todo delay before moving to next box
                  child: VerificationCode(
                    textStyle: getLightStyle(
                        color: Theme.of(context).textTheme.displayLarge!.color!,
                        fontSize: FontSize.s26
                    ),
                    isSecure: true,
                    keyboardType: TextInputType.number,
                    underlineColor: ColorManager.primary,
                    fullBorder: true,
                    length: 4,
                    cursorColor: ColorManager.primary,
                    onCompleted: (String value) {
                      code.value = value;
                    },
                    onEditing: (bool value) {

                    },
                    digitsOnly: true,
                    margin: EdgeInsets.symmetric(horizontal: AppMargin.m8),
                    itemSize: AppSize.s60,
                    underlineUnfocusedColor: ColorManager.lightGrey,
                    underlineWidth: 0.2,
                    fillColor: Theme.of(context).cardColor,
                  ),
                ),


              ],
            ),
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
          loading: false,
          onTap: () async {
            await showDialog<void>(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),

                  ));

          },
          textButton: AppStrings.confirm.tr,
        ),
      ),
    );
  }
}
