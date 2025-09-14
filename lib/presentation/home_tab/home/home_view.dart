import '../../layout/layout_controller.dart';
import '../../profile_tab/profile/profile_controller.dart';
import '../../resources/index.dart';
import 'controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final profileController = Get.find<ProfileController>(tag: "ProfileController");
  final homeController = Get.put(HomeController(),tag: "HomeController");
  final layoutController = Get.find<LayoutController>(tag: "LayoutController");
  @override
  void initState() {
    super.initState();

  }
  final HomeController controller = Get.put(HomeController());


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: _buildAppBar(),
      body: RefreshIndicator(
        onRefresh: _refresh,
        backgroundColor: Theme.of(context).cardColor,
        color: ColorManager.primary,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: SingleChildScrollView(
            child: Column(
              // shrinkWrap: true,
              // physics: const BouncingScrollPhysics(),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDonationWalletCard(),
                const SizedBox(height: 24),
                _buildFeatureCampaignTitle(),
                const SizedBox(height: 16),
                _buildFeatureCampaignList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _refresh() async {

    return Future.delayed (
      const Duration (seconds: 2),
    );
  }
  Widget _buildFeatureCampaignList() {
    return SizedBox(
      height: 420,
      child: PageView.builder(
        controller: controller.pageController,
        onPageChanged: controller.onPageChanged,
        itemCount: 3,
          itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: controller.pageController,
            builder: (context, child) {
              double value = 0.0;
              if (controller.pageController.position.haveDimensions) {
                value = index.toDouble() - (controller.pageController.page ?? 0);
                value = (value * 0.04).clamp(-1, 1);
              }

              double scale = 1.0 - (value.abs() * 0.25);
              scale = scale.clamp(0.85, 1.0);

              return Transform.rotate(
                angle: value,
                child: Transform.scale(
                  scale: scale,
                  child: child,
                ),
              );
              },
                child: Obx(
                    () {
                bool isSelected = controller.currentCampaignIndex.value == index;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                  child: CampaignCard(isSelected: isSelected),
                );
              },
              ),
            );
          },
        ),
    );
  }

}

AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: ColorManager.lightGreenColor,
      title: Row(
      children: [
        const CircleAvatar(
            radius: 22,
          backgroundImage: AssetImage('assets/images/user_profile.png'),
        ),
        const SizedBox(width: 12),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, Mr Dat',
              style: TextStyle(
                  fontSize: 18,
                fontWeight: FontWeight.bold,
                  color: Colors.black87,
              ),
            ),
            Text(
              'Donated \$150K',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 13,
                ),
              ),
            ],
            ),
          ],
        ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search, size: 28),
          color: Colors.black54,
        ),
        const SizedBox(width: 8),
      ],
  );
}

/// Builds the green donation wallet card
Widget _buildDonationWalletCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: ColorManager.lightGreenColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.wallet_travel, color: Colors.green),
                  SizedBox(width: 8),
                  Text(
                    'Donation wallet',
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                '\$500.00',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text(
              'Top up',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
  );
}

/// Builds the "Feature Campaign" title
Widget _buildFeatureCampaignTitle() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: Text(
      'Feature Campaign',
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
          color: Colors.black87,
      ),
    ),
  );
}

class CampaignCard extends StatelessWidget {
  final bool isSelected;

  const CampaignCard({
    super.key,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final Color cardColor = isSelected ? const Color(0xFFE8F5E9) : const Color(0xFFE3F2FD);
    final Color borderColor = isSelected ? Colors.green : Colors.blue;
    final Color authorColor = isSelected ? Colors.green : Colors.blue;

    return Container(
      width: 300,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
            ),
            child: Image.asset(
              'assets/images/boarding/boarding1.png',
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                const Text(
                  'Donation for Child',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                // verified by ( case sponsor )
                Row(
                  children: [
                    const Text('By', style: TextStyle(color: Colors.grey)),
                    const SizedBox(width: 4),
                      Text(
                        'Unesco',
                        style: TextStyle(color: authorColor, fontWeight: FontWeight.bold),
                      ),
                    const SizedBox(width: 4),
                      Icon(Icons.check_circle, color: authorColor, size: 16),
                  ],
                ),
                const SizedBox(height: 12),
                // progress bar
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: 0.5, // 50% progress
                        backgroundColor: Colors.grey.shade300,
                          color: authorColor,
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      '50%',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // donors
                Row(
                  children: [
                    // Stacked donor avatars
                    SizedBox(
                      width: 70,
                      child: Stack(
                        children: [
                          _buildDonorAvatar('assets/images/donor1.png'),
                          Positioned(left: 20, child: _buildDonorAvatar('assets/images/donor2.png')),
                          Positioned(left: 40, child: _buildDonorAvatar('assets/images/donor3.png')),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        '+12,300 people donated',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Divider(color: Colors.grey.shade200),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.folder_open, 'Emergencies'),
              ],
            ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDonorAvatar(String imagePath) {
    return CircleAvatar(
      radius: 15,
      backgroundImage: AssetImage(imagePath),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 16),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}






