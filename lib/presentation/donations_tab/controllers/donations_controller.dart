import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:life_pulse/data/network/api.dart';
import 'package:life_pulse/presentation/resources/helpers/functions.dart';
import '../../resources/validation_manager.dart';
import '../models/donation.dart';

class DonationsController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxMap<String, List<Donation>> groupedDonations =
      <String, List<Donation>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    if(!isGuest()) fetchDonations();
  }

  Future<void> fetchDonations() async {
    try {
      isLoading(true);
      final response = await Api().get('donations');
      if (kDebugMode) {
        print(response.data);
      }
      if (response.statusCode == 200 && response.data['success'] == true) {
        final List<Donation> donations = (response.data['data'] as List)
            .map((item) => Donation.fromJson(item))
            .toList();
        _groupDonations(donations);
        print("donations fetched successfully.");
        print("donations: ${donations[0].amount}");
      } else {
        showErrorSnackBar(message: 'Failed to load donations.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching donations: $e');
      }
      showErrorSnackBar(message: 'An error occurred while fetching donations.');
    } finally {
      isLoading(false);
    }
  }

  void _groupDonations(List<Donation> donations) {
    final data = SplayTreeMap<String, List<Donation>>();
    final now = DateTime.now();

    for (var donation in donations) {
      String groupKey;
      if (donation.createdAt.year == now.year && donation.createdAt.month == now.month) {
        groupKey = "This month";
      } else {
        groupKey = DateFormat('MMM yyyy').format(donation.createdAt);
      }

      data.putIfAbsent(groupKey, () => []).add(donation);
    }
    groupedDonations.value = Map.fromEntries(data.entries.toList().reversed);
  }
}