import 'package:get/get.dart';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:life_pulse/data/network/api.dart';
import 'package:life_pulse/presentation/resources/helpers/functions.dart';
import '../../resources/validation_manager.dart';
import '../model/transaction_model.dart';
import 'package:life_pulse/presentation/resources/strings_manager.dart';

class TransactionsController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxMap<String, List<TransactionModel>> groupedTransactions = <String, List<TransactionModel>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    if (!isGuest()) fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    try {
      isLoading(true);
      final response = await Api().get('wallet/transactions');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final transactions = transactionsResponseFromJson(response.toString()).data;
        _groupTransactions(transactions);
      } else {
        showErrorSnackBar(message: AppStrings.failedToLoadTransactions.tr);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching transactions: $e');
      }
      showErrorSnackBar(message: AppStrings.errorFetchingTransactions.tr);
    } finally {
      isLoading(false);
    }
  }

  void _groupTransactions(List<TransactionModel> transactions) {
    final data = SplayTreeMap<String, List<TransactionModel>>();
    final now = DateTime.now();

    for (var transaction in transactions) {
      String groupKey;
      if (transaction.createdAt.year == now.year && transaction.createdAt.month == now.month) {
        groupKey = AppStrings.thisMonth.tr;
      } else {
        groupKey = DateFormat('MMM yyyy').format(transaction.createdAt);
      }

      data.putIfAbsent(groupKey, () => []).add(transaction);
    }

    groupedTransactions.value = Map.fromEntries(data.entries.toList().reversed);
  }
}
