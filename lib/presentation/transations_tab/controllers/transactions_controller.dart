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
  final RxBool isLoadingMore = false.obs;
  final RxList<TransactionModel> transactions = <TransactionModel>[].obs;

  int _currentPage = 1;
  int? _lastPage;

  Map<String, List<TransactionModel>> get groupedTransactions {
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

    return Map.fromEntries(data.entries.toList().reversed);
  }


  @override
  void onInit() {
    super.onInit();
    if (!isGuest()) {
      fetchTransactions(isRefresh: true);
    }
  }

  Future<void> fetchTransactions({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 1;
      _lastPage = null;
      isLoading(true);
    }

    if (isLoadingMore.value || (_lastPage != null && _currentPage > _lastPage!)) {
      return;
    }

    if (!isRefresh) {
      isLoadingMore(true);
    }

    try {
      final response = await Api().get('wallet/transactions?page=$_currentPage');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final transactionsResponse = transactionsResponseFromJson(response.toString());
        final newTransactions = transactionsResponse.data;
        _lastPage = transactionsResponse.meta.lastPage;

        if (isRefresh) {
          transactions.clear();
        }

        transactions.addAll(newTransactions);
        _currentPage++;
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
      isLoadingMore(false);
    }
  }

  Future<void> loadMore() async {
    await fetchTransactions();
  }
}