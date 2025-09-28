import '../../../resources/index.dart';

class GuestLoginPromptWidget extends StatelessWidget {
  const GuestLoginPromptWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      decoration: BoxDecoration(
          color: const Color(0xFFE3FDE7),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.green.shade100, width: 1.5)
      ),
      child: Row(
        children: [
          Image.asset(
            ImageAssets.profileSelected,
            width: AppSize.s40,
            color: Colors.green.shade800,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.joinOurCommunity.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.green.shade900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppStrings.loginPromptMessage.tr,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Icon(Icons.arrow_forward_ios, color: Colors.green.shade800, size: 16),
        ],
      ),
    );
  }
}