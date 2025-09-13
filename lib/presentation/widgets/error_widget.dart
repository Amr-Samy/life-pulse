import 'package:flutter/foundation.dart';
import 'package:life_pulse/presentation/resources/index.dart';

class CustomError extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const CustomError({
    Key? key,
    required this.errorDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                'assets/images/lock.png'),
            Text(
              kDebugMode
                  ? errorDetails.summary.toString()
                  : AppStrings.oops.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: kDebugMode ? Colors.red : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 21),
            ),
            const SizedBox(height: 12),
            Text(
              kDebugMode
                  ? 'https://docs.flutter.dev/testing/errors'
                  : AppStrings.weEncounteredAnError.tr,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: AppSize.s14),
            ),
          ],
        ),
      ),
    );
  }
}