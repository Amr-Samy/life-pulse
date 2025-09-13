import '../resources/index.dart';
import 'package:intl/intl.dart';
class MessageItem extends StatelessWidget {
  final String title;
  final String time;
  final bool isSender;
  const MessageItem({
    super.key, required this.title, required this.time, required this.isSender,
  });
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(time);
    String formattedTime = DateFormat('HH:mm').format(dateTime.toLocal());

    return Align(
      alignment: isSender? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsetsDirectional.all(AppPadding.p8),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.66,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:isSender? ColorManager.primaryGradient :
              isDarkMode() ? ColorManager.darkGreyGradient :
              ColorManager.greyGradient,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(isSender? AppSize.s8 : AppSize.s0),
              topEnd: Radius.circular(isSender?AppSize.s0 : AppSize.s8),
              bottomStart: Radius.circular(AppSize.s8),
              bottomEnd: Radius.circular(AppSize.s8),
            ),
          ),
          padding: EdgeInsets.symmetric(
              vertical: AppPadding.p8,
              horizontal: AppPadding.p8
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: getLightStyle(
                  color: isSender? ColorManager.white : isDarkMode()? ColorManager.white : ColorManager.black,
                  fontSize: FontSize.s14,
                ),
                textAlign: TextAlign.start,
                softWrap: true,

              ),

              IntrinsicWidth(
                child: Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: Text(
                    formattedTime,
                    style: getLightStyle(
                      color:isSender? ColorManager.white.withOpacity(0.6):
                            Colors.grey,
                      fontSize: FontSize.s12,
                    ),
                    textAlign: TextAlign.start,
                    softWrap: true,

                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
