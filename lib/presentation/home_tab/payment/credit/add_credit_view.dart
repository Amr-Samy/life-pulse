import 'package:life_pulse/presentation/resources/index.dart';
import 'package:life_pulse/presentation/widgets/bottom_navigation.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class AddCreditView extends StatefulWidget {
   const AddCreditView({super.key});

  @override
  State<AddCreditView> createState() => _AddCreditViewState();
}

class _AddCreditViewState extends State<AddCreditView> {
  // TextEditingController promoController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController cvvCodeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isCvvFocused = false;

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
              shrinkWrap: true,

              children: [

              CreditCardWidget(
              enableFloatingCard: true,
              showBackView: isCvvFocused,
              floatingConfig: FloatingConfig(
                isGlareEnabled: true,
                isShadowEnabled: false,
                shadowConfig: FloatingShadowConfig(
                  offset: const Offset(3, 3),
                  color: ColorManager.black50,
                  blurRadius: 3,
                ),
              ),

              cardHolderName: cardHolderNameController.value.text,
              cardNumber: cardNumberController.value.text,
              expiryDate: expiryDateController.value.text,
              cvvCode: cvvCodeController.value.text,
              isHolderNameVisible: true,
              // cardBgColor: ColorManager.primary,
              onCreditCardWidgetChange: (CreditCardBrand ) {
              },
                cardType: CardType.mastercard,
            ),


                CreditCardForm(
                  formKey: formKey,
                  cardHolderName: cardHolderNameController.text,
                  cardNumber: cardNumberController.text,
                  expiryDate: expiryDateController.text,
                  cvvCode: cvvCodeController.text,
                  // cardNumberKey: cardNumberKey,
                  // cvvCodeKey: cvvCodeKey,
                  // expiryDateKey: expiryDateKey,
                  // cardHolderKey: cardHolderKey,
                  onCreditCardModelChange: (CreditCardModel creditCardModel) {
                    setState(() {
                      cardNumberController.text = creditCardModel.cardNumber;
                      expiryDateController.text = creditCardModel.expiryDate;
                      cardHolderNameController.text = creditCardModel.cardHolderName;
                      cvvCodeController.text = creditCardModel.cvvCode;
                      isCvvFocused = creditCardModel.isCvvFocused;
                    });
                  },
                  obscureCvv: true,
                  obscureNumber: true,
                  isHolderNameVisible: true,
                  isCardNumberVisible: true,
                  isExpiryDateVisible: true,
                  enableCvv: true,
                  cvvValidationMessage: AppStrings.cvvError.tr,
                  dateValidationMessage: AppStrings.expireDateError.tr,
                  numberValidationMessage: AppStrings.cardNumberError.tr,
                  cardNumberValidator: (String? cardNumber){},
                  expiryDateValidator: (String? expiryDate){},
                  cvvValidator: (String? cvv){},
                  cardHolderValidator: (String? cardHolderName){},
                  onFormComplete: () {
                    // callback to execute at the end of filling card data
                  },
                  autovalidateMode: AutovalidateMode.always,
                  disableCardNumberAutoFillHints: false,
                  inputConfiguration:  InputConfiguration(
                    cardNumberDecoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: AppStrings.cardNumber.tr,
                      hintText: 'XXXX XXXX XXXX XXXX',
                    ),
                    expiryDateDecoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: AppStrings.expiryDate.tr,
                      hintText: 'XX/XX',
                    ),
                    cvvCodeDecoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'CVV',
                      hintText: 'XXX',
                    ),
                    cardHolderDecoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: AppStrings.cardHolder.tr,
                    ),

                  ),

                ),

              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigation(
          // text: "${AppStrings.enrollCourse.tr} - \$40",
          text: AppStrings.confirm.tr,
          onTap: (){
            Navigator.pushNamed(context, Routes.confirmPaymentRoute);
          },
        ),

      ),
    );
  }
}
