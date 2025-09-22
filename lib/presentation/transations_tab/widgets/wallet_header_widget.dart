import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../resources/assets_manager.dart';
import '../controllers/wallet_controller.dart';


class WalletHeaderWidget extends StatelessWidget {
  const WalletHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final WalletController controller = Get.find<WalletController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const SizedBox(
          height: 120,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      if (controller.wallet.value == null) {
        return const SizedBox(
          height: 120,
          child: Center(child: Text('Could not load wallet data.')),
        );
      }

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(

          color: const Color(0xFFF1F8E9),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      ImageAssets.wallet,
                      width: 24,
                      color: Colors.green.shade700,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Current Balance',
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "${controller.wallet.value!.balance.toStringAsFixed(2)} EGP",
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            ElevatedButton(
              onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                'Top up',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      );
    });
  }
}