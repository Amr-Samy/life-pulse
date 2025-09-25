import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:life_pulse/presentation/resources/strings_manager.dart';
import 'package:life_pulse/presentation/transations_tab/presentation/pin_code_view.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../controllers/wallet_controller.dart';
import '../presentation/top_up_screen.dart';

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
        return SizedBox(
          height: 120,
          child: Center(child: Text(AppStrings.couldNotLoadWalletData.tr)),
        );
      }

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: ColorManager.lightGreenColor,
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
                      color: Colors.green,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      AppStrings.currentBalance.tr,
                      style: TextStyle(color: Colors.green, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "${controller.wallet.value!.balance.toStringAsFixed(2)}${AppStrings.egpCurrency.tr}",
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => const VerificationScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text(
                AppStrings.topUp.tr,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      );
    });
  }
}
