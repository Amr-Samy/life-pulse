import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:life_pulse/data/network/api.dart';
import 'package:life_pulse/presentation/profile_tab/help/models/add_ticket.dart';
import 'package:life_pulse/presentation/profile_tab/help/models/contact_us.dart';
import 'package:life_pulse/presentation/profile_tab/help/models/faqs.dart';
import 'package:life_pulse/presentation/profile_tab/help/models/last_ticket.dart';
import 'package:life_pulse/presentation/resources/index.dart';
import 'package:url_launcher/url_launcher.dart';
class ContactUsController extends GetxController {
  RxBool isPageLoading = true.obs;
  RxBool isLoadingData = true.obs;
  RxBool isLoadMoreLoading = false.obs;

  ContactUs? contactUs;
  FAQs? faqsResponse;
  RxList<Faq> faqsList = <Faq>[].obs;
  RxBool hasMoreData = true.obs;
  RxInt currentPage = 1.obs;
  RxInt selectedCategoryIndex = 0.obs;
  //TODO AUTOMATIC REPLY // USE STREAM
  //? //////////////////Contacts/////////////////////////
  Future getContacts() async {
    try {
      var res = await Api().get('contact_us');
      contactUs = ContactUs.fromJson(res.data);
      if (contactUs?.facebook?.isNotEmpty ?? false) {
        isPageLoading.value = false;
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }
  //? //////////////////FAQ Categories///////////////////
  Future getFaqCategories() async {
    try {
      var res = await Api().get('faqs_categories');

    } catch (err) {
      throw Exception(err.toString());
    }
  }
  //? //////////////////38-FAQs////////////////////////////
  Future getFAQs({String? category, int? items, int? page, bool isLoadMore = false}) async {
    if (!isLoadMore) {
      isLoadingData.value = true;
      currentPage.value = 1;
      faqsList.clear();
      hasMoreData.value = true; // Reset this when loading new category
    } else {
      if (!hasMoreData.value) return; // Don't load more if no more data
      isLoadMoreLoading.value = true;
    }

    try {
      final res = await Api().get('faqs', queryParameters: {
        "category": category,
        "items": items ?? 5,
        "page": currentPage.value
      });

      faqsResponse = FAQs.fromJson(res.data);
      if (faqsResponse?.status == "success") {
        final newData = faqsResponse?.data ?? [];

        if (isLoadMore) {
          faqsList.addAll(newData);
        } else {
          faqsList.value = newData;
        }

        // Update pagination status
        hasMoreData.value = newData.length >= (items ?? 5) &&
            (faqsResponse?.paging?.next != null);

        if (hasMoreData.value) {
          currentPage.value++;
        }
      }
    } catch (err) {
      hasMoreData.value = false;
      showErrorSnackBar(message: err.toString());
    } finally {
      isLoadingData.value = false;
      isLoadMoreLoading.value = false;
    }
  }

//? //////////////////44-ContactUs Tickets////////////////
  LastTicketResponse? lastTicketResponse;
  RxList<Ticket> ticketsList = <Ticket>[].obs;
  Future getLastTicket() async {
    ticketsList.clear();
    try {
      // isLoading.value = true;
      var res = await Api().get('tickets',queryParameters: {"items" : 99});
      lastTicketResponse = LastTicketResponse.fromJson(res.data);
      print(lastTicketResponse!.data?.tickets);
      if (lastTicketResponse?.status == "success") {
        ticketsList.value = List.from(lastTicketResponse!.data?.tickets as Iterable) ;
        ticketsList.value = ticketsList.reversed.toList();
        // isLoading.value = false;
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }
//? //////////////////42-Add Tickets////////////////////
  AddTicketResponse? addTicketResponse;
  TextEditingController message = TextEditingController();
  Future<void> createTicket() async {
    // isLoading.value = true ;
    dynamic data = {"ticket": {"content":message.text.trim()}};
    try {
      var  req = await Api().post(
        'tickets',
        data: data,
      );
      addTicketResponse = AddTicketResponse.fromJson(req.data);
      if (addTicketResponse?.status == "success") {
        print(addTicketResponse?.ticketNumber);
        // isLoading.value = false;
      }
    } catch (err) {
      // isLoading.value = false ;
      throw Exception(err.toString());
    }

  }
//? //////////////////Reply Tickets////////////////////
  ReplyTicketResponse? replyTicketResponse;
  Future<void> replyTicket(int id) async {
    // isLoading.value = true ;
    dynamic data = {
      "ticket_reply":
        {
          "content":message.text.trim(),
          "ticket_id": id,
        }
    };
    try {
      var  req = await Api().post(
        'add_ticket_reply',
        data: data,
      );
      replyTicketResponse = ReplyTicketResponse.fromJson(req.data);
      if (replyTicketResponse?.status == "success") {
        print(replyTicketResponse?.ticketId);
        // isLoading.value = false;
      }
    } catch (err) {
      // isLoading.value = false ;
      throw Exception(err.toString());
    }
  }
//? //////////////////Send Message////////////////////
  sendMessage(){
    ticketsList.isEmpty ? createTicket() : replyTicket(ticketsList.last.id!) ;
    getLastTicket();
    message.clear();
  }
//? //////////////////Launch url////////////////////
  Future<void> launchLink({String? url,}) async {
    bool isAndroid = Theme.of(Get.context!).platform == TargetPlatform.android;
    try {
      bool launched = await launchUrl(Uri.parse(url!), mode: LaunchMode.externalNonBrowserApplication,);

      if (!launched) {
        launchUrl(Uri.parse(url), mode: LaunchMode.inAppWebView,); // Launch web view if app is not installed!
      }
    } catch (e) {
      launchUrl(Uri.parse(url!), mode: LaunchMode.platformDefault,);
      showErrorSnackBar(message: e.toString());
    }
  }
}
String capitalize(String input) {
  // if (input.isEmpty) return input;
  return input[0].toUpperCase() + input.substring(1);
}
