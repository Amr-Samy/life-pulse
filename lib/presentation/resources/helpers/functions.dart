import 'package:get_storage/get_storage.dart';

import '../index.dart';
import 'package:intl/intl.dart';

Future<DateTime?> selectDate(BuildContext context,
    {DateTime? initialDateRange}) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: initialDateRange,
    firstDate: initialDateRange?.subtract(const Duration(days: 1)) ??
        DateTime(2000, 1, 1),
    lastDate: DateTime.now().add(const Duration(days: 365)),
    locale: isArabic() ? const Locale("ar") : const Locale("en"),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: Theme.of(context).cardColor,
            onPrimary:
            isDarkMode() ? ColorManager.secondary : ColorManager.primary,
            onSurface: isDarkMode()
                ? ColorManager.orangeTransparent
                : ColorManager.darkPrimary,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                foregroundColor: isDarkMode()
                    ? ColorManager.lightSecondary
                    : ColorManager.lightPrimary,
                backgroundColor: ColorManager.primary.withOpacity(0.15),
                elevation: 2,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
        child: child!,
      );
    },
  );
  // if (picked != null && picked != selectedDate) {
  //   selectedDate = picked;
  //   dateTextController.text = "${selectedDate.start.year.toString()}-${selectedDate.start.month.toString().padLeft(2,'0')}-${selectedDate.start.day.toString().padLeft(2,'0') } To ${selectedDate.end.year.toString()}-${selectedDate.end.month.toString().padLeft(2,'0')}-${selectedDate.end.day.toString().padLeft(2,'0')}";
  // }
  return picked;
}

Future<DateTime?> pickTime(BuildContext context,
    [TimeOfDay? initialTime]) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: initialTime ?? TimeOfDay.now(),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: isDarkMode()
              ? ColorScheme.dark(
            primary: ColorManager.secondary,
            onPrimary: ColorManager.secondary,
            onSurface: ColorManager.lightSecondary,
          )
              : ColorScheme.light(
            primary: ColorManager.primary,
            onPrimary: ColorManager.primary,
            onSurface: ColorManager.lightPrimary,
          ),
          //text theme
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                foregroundColor: ColorManager.primary,
                backgroundColor: ColorManager.primary.withOpacity(0.15),
                elevation: 2,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
        child: child!,
      );
    },
  );

  if (picked != null) {
    // Combine the picked time with today's date
    final now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      picked.hour,
      picked.minute,
    );
  }
  return null; // Return null if no time is picked
}

///converts DateTime to a Date String ex: yyyy-MM-dd HH:mm
String formatDateTimeToString(DateTime dateTime) {
  // Create a DateFormat instance with the desired format
  DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');
  // Format the DateTime object to a string
  return dateFormat.format(dateTime);
}

String durationToHours(int minutes) {
  var d = Duration(minutes: minutes);
  List<String> parts = d.toString().split(':');
  return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
}
void showErrorSnackBar({
  String? title,
  required String message,
  IconData? icon,
  SnackPosition? position,
  Color? color,
}) {
  Get.closeAllSnackbars();
  Get.showSnackbar(
    GetSnackBar(
      title: title,
      message: message,
      icon: Icon(icon ?? Icons.warning_amber_rounded),
      duration: const Duration(seconds: AppConstants.errorMessageTime),
      backgroundColor: color ?? ColorManager.error,
      snackPosition: position ?? SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
    ),
  );
}

void showSuccessSnackBar({
  String? title,
  required String message,
  SnackPosition? position,
  Color? color,
  IconData? icon,
}) {
  Get.showSnackbar(GetSnackBar(
    title: title,
    message: message,
    icon: Icon(
        icon ?? Icons.check_circle_outline_rounded), // Icons.check_outlined
    duration: const Duration(seconds: 3),
    backgroundColor: color ?? Colors.green,
    snackPosition: position ?? SnackPosition.TOP,
    margin: const EdgeInsets.all(16),
    borderRadius: 8,
    animationDuration: const Duration(milliseconds: 300),
  ));
}


isDarkMode() {
  return Theme.of(Get.context!).cardColor == ColorManager.lightDark
      ? true
      : false;
  // final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
  // return brightness == getApplicationTheme('light').brightness ? false :  true ;
}

bool isArabic() {
final storage = GetStorage();
  if(storage.read("language_code")==null){
    return false;
}
  return storage.read("language_code").toString() == "ar";
}

String extractYoutubeVideoId(String url) {
  Uri uri = Uri.parse(url);
  return uri.queryParameters["v"] ?? "";
}

void showFullScreenImage(String imageUrl) {
  Get.dialog(
  Dialog(
    backgroundColor: Colors.transparent,
    insetPadding: const EdgeInsets.all(20),
    child: InteractiveViewer(
      panEnabled: true,
      minScale: 0.1,
      maxScale: 4.0,
      child: Image.network(imageUrl),
    ),
    ),
  );
}