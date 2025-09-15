import '../../../resources/index.dart';

class CampaignHeader extends StatelessWidget {
  const CampaignHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 220.0,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 1,
      leading: Center(
        child: GestureDetector(
          onTap: () { Get.back(); },
            child: _buildCircularButton(Icons.arrow_back)
        ),
      ),
      actions: [
        _buildCircularButton(Icons.share_outlined),
        const SizedBox(width: 8),
        _buildCircularButton(Icons.favorite_border),
        const SizedBox(width: 16),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          'https://i.imgur.com/O6P02yR.jpeg',
          fit: BoxFit.cover,
          color: Colors.black.withOpacity(0.3),
          colorBlendMode: BlendMode.darken,
        ),
      ),
    );
  }

  Widget _buildCircularButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 22),
    );
  }
}