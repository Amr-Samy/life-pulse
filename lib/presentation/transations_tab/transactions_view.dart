import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:life_pulse/presentation/transations_tab/widgets/section_header_widget.dart';
import 'package:life_pulse/presentation/transations_tab/widgets/transaction_list_item_widget.dart';
import 'package:life_pulse/presentation/transations_tab/widgets/wallet_header_widget.dart';
import '../resources/assets_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/validation_manager.dart';
import '../widgets/empty_state_place_holder.dart';
import 'controllers/transactions_controller.dart';
import 'controllers/wallet_controller.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TransactionsController transactionsController = Get.put(TransactionsController());
    Get.put(WalletController());

    return
    isGuest() ?
    Scaffold(
      body: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, Routes.letsInRoute);
        },
        child:  EmptyStateHolder(
            image: ImageAssets.profile,
            description: AppStrings.logInHint.tr
        ),
      ),
    ):
     Scaffold(
      backgroundColor: const Color(0xFFF8FDF7),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 25,
        title: const Text(
          'Transactions',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WalletHeaderWidget(),
            Expanded(
              child: Obx(() {
                if (transactionsController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (transactionsController.groupedTransactions.isEmpty) {
                  return const Center(child: Text("No transactions found."));
                }
                return ListView.builder(
                  itemCount: transactionsController.groupedTransactions.keys.length,
                  itemBuilder: (context, index) {
                    final String month =
                        transactionsController.groupedTransactions.keys.elementAt(index);
                    final transactions =
                        transactionsController.groupedTransactions[month]!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionHeaderWidget(title: month),
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: transactions.length,
                          itemBuilder: (context, itemIndex) {
                            return TransactionListItemWidget(
                                transaction: transactions[itemIndex]);
                          },
                          separatorBuilder: (context, index) => const Divider(
                            height: 1,
                            indent: 16,
                            endIndent: 16,
                          ),
                        ),
                      ],
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}