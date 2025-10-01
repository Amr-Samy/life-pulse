import 'package:get/get.dart';
import '../../../../data/network/api.dart';
import '../model/user_stats_model.dart';

enum ScreenState { loading, success, error, empty }

class UserStatsController extends GetxController {
  var screenState = ScreenState.loading.obs;
  var userStats = Rxn<UserStats>();
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserStats();
  }

  Future<void> fetchUserStats() async {
    try {
      screenState.value = ScreenState.loading;
      final response = await Api().get('reports/user-stats');
      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        userStats.value = UserStats.fromJson(data);

        if (userStats.value?.isEmpty ?? true) {
          screenState.value = ScreenState.empty;
        } else {
        screenState.value = ScreenState.success;
        }
      } else {
        errorMessage.value = response.data['message'] ?? 'Failed to load stats.';
        screenState.value = ScreenState.error;
      }
    } catch (e) {
      errorMessage.value = e.toString();
      screenState.value = ScreenState.error;
    }
  }
}