import 'package:life_pulse/presentation/resources/index.dart';
import 'package:life_pulse/presentation/widgets/setting_tile.dart';
import 'package:life_pulse/presentation/widgets/switch.dart';

class NotificationsSettingsView extends StatefulWidget {
  const NotificationsSettingsView({super.key});

  @override
  State<NotificationsSettingsView> createState() => _NotificationsSettingsViewState();
}

class _NotificationsSettingsViewState extends State<NotificationsSettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: ApplicationToolbar(
        title: AppStrings.notifications.tr,
        actions: const [
          SizedBox.shrink(),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            SettingTile(
              title: 'General Notification',
              onTap: () {  },
              trailing: StyledSwitch(
                onToggled: (bool isToggled) {
                },
                isToggled: true,
              ),
            ),

            SettingTile(
              title: 'Sound',
              onTap: () {  },
              trailing: StyledSwitch(
                onToggled: (bool isToggled) {
                },
                isToggled: true,
              ),
            ),


            SettingTile(
              title: 'Vibrate',
              onTap: () {  },
              trailing: StyledSwitch(
                onToggled: (bool isToggled) {
                },
                isToggled: false,
              ),
            ),


            SettingTile(
              title: 'Special Offers',
              onTap: () {  },
              trailing: StyledSwitch(
                onToggled: (bool isToggled) {
                },
                isToggled: true,
              ),
            ),


            SettingTile(
              title: 'Promo & Discount',
              onTap: () {  },
              trailing: StyledSwitch(
                onToggled: (bool isToggled) {
                },
                isToggled: false,
              ),
            ),


            SettingTile(
              title: 'Payments',
              onTap: () {  },
              trailing: StyledSwitch(
                onToggled: (bool isToggled) {
                },
                isToggled: true,
              ),
            ),


            SettingTile(
              title: 'Cashback',
              onTap: () {  },
              trailing: StyledSwitch(
                onToggled: (bool isToggled) {
                },
                isToggled: false,
              ),
            ),


            SettingTile(
              title: 'App Updates',
              onTap: () {  },
              trailing: StyledSwitch(
                onToggled: (bool isToggled) {
                },
                isToggled: true,
              ),
            ),

            SettingTile(
              title: 'New Service Available',
              onTap: () {  },
              trailing: StyledSwitch(
                onToggled: (bool isToggled) {
                },
                isToggled: false,
              ),
            ),


            SettingTile(
              title: 'New Tips Available',
              onTap: () {  },
              trailing: StyledSwitch(
                onToggled: (bool isToggled) {
                },
                isToggled: true,
              ),
            ),


          ],
        ),
      ),

    );
  }
}
