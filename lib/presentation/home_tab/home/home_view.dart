import 'dart:math' as math;

import 'package:life_pulse/presentation/home_tab/campaign_details/campaign_details_screen.dart';
import 'package:life_pulse/presentation/home_tab/home/widgets/quick_donation_sheet_view.dart';

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

  final List<String> latestCampaignImages = [
    'assets/images/boarding/boarding3.png',
    'assets/images/boarding/boarding3.png',
    'assets/images/boarding/boarding3.png',
    'assets/images/boarding/boarding3.png',
  ];

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
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
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
                const SizedBox(height: 24),
                _buildLatestCampaigns(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Quick Donation",
        onPressed: () {
          showQuickDonationSheet(context);
        },
        backgroundColor: ColorManager.primary,
        child: Image.asset(
          ImageAssets.quick,
          width: AppSize.s32,
          color: Colors.white,
        )
      ),
    );
  }

  Future<void> _refresh() async {

    return Future.delayed (
      const Duration (seconds: 2),
    );
  }
  Widget _buildFeatureCampaignList() {
  const int itemCount = 3;
  const double screenPadding = 0.0;
  const double cardSpacing = 46.0;

    return SizedBox(
    height: 480,
      child: PageView.builder(
        controller: controller.pageController,
        onPageChanged: controller.onPageChanged,
      itemCount: itemCount,
          itemBuilder: (context, index) {
        final double leftPadding = (index == 0) ? screenPadding : (cardSpacing / 2);
        final double rightPadding = (index == itemCount - 1) ? screenPadding : (cardSpacing / 2);

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
              angle: math.pi * value,
                child: Transform.scale(
                  scale: scale,
                  child: child,
                ),
              );
              },
          child: Padding(
            padding: EdgeInsets.only(left: leftPadding, right: rightPadding, top: 20, bottom: 20),
                child: Obx(
                    () {
                bool isSelected = controller.currentCampaignIndex.value == index;
              return CampaignCard(isSelected: isSelected);
            }),
              ),
            );
          },
        ),
    );
  }

  Widget _buildLatestCampaigns() {
  List<Widget> _buildGridRows() {
    List<Widget> rows = [];
    for (int i = 0; i < latestCampaignImages.length; i += 2) {
      Widget card1 = LatestCampaignCard(
        imagePath: latestCampaignImages[i],
      );
      Widget card2;
      if (i + 1 < latestCampaignImages.length) {
        card2 = LatestCampaignCard(
          imagePath: latestCampaignImages[i + 1],
        );
      } else {
        card2 = Expanded(child: Container());
      }

      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: card1),
            const SizedBox(width: 16),
            Expanded(child: card2),
          ],
        ),
      );

      if (i + 2 < latestCampaignImages.length) {
        rows.add(const SizedBox(height: 16));
      }
    }
    return rows;
  }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Latest Campaign',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
        Column(
          children: _buildGridRows(),
          ),
        ],
      ),
    );
  }

  void showQuickDonationSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return const DonationBottomSheet();
      },
    );
  }
}

AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: ColorManager.lightGreenColor,
      automaticallyImplyLeading: false,
      titleSpacing: 25,
      title: Row(
      children: [
        const CircleAvatar(
            radius: 22,
          backgroundImage: AssetImage('assets/images/boarding/boarding3.png'),
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
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    ImageAssets.wallet,
                    width: AppSize.s24,
                    color: Colors.green,
                  ),
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

    return GestureDetector(
      onTap: () {
        Get.to(CampaignDetailsScreen());
      },
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.asset(
                'assets/images/boarding/boarding1.png',
                height: 150,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
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
                      SizedBox(
                        width: 70,
                        child: Stack(
                          children: [
                            _buildDonorAvatar('assets/images/boarding/boarding3.png'),
                            Positioned(left: 20, child: _buildDonorAvatar('assets/images/boarding/boarding3.png')),
                            Positioned(left: 40, child: _buildDonorAvatar('assets/images/boarding/boarding3.png')),
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
          ],
        ),
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


class LatestCampaignCard extends StatelessWidget {
  final String imagePath;

  const LatestCampaignCard({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(CampaignDetailsScreen());
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.asset(
                    imagePath,
                      height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      shape: BoxShape.circle,
                    ),
                      child: const Icon(Icons.favorite_border, color: Colors.black54, size: 18),
                  ),
                ),
              ],
            ),

              Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Donation for Child',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                    const Row(
                    children: [
                        Text('By', style: TextStyle(color: Colors.grey, fontSize: 12)),
                        SizedBox(width: 4),
                        Text('Unesco', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
                        SizedBox(width: 4),
                      Icon(Icons.check_circle, color: Colors.green, size: 14),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Text('Raised', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Spacer(),
                      Text('50%',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 2),
                  LinearProgressIndicator(
                    value: 0.5,
                    backgroundColor: Colors.grey.shade300,
                    color: Colors.green,
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                          SizedBox(
                          width: 50,
                          height: 20,
                            child: Stack(
                              children: [
                                _buildDonorAvatar('assets/images/boarding/boarding3.png'),
                                Positioned(left: 12, child: _buildDonorAvatar('assets/images/boarding/boarding3.png')),
                                Positioned(left: 24, child: _buildDonorAvatar('assets/images/boarding/boarding3.png')),
                              ],
                            ),
                          ),
                      const Expanded(
                        child: Text(
                          '+12,300',
                          style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDonorAvatar(String imagePath) {
    return CircleAvatar(
      radius: 10,
      backgroundColor: Colors.white,
        child: CircleAvatar(
        radius: 9,
          backgroundImage: AssetImage(imagePath),
        ),
    );
  }



}
