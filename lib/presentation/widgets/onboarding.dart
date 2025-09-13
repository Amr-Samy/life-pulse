import 'package:life_pulse/presentation/resources/index.dart';

class OnBoardContent extends StatelessWidget {
  OnBoardContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  String image;
  String title;
  String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height * .45,
            child: Image.network(
              AppStrings.baseUrl+image ,
              // fit: BoxFit.fitWidth,
            )),

        Text(
          description,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: FontSize.s30),
        ),
      ],
    );
  }
}