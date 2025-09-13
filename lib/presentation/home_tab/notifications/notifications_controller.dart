import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:life_pulse/data/network/api.dart';
import 'package:life_pulse/presentation/resources/color_manager.dart';
import 'package:life_pulse/presentation/resources/constants_manager.dart';
import 'package:life_pulse/presentation/resources/strings_manager.dart';

import '../../resources/helpers/functions.dart';
class NotificationsController extends GetxController {
  RxBool isLoading = true.obs;
  // NotificationsResponse? notificationsResponse;
  // RxList<Notifications> notificationsList = <Notifications>[].obs;
  RxInt currentPage = 1.obs;

  void reset() {
    currentPage.value = 1;
    // notificationsList.clear();
    // notificationsResponse = null;
  }

  Future getNotifications({int? items,int? page,bool appendData = false}) async {
    // // Always set loading to true at the start of the request
    //   isLoading.value = true;
    //
    // dynamic params =  {"items": items ??7, "page":page};
    // try {
    //   dynamic res = await Api().get('notifications',queryParameters:params);
    //   //
    //   // notificationsResponse = NotificationsResponse.fromJson(res.data);
    //   // if (notificationsResponse?.data?.notifications?.isNotEmpty ?? false) {
    //   //   if (appendData) {
    //   //     notificationsList.addAll(notificationsResponse!.data!.notifications!);
    //   //   } else {
    //   //   notificationsList.value = notificationsResponse!.data!.notifications!;
    //   }
    //   }
    // } catch (err) {
    //   showErrorSnackBar(message: err.toString());
    //   throw Exception(err.toString());
    // } finally {
    //   isLoading.value = false;
    // }
  }

}