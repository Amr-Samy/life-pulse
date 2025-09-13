import 'package:life_pulse/presentation/resources/index.dart';
import 'package:life_pulse/presentation/widgets/invite_friend_item.dart';
class InviteFriendsView extends StatelessWidget {
  const InviteFriendsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: ApplicationToolbar(
        title: AppStrings.inviteFriends.tr,
        actions: [
          SizedBox.shrink(),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p16,),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) => InviteFriendItem(
              image: "",
              name: "",
              phone: '+1-300-555-0135',
              isInvited: index % 2 ==0 ? true : false,
              onTap: () {  },
            ),
            separatorBuilder: (context, index) =>
                SizedBox(height: AppPadding.p16),
          ),
        ),
      ),
    );
  }
}


