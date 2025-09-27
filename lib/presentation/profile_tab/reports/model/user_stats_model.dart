class MonthlyDonation {
  final String month;
  final String count;
  final double total;

  MonthlyDonation({required this.month, required this.count, required this.total});

  factory MonthlyDonation.fromJson(Map<String, dynamic> json) {
    return MonthlyDonation(
      month: json['month'],
      count: json['count'],
      total: (json['total'] as num).toDouble(),
    );
  }
}

class UserStats {
  final double totalDonated;
  final int donationsCount;
  final int favoriteCampaignsCount;
  final int createdCampaignsCount;
  final double walletBalance;
  final List<MonthlyDonation> monthlyDonations;

  UserStats({
    required this.totalDonated,
    required this.donationsCount,
    required this.favoriteCampaignsCount,
    required this.createdCampaignsCount,
    required this.walletBalance,
    required this.monthlyDonations,
  });

  factory UserStats.fromJson(Map<String, dynamic> json) {
    var monthlyList = json['monthly_donations'] as List;
    List<MonthlyDonation> monthlyDonationsList = monthlyList.map((i) => MonthlyDonation.fromJson(i)).toList();

    return UserStats(
      totalDonated: (json['total_donated'] as num).toDouble(),
      donationsCount: json['donations_count'],
      favoriteCampaignsCount: json['favorite_campaigns_count'],
      createdCampaignsCount: json['created_campaigns_count'],
      walletBalance: (json['wallet_balance'] as num).toDouble(),
      monthlyDonations: monthlyDonationsList,
    );
  }
}