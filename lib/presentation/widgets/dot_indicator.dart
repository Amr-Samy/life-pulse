import 'package:life_pulse/presentation/resources/index.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
    this.color,
  });

  final bool isActive;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? ColorManager.primary : Colors.grey,
        // border: isActive ? null : Border.all(color: ColorManager.primary),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: isActive? ColorManager.primaryGradient : ColorManager.greyGradient,
        // tileMode: TileMode.clamp,
        ),
    ),
    );
  }
}