import 'package:get/get.dart';
import 'dart:collection';
import 'package:intl/intl.dart';
import 'model/transaction_model.dart';


class TransactionsController extends GetxController {
  final RxMap<String, List<TransactionModel>> groupedTransactions =
      <String, List<TransactionModel>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTransactions();
  }

  void fetchTransactions() {
    final List<TransactionModel> transactions = [
      TransactionModel(title: "Top up balance", date: DateTime(2024, 4, 8), amount: 250.00, type: TransactionType.credit),
      TransactionModel(title: "Donation for Child", date: DateTime(2024, 4, 8), amount: 250.00, type: TransactionType.debit),
      TransactionModel(title: "Top up balance", date: DateTime(2024, 4, 8), amount: 250.00, type: TransactionType.credit),
      TransactionModel(title: "Donation for Child", date: DateTime(2024, 4, 8), amount: 250.00, type: TransactionType.debit),
      TransactionModel(title: "Top up balance", date: DateTime(2024, 4, 8), amount: 250.00, type: TransactionType.credit),
      TransactionModel(title: "Top up balance", date: DateTime(2024, 3, 20), amount: 250.00, type: TransactionType.credit),
      TransactionModel(title: "Donation for Child", date: DateTime(2024, 3, 15), amount: 250.00, type: TransactionType.debit),
    ];

    // Grouping logic
    final data = SplayTreeMap<String, List<TransactionModel>>();
    final now = DateTime.now();

    for (var transaction in transactions) {
      String groupKey;
      if (transaction.date.year == now.year && transaction.date.month == now.month) {
        groupKey = "This month";
      } else {
        groupKey = DateFormat('MMM yyyy').format(transaction.date);
      }

      if (data[groupKey] == null) {
        data[groupKey] = [];
      }
      data[groupKey]!.add(transaction);
    }

    // Reverse to show "This month" first
    groupedTransactions.value = Map.fromEntries(data.entries.toList().reversed);
  }
}