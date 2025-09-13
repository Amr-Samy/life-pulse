import 'package:life_pulse/presentation/profile_tab/help/help_center_controller.dart';
import 'package:life_pulse/presentation/resources/index.dart';
import 'package:life_pulse/presentation/widgets/input_field.dart';
import '../../widgets/message_item.dart';
import 'package:intl/intl.dart';
class SupportChatView extends StatefulWidget {
  SupportChatView({super.key});

  @override
  State<SupportChatView> createState() => _SupportChatViewState();
}

class _SupportChatViewState extends State<SupportChatView> {
  final _controller = ScrollController();

  final contactUsController = Get.find<ContactUsController>(tag: "ContactUsController");


  @override
  void initState() {
    super.initState();
    contactUsController.getLastTicket();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ApplicationToolbar(
          title: AppStrings.customerService.tr,
          actions: const [
          ],
        ),
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: Obx(
                ()=> ListView.builder(
                  reverse: true,
                  // shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return  MessageItem(
                      title: contactUsController.ticketsList[index].content ?? "",
                      time: DateFormat('dd/MM/yyyy').format(DateTime.parse(contactUsController.ticketsList[index].createdAt ?? "")) ,
                      isSender: (contactUsController.ticketsList[index].createdBy ?? "") != "Student" ?
                      false : true,
                    );
                  },
                  itemCount: contactUsController.ticketsList.length,
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(

                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: Colors.black.withOpacity(0.06))),

                child: Container(
                  padding: EdgeInsets.symmetric(vertical: AppPadding.p8),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(start: AppPadding.p16),
                          child: InputField(
                            controller: contactUsController.message,
                            hintText: AppStrings.sendMessage.tr,
                            inputAction: TextInputAction.send,
                            onSuffixTap: (){},
                            maxLength: 200,
                          ),
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.send,color: ColorManager.primary,),
                          onPressed:() => contactUsController.sendMessage()

                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}