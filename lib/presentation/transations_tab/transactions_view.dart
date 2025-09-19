import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:life_pulse/presentation/transations_tab/widgets/search_bar_widget.dart';
import 'package:life_pulse/presentation/transations_tab/widgets/section_header_widget.dart';
import 'package:life_pulse/presentation/transations_tab/widgets/transaction_list_item_widget.dart';
import '../resources/assets_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/validation_manager.dart';
import '../widgets/empty_state_place_holder.dart';
import 'transactions_controller.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final TransactionsController controller = Get.put(TransactionsController());
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom App Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  const Text(
                    'Transactions',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Search Bar
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: SearchBarWidget(),
            ),
            // Transaction List
            Expanded(
              child: Obx(() {
                if (controller.groupedTransactions.isEmpty) {
                  return const Center(child: Text("No transactions found."));
                }
                // Using ListView.builder for performance
                return ListView.builder(
                  itemCount: controller.groupedTransactions.keys.length,
                  itemBuilder: (context, index) {
                    final String month =
                    controller.groupedTransactions.keys.elementAt(index);
                    final transactions = controller.groupedTransactions[month]!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionHeaderWidget(title: month),
                        // Using ListView.separated to add dividers
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(), // Important for nested lists
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