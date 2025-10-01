import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../resources/strings_manager.dart';
import 'controllers/user_stats_controller.dart';
import 'model/user_stats_model.dart';

class UserStatsScreen extends StatelessWidget {
  const UserStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserStatsController controller = Get.put(UserStatsController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title:  Text(AppStrings.statistics.tr, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.grey.withOpacity(0.1),
        leading: const BackButton(color: Colors.black),
      ),
      body: Obx(() {
        switch (controller.screenState.value) {
          case ScreenState.loading:
            return const Center(child: CircularProgressIndicator(color: Color(0xFF1DB954)));
          case ScreenState.error:
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 50),
                    const SizedBox(height: 16),
                    Text(
                      controller.errorMessage.value,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => controller.fetchUserStats(),
                      child:  Text(AppStrings.retry.tr),
                    )
                  ],
                ),
              ),
            );

          case ScreenState.empty:
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.insights, color: Colors.grey[400], size: 60),
                    const SizedBox(height: 20),
                     Text(
                      AppStrings.noActivityYet.tr,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppStrings.impactReportInfo.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            );

          case ScreenState.success:
            return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
                  _buildTotalDonatedCard(controller.userStats.value!.totalDonated),
            const SizedBox(height: 24),
                  _buildStatsGrid(controller.userStats.value!),
            const SizedBox(height: 24),
                  _buildMonthlyChart(controller.userStats.value!.monthlyDonations),
          ],
        ),
            );
        }
      }),
    );
  }

  Widget _buildTotalDonatedCard(double total) {
    return Card(
      elevation: 2,
      shadowColor: Colors.green.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color(0xFF1DB954),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: Column(
          children: [
            const Icon(Icons.volunteer_activism, color: Colors.white, size: 40),
            const SizedBox(height: 12),
            Text(
              AppStrings.totalDonated.tr,
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              NumberFormat.currency(symbol: '\$').format(total),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid(UserStats stats) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.2,
      children: [
        _buildStatCard(Icons.favorite, '${stats.favoriteCampaignsCount}', AppStrings.favorites.tr, Colors.red.shade100),
        _buildStatCard(Icons.card_giftcard, '${stats.donationsCount}', AppStrings.donationsMade.tr, Colors.blue.shade100),
        _buildStatCard(Icons.add_circle, '${stats.createdCampaignsCount}', AppStrings.campaignsCreated.tr, Colors.orange.shade100),
        _buildStatCard(Icons.account_balance_wallet, NumberFormat.currency(symbol: AppStrings.egp.tr).format(stats.walletBalance), AppStrings.walletBalance.tr, Colors.green.shade100),
      ],
    );
  }

  Widget _buildStatCard(IconData icon, String value, String label, Color color) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: color,
              foregroundColor: Color.alphaBlend(Colors.black.withOpacity(0.6), color),
              radius: 20,
              child: Icon(icon),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  label,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyChart(List<MonthlyDonation> monthlyData) {
    if (monthlyData.isEmpty) {
      return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: 254,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bar_chart_rounded, size: 40, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  Text(AppStrings.noMonthlyDonationData.tr, style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.monthlyActivity.tr,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: (monthlyData.map((d) => d.total).reduce((a, b) => a > b ? a : b) * 1.2),
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          '${DateFormat.MMM().format(DateFormat('yyyy-MM').parse(monthlyData[groupIndex].month))}\n',
                          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                          children: <TextSpan>[
                            TextSpan(
                              text: NumberFormat.currency(symbol: '\$').format(rod.toY),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          if (value == 0 || value >= meta.max) return const SizedBox();
                          return Text('\$${value.toInt()}', style: TextStyle(color: Colors.grey[600], fontSize: 10));
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          final monthStr = monthlyData[value.toInt()].month;

                          final month = DateFormat('yyyy-MM').parse(monthStr);
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(DateFormat.MMM().format(month), style: TextStyle(color: Colors.grey[700], fontSize: 12)),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) => FlLine(color: Colors.grey.shade200, strokeWidth: 1),
                  ),
                  barGroups: monthlyData.asMap().entries.map((entry) {
                    int index = entry.key;
                    MonthlyDonation data = entry.value;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: data.total,
                          color: const Color(0xFF1DB954),
                          width: 16,
                          borderRadius: BorderRadius.circular(4),
                        )
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}