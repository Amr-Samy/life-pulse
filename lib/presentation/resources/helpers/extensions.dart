extension StringExtension on String? {
  bool isNullOrEmpty() => this == null || this == "";
  bool isNotNullOrEmpty() => this != null && this != "";
}

extension ListExtension<T> on List<T>? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}

extension DoubleExtension on double? {
  bool isNotNullOrEmpty() => this != null && this != 0.0;
}