import '../../../resources/index.dart';
import '../../donation/donation_screen.dart';

class CampaignInfoCard extends StatelessWidget {
  const CampaignInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleAndOrganizer(),
          const SizedBox(height: 16),
          _buildProgressIndicator(),
          const SizedBox(height: 8),
          _buildFundingDetails(),
          const SizedBox(height: 20),
          _buildDonatorAvatars(),
          const SizedBox(height: 20),
          _buildTags(),
          const SizedBox(height: 20),
          _buildDonateButton(),
        ],
      ),
    );
  }

  Widget _buildTitleAndOrganizer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Donation for Child',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text('By ', style: TextStyle(color: Colors.grey[600])),
            Text(
              'Unesco',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.verified, color: Colors.teal, size: 16),
          ],
        ),
      ],
    );
  }

  Widget _buildProgressIndicator() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: const LinearProgressIndicator(
        value: 0.8,
        minHeight: 10,
        backgroundColor: Color(0xFFE0E0E0),
        valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
      ),
    );
  }

  Widget _buildFundingDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 14, color: Colors.black87),
            children: const [
              TextSpan(
                text: '\$8,000 ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: 'fund raised from \$10,000'),
            ],
          ),
        ),
        Text(
          '10 days left',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrangeAccent,
          ),
        ),
      ],
    );
  }

  Widget _buildDonatorAvatars() {
    return Row(
      children: [
        Stack(
          children: List.generate(
            3,
                (index) => Padding(
              padding: EdgeInsets.only(left: index * 20.0),
              child: CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=${index + 1}'),
              ),
            ),
          ),
        ),
        const SizedBox(width: 80),
        Text(
          '+12,300 people donated',
          style: TextStyle(color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildTags() {
    return Row(
      children: [
        _buildTag('Emergencies', Icons.flash_on),
      ],
    );
  }

  Widget _buildTag(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[700]),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildDonateButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Get.to(() => const DonationScreen());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1DE9B6),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          'Donate Now',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}