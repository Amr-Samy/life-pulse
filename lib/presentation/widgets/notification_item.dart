import 'package:life_pulse/presentation/resources/index.dart';

class NotificationItem extends StatelessWidget {
  final String? subtitle;
  final String type;
  final Function() onTap;

  const NotificationItem({

    this.subtitle,
    required this.type,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s16),
            color: Theme.of(context).cardColor,
        ),
        child: Row(

          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p8, vertical: AppPadding.p16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                      ImageAssets.iconContainer ,
                      width: AppSize.s80,height: AppSize.s80,
                    color:
                    type == 'CourseEnrollmentNotification'? ColorManager.primary :
                    type == 'offer'? ColorManager.secondary:
                    type == 'new'? ColorManager.error:
                    type == 'SuccessfulRegistrationNotification'? ColorManager.success :
                    ColorManager.success , //Default Notification Icon
                  ),

                  Image.asset(
                    type == 'CourseEnrollmentNotification'? ImageAssets.payment :
                          type == 'offer'?ImageAssets.offer :
                          type == 'new'?ImageAssets.category :
                          type == 'SuccessfulRegistrationNotification'?ImageAssets.account :
                          ImageAssets.payment , //Default Notification Icon
                          width: AppSize.s24,height: AppSize.s24,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (subtitle != null)
                  SizedBox(
                    width: AppSize.s300,
                    child: Text(
                      subtitle!,
                      style: getRegularStyle(
                          color: Theme.of(context).textTheme.displayLarge!.color!,
                          fontSize: FontSize.s16),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}