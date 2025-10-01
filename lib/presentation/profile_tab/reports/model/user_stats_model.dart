class MonthlyDonation {
  final String month;
  final String count;
  final double total;

  MonthlyDonation({required this.month, required this.count, required this.total});

  factory MonthlyDonation.fromJson(Map<String, dynamic> json) {
    return MonthlyDonation(
      month: json['month'] ?? '',
      count: json['count'] ?? '0',
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
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

  bool get isEmpty =>
      totalDonated == 0 &&
      donationsCount == 0 &&
      createdCampaignsCount == 0 &&
      monthlyDonations.isEmpty;


  UserStats({
    required this.totalDonated,
    required this.donationsCount,
    required this.favoriteCampaignsCount,
    required this.createdCampaignsCount,
    required this.walletBalance,
    required this.monthlyDonations,
  });

  factory UserStats.fromJson(Map<String, dynamic> json) {
    var monthlyList = json['monthly_donations'] as List? ?? [];
    List<MonthlyDonation> monthlyDonationsList = monthlyList.map((i) => MonthlyDonation.fromJson(i)).toList();

    return UserStats(
      totalDonated: (json['total_donated'] as num?)?.toDouble() ?? 0.0,
      donationsCount: json['donations_count'] as int? ?? 0,
      favoriteCampaignsCount: json['favorite_campaigns_count'] as int? ?? 0,
      createdCampaignsCount: json['created_campaigns_count'] as int? ?? 0,
      walletBalance: (json['wallet_balance'] as num?)?.toDouble() ?? 0.0,
      monthlyDonations: monthlyDonationsList,
    );
  }
}