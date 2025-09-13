
import 'package:life_pulse/presentation/resources/index.dart';
import 'package:life_pulse/presentation/widgets/empty_state_place_holder.dart';
import 'package:life_pulse/presentation/widgets/transaction_item.dart';
class TransactionsView extends StatefulWidget {
  const TransactionsView({super.key});
  @override
  State<TransactionsView> createState() => _TransactionsViewState();
}
class _TransactionsViewState extends State<TransactionsView> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return isGuest() ?
      Scaffold(
        body: GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, Routes.letsInRoute);
          },
          child: EmptyStateHolder(
              image: ImageAssets.profile,
              description: AppStrings.logInHint.tr
          ),
        ),
      ):
      Scaffold(
      appBar: ApplicationToolbar(
        leading: ImageAssets.leadingLogo,
        title: AppStrings.transactions.tr,
        actions:  const [],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: AppPadding.p16,left: AppPadding.p16,right: AppPadding.p16),
        child: Obx(
          ()=>
          // ListView.separated(
          //   shrinkWrap: true,
          //   itemCount: enrollmentController.transactionsList.length,
          //   itemBuilder: (context, index) => TransactionItem(
          //     image: enrollmentController.transactionsList[index].course?.imageUrl ??"",
          //     title: enrollmentController.transactionsList[index].course?.name ??"",
          //     tags: [enrollmentController.transactionsList[index].status ??"",],
          //     onTap: () {
          //       //TODO if paid
          //       enrollmentController.getReceipt(enrollmentController.transactionsList[index].id ??0);
          //       Navigator.pushNamed(context, Routes.receiptRoute);
          //     },
          //   ),
          //   separatorBuilder: (context, index) =>
          //       SizedBox(height: AppPadding.p16),
          // ) :
           EmptyStateHolder(image: ImageAssets.buy,description: AppStrings.empty.tr),
        ),
      ),
    );
  }
}