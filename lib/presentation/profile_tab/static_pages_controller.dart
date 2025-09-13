import 'dart:convert';

import 'package:get/get.dart';
import 'package:life_pulse/data/network/api.dart';

class StaticPagesController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getStaticPage("terms");
    // getStaticPage("privacy");
    // getStaticPage("about");
  }
  //? //////////////////51-Static Pages/////////////////////////
  String? content;
  Future getStaticPage(String page) async {
    try {
      var  res = await Api().get('pages/$page');
      dynamic responseData = res.data;
      if (responseData is String) {
        responseData = json.decode(responseData);
      }
      String status = responseData['status'];
      if (status == 'success') {
      content = responseData['content'];
      print(content);
      }  

    } catch (err) {
      throw Exception(err.toString());
    }
  }


}