import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:life_pulse/data/network/api.dart';
import 'package:life_pulse/presentation/resources/helpers/functions.dart';
import '../model/wallet_model.dart';

class WalletController extends GetxController {
  final RxBool isLoading = true.obs;
  final Rx<Wallet?> wallet = Rx<Wallet?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchWalletData();
  }

  Future<void> fetchWalletData() async {
    print("fetchWalletData!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    try {
      // isLoading(true);
      final response = await Api().get('wallet/');

      if (response.statusCode == 200 && response.data['success'] == true) {
        wallet.value = Wallet.fromJson(response.data['data']);
      } else {
        showErrorSnackBar(message: 'Failed to load wallet data.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching wallet data: $e');
      }
    } finally {
      isLoading(false);
    }
  }
}