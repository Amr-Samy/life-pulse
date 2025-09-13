import 'package:life_pulse/presentation/resources/index.dart';
import 'package:life_pulse/presentation/widgets/button.dart';
import 'package:life_pulse/presentation/widgets/tag.dart';

class TransactionItem extends StatefulWidget {
  final String image;
  final String title;
  final List<String> tags;
  final Function() onTap;

  const TransactionItem({
    super.key,
    required this.image,
    required this.title,
    required this.tags,
    required this.onTap,
  });

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  isDarkMode(){
    return Theme.of(context).cardColor == ColorManager.lightDark ? true : false;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: AppSize.s150,
      padding: EdgeInsetsDirectional.only(
          start: AppPadding.p24,
          top: AppPadding.p16,
          bottom: AppPadding.p16,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s16)),
      ),
      child: Row(
        children: [
          //Image
          Container(
            width: AppSize.s80,
            height: AppSize.s80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s16),
                color: const Color(0xffbdbdbd)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s16),
              child: Image.network(
                widget.image,
                width: AppSize.s80,
                height: AppSize.s80,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Expanded(
            // width: MediaQuery.of(context).size.width * .38,
            child: Padding(
              padding: EdgeInsetsDirectional.only(start: AppPadding.p16,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [


                  Text(
                    widget.title,
                    style: getRegularStyle(
                        color: Get.textTheme.displayLarge!.color!,
                        fontSize: FontSize.s20),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 2,
                  ),

                  SizedBox(height: AppPadding.p8,),

                  Row(
                    children: [
                      Tag(title: widget.tags[0]),
                    ],
                  ),

                ],
              ),
            ),
          ),

          FittedBox(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: AppPadding.p8,),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    // width: AppSize.s250,
                    height: AppSize.s40,
                    child: IntrinsicWidth(
                      child: CustomButton(
                        loading: false,
                        textButton: AppStrings.receipt.tr,
                        fontSize: FontSize.s14,
                        color:  ColorManager.primary,
                        onTap: widget.onTap,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
