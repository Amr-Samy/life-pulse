import 'package:life_pulse/presentation/resources/index.dart';
import 'package:life_pulse/presentation/widgets/popup_menu_item.dart';
import 'package:life_pulse/presentation/widgets/receipt_row_item.dart';
import 'package:life_pulse/presentation/widgets/tag.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
class ReceiptView extends StatefulWidget {
  const ReceiptView({super.key});
  @override
  State<ReceiptView> createState() => _ReceiptViewState();
}
class _ReceiptViewState extends State<ReceiptView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: true,

        title: Text(
          AppStrings.receipt.tr,
          style: getBoldStyle(
              color: Theme.of(context).textTheme.displayLarge!.color!,
              fontSize: FontSize.s20),
        ),

        actions: [
          PopupMenuButton<dynamic>(
            elevation: AppSize.s05,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(AppSize.s16),
              ),
            ),
            position: PopupMenuPosition.under,
            itemBuilder: (BuildContext context) => [

              PopupMenuItem(
                onTap: (){
                  //TODO URL LAUNCHER
                },
                child: PopUpMenuItem(icon: ImageAssets.send, title: AppStrings.shareReceipt.tr,),
              ),

              const PopupMenuDivider(),

              PopupMenuItem(
                onTap: (){
                },
                child: PopUpMenuItem(icon: ImageAssets.paperDownload, title: AppStrings.downloadReceipt.tr,),
              ),

              const PopupMenuDivider(),

              PopupMenuItem(
                onTap: (){
                },
                child: PopUpMenuItem(icon: ImageAssets.doc, title: AppStrings.print.tr,),
              ),

            ],
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
              child: Image.asset(
                ImageAssets.more,
                width: AppSize.s24,
                height:AppSize.s24,
                fit: BoxFit.fitWidth,
                color: Get.textTheme.displayLarge!.color!,
              ),
            ),
          ),
        ],
      ),

      body: Obx(
        ()=>
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: AppPadding.p16,left: AppPadding.p16,right: AppPadding.p16),
            child: Column(
              children: [

                //TODO generate barcode and em-bade the url
                Image.asset(
                  ImageAssets.barcode,
                  // width: AppSize.s24,
                  // height:AppSize.s24,
                  // fit: BoxFit.fitWidth,
                  color: Theme.of(context).textTheme.displayLarge!.color!,
                ),

              // BarcodeWidget(
              //   // barcode: Barcode.ean8(drawSpacers: true),
              //   barcode: Barcode.qrCode(),
              //   data: enrollmentController.receiptModel?.paymentTransactionDetails?.barcodeUrl ?? "",
              // ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p24,vertical: AppPadding.p24),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.all(Radius.circular(AppSize.s16)),
                    ),
                  child: Column(
                    children: [
                      ReceiptRowItem(
                        text: AppStrings.course.tr,
                        value: "",
                      ),
                      ReceiptRowItem(
                        text: AppStrings.category.tr,
                        value: "",
                      ),
                    ],
                  ),
                ),

                SizedBox(height: AppSize.s16,),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p24,vertical: AppPadding.p24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.all(Radius.circular(AppSize.s16)),
                  ),
                  child: Column(
                    children: [
                      ReceiptRowItem(
                        text: AppStrings.name.tr,
                        value: "",
                      ),
                      ReceiptRowItem(
                        text: AppStrings.phone.tr,
                        value: "",
                      ),
                      ReceiptRowItem(
                        text: AppStrings.email.tr,
                        value: "",
                      ),
                      //Country
                      // ReceiptRowItem(text: AppStrings.country.tr, value: 'Egypt',),
                    ],
                  ),
                ),

                SizedBox(height: AppSize.s16,),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p24,vertical: AppPadding.p24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.all(Radius.circular(AppSize.s16)),
                  ),
                  child: Column(
                    children: [
                      ReceiptRowItem(
                        text: AppStrings.price.tr,
                        value: '\$${""}',
                      ),
                      ReceiptRowItem(
                        text: AppStrings.paymentMethod.tr
                        , value: "",
                      ),
                      // ReceiptRowItem(text: AppStrings.promoCode.tr, value: 'GET10% OFF',),
                      ReceiptRowItem(
                        text: AppStrings.date.tr,
                        value: formatDate("2024-02-14T11:48:08.436Z"),
                      ),

                      ReceiptRowItem(
                        text: AppStrings.transactionId.tr,
                        value:  "",
                        trailing: Padding(
                          padding: EdgeInsetsDirectional.only(start: AppPadding.p8),
                          child: GestureDetector(
                            onTap: () async {
                              await Clipboard.setData(
                                  ClipboardData(
                                      text: ""
                                  )
                              ).then((_){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(AppStrings.transactionIdCopied.tr),
                                      backgroundColor: ColorManager.success,
                                    )
                                );
                              });
                            },
                            child: Image.asset(
                              ImageAssets.copy,
                              width: AppSize.s24,
                              height:AppSize.s24,
                              fit: BoxFit.fitWidth,
                              color: ColorManager.primary,
                            ),
                          ),
                        ),
                      ),

                      ReceiptRowItem(
                        text: AppStrings.status.tr,
                        value: '',
                        trailing: Tag(title:  ""),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: AppSize.s16,),

              ],
            ),
          ),
        ),
      ),

    );
  }
}

String formatDate(String dateString ){
  DateTime date = DateTime.parse(dateString);
  return DateFormat("MMM d, yyyy | HH:mm:ss a").format(date);
}