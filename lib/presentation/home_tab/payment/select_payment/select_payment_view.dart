
import 'package:life_pulse/presentation/resources/index.dart';
import 'package:life_pulse/presentation/widgets/bottom_navigation.dart';
import 'package:life_pulse/presentation/widgets/input_field.dart';
import 'package:life_pulse/presentation/widgets/radio_card.dart';
class SelectPaymentView extends StatefulWidget {
  const SelectPaymentView({super.key});

  @override
  State<SelectPaymentView> createState() => _SelectPaymentViewState();
}

class _SelectPaymentViewState extends State<SelectPaymentView> with TickerProviderStateMixin {

  // int? selectedItem = 0;
  TextEditingController promoController = TextEditingController();
  int? selectedRadioTile;
  int? selectedRadio;
  bool isCardVisible = true;
  bool isInputVisible = false;

  // late final AnimationController _controller = AnimationController(
  //   duration: const Duration(seconds: 1),
  //   vsync: this,
  // );
  // late final Animation<double> _animation = CurvedAnimation(
  //     parent: _controller,
  //     curve: Curves.easeIn,
  // );
  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadio = val;
      selectedRadioTile = val;
    });
  }

  showPromoInput() {
    setState(() {
      isCardVisible = !isCardVisible;
      isInputVisible = !isInputVisible;
      // _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(

        appBar: AppBar(
          automaticallyImplyLeading: true,

          title: Text(
            AppStrings.selectPayment.tr,
            style: getBoldStyle(
                color: Theme.of(context).textTheme.displayLarge!.color!,
                fontSize: FontSize.s20),
          ),
        ),

        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: SizedBox(
            height: MediaQuery.of(context).size.height *1,
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              shrinkWrap: true,

              children: [

                Text(
                  AppStrings.selectPaymentDescription.tr,
                  style: getLightStyle(
                      color: Theme.of(context).textTheme.displayLarge!.color!,
                      fontSize: FontSize.s16),
                ),

                SizedBox(height: AppMargin.m20,),

                MyRadioListTile<int>(
                  value: 0,
                  groupValue: selectedRadioTile!,
                  leading: ImageAssets.payPal,
                  title: 'PayPal',
                  leadingWidth: AppSize.s28,
                  leadingHeight: AppSize.s28,
                  onChanged: (value) => setState(() => selectedRadioTile = value!),
                  showRadio: true,
                ),

                SizedBox(height: AppMargin.m20,),

                MyRadioListTile<int>(
                  value: 1,
                  groupValue: selectedRadioTile!,
                  leading: ImageAssets.google,
                  title: 'Google Pay',
                  leadingWidth: AppSize.s28,
                  leadingHeight: AppSize.s28,
                  onChanged: (value) => setState(() => selectedRadioTile = value!),
                  showRadio: true,

                ),

                SizedBox(height: AppMargin.m20,),

                MyRadioListTile<int>(
                  value: 2,
                  groupValue: selectedRadioTile!,
                  leading: isDarkMode()? ImageAssets.apple : ImageAssets.darkApple,
                  title: 'Apple Pay ',
                  leadingWidth: AppSize.s28,
                  leadingHeight: AppSize.s28,
                  onChanged: (value) => setState(() => selectedRadioTile = value!),
                  showRadio: true,

                ),

                SizedBox(height: AppMargin.m20,),

                //TODO save card if it was used successfully before
                MyRadioListTile<int>(
                  value: 3,
                  groupValue: selectedRadioTile!,
                  leading: ImageAssets.credit,
                  title: 'Credit Card',
                  leadingWidth: AppSize.s28,
                  leadingHeight: AppSize.s28,
                  onChanged: (value) => setState(() => selectedRadioTile = value!),
                  showRadio: true,

                ),

                SizedBox(height: AppMargin.m40,),

                SizedBox(
                  height: MediaQuery.of(context).size.height *.1,
                ),

                //? Promo Code//
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: isCardVisible?  ListTile(
                    tileColor: Theme.of(context).cardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s16),
                    ),
                    visualDensity: const VisualDensity( vertical: -2),
                    horizontalTitleGap: 0,
                    dense: true,
                    minVerticalPadding: 0,
                    leading: Padding(
                      padding: EdgeInsets.only(top: AppPadding.p12,bottom:AppPadding.p4 ),
                      child: Image.asset(
                        ImageAssets.promo ,
                        width: AppSize.s32,
                        height: AppSize.s32,
                        color: Theme.of(context).textTheme.displayLarge?.color,
                      ),
                    ),

                    title: Text(
                      AppStrings.applyPromotion.tr,
                      style: getLightStyle(
                          color: Theme.of(context).textTheme.displayLarge!.color!,
                          fontSize: FontSize.s14),
                    ),
                    subtitle:  Text(
                      AppStrings.applyPromotionDescription.tr,
                      style: getRegularStyle(
                          color: ColorManager.grey1,
                          fontSize: FontSize.s12
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Theme.of(context).textTheme.displayLarge!.color!,
                    ),
                    onTap: ()=> showPromoInput(),
                  ) :
                  InputField(
                    controller: promoController,
                    maxLength: 12,
                    contentPadding: 22,
                    prefix: Padding(
                      padding: EdgeInsets.all(AppPadding.p12),
                      child: Image.asset(
                          ImageAssets.promo ,
                          width: AppSize.s1,
                          height: AppSize.s1,
                          fit: BoxFit.fitWidth,
                        color: Theme.of(context).textTheme.displayLarge?.color,
                      ),
                    ),
                    hintText: AppStrings.enterPromoCode.tr,
                    keyboardType: TextInputType.text,
                    suffix: Padding(
                      padding: EdgeInsets.all(AppPadding.p16),
                      child: GestureDetector(
                        onTap: (){

                        },
                        child: Text(
                          AppStrings.apply.tr,
                          style: getSemiBoldStyle(
                              color: ColorManager.primary,
                              fontSize: FontSize.s14),
                        ),
                      ),
                    ),
                    onFieldSubmitted: (text){

                    },
                  ),
                ),

              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigation(
          text: "${AppStrings.enrollCourse.tr}",
          onTap: (){
            if (selectedRadioTile == 3) {
              Navigator.pushNamed(context, Routes.addCreditRoute);
            }
          },
        ),

      ),
    );
  }
}
