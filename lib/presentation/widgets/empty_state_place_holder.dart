import 'package:life_pulse/presentation/resources/index.dart';
class EmptyStateHolder extends StatelessWidget {
  final String image, description;
  final double? height;
  const EmptyStateHolder({
    super.key, required this.image, required this.description, this.height,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? MediaQuery.of(context).size.height / 1.3,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                image,
                height: 100,
                color:  ColorManager.primary
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              description,
              textAlign: TextAlign.center,
              style: getBoldStyle(
                  color: Theme.of(context).textTheme.displayLarge!.color!,
                  fontSize: FontSize.s20),
            ),
          ],
        ),
      ),
    );
  }
}