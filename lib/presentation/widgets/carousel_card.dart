import 'package:life_pulse/presentation/resources/index.dart';

class CarouselCard extends StatelessWidget {
  Color? cardColor = ColorManager.primary;
  final String title, description,discountValue;
  CarouselCard(
      {Key? key,
        required this.title,
        required this.description,
        required this.discountValue,
        this.cardColor,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: cardColor,
          image: const DecorationImage(
            image: ExactAssetImage(ImageAssets.carouselBg),
            fit: BoxFit.cover,
          ),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s32)),
      ),

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal:  AppPadding.p30,vertical: AppPadding.p32),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$discountValue% ${AppStrings.off.tr}',
                      style: getRegularStyle(
                          color: ColorManager.white,
                          fontSize: FontSize.s16
                      ),
                    ),
                    SizedBox(
                      height: AppMargin.m8,
                    ),
                    Text(
                      title,
                      style: getBoldStyle(
                          color: ColorManager.white,
                          fontSize: FontSize.s22
                      ),
                    ),

                  ],
                ),
                Text(
                  '$discountValue%',
                  style: getBoldStyle(
                      color: ColorManager.white,
                      fontSize: FontSize.s50
                  ),
                ),
              ],
            ),

            SizedBox(height: AppMargin.m16,),

            Text(
              description,
              style: getRegularStyle(
                  color: ColorManager.white,
                  fontSize: FontSize.s20
              ),
            ),
          ],
        ),
      ),
    );
  }
}