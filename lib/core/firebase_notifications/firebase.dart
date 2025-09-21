import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import '../../../presentation/resources/color_manager.dart';
import 'data/data_sources/notificaiton_local_data_source.dart';
import 'data/data_sources/notification_remote_data_source.dart';
import 'data/repositories/notification_repository_impl.dart';
import 'domain/entities/notification_entity.dart';
import 'domain/use_cases/get_notifications_use_case.dart';
import 'domain/use_cases/request_permission_use_case.dart';

final getIt = GetIt.instance;

// class NotificationService {
//   static Future<void> init(BuildContext context) async {
//     // Foreground
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         print('📩 Foreground message received');
//         print(message.data);
//       });
//     });
//
//     // Background (when app is opened by tapping the notification)
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//
//       FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//         _handleMessage(message);
//
//         print('📩 Opened from background');
//         print(message.data);
//       });
//     });
//
//     // Terminated (cold start)
//     RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
//     if (initialMessage != null) {
//       _handleMessage(initialMessage);
//
//       print('📩 Opened from terminated');
//
//       print(initialMessage.data);
//     }
//   }
//   static void _handleMessage(RemoteMessage message) {
//     // final studentController = Get.put(StudentController());
//     var dataAgs = message.data.isNotEmpty ? message.data : (message.notification?.toMap() ?? {});
//
//     print("✅ دخلنا _handleMessage");
//     print("📦 بيانات الرسالة: $dataAgs");
//
//     final state = dataAgs['state'];
//     if (state == null) {
//       print("⚠️ لا يوجد state في الرسالة");
//       return;
//     }
//
//     switch (state) {
//       case 'myTraining':
//         print("➡️ التنقل إلى myTraining");
//         Get.toNamed(Routes.studentReservedTrainingsView, arguments: message);
//         break;
//
//       case 'pendingTraining':
//         print("➡️ التنقل إلى pendingTraining");
//         Get.toNamed(Routes.studentReservedTrainingsView, arguments: message);
//         break;
//
//       case 'posts':
//         print("📰 تغيير التبويب إلى posts");
//         studentController.changeTabPage(0);
//         break;
//
//       case 'jobs':
//         print("💼 تغيير التبويب إلى jobs");
//         studentController.changeTabPage(2);
//         break;
//
//       case 'myJob':
//         print("➡️ التنقل إلى myJob");
//         Get.toNamed(Routes.studentAppliedJobs);
//         break;
//
//       case 'trainings':
//         print("🎓 تغيير التبويب إلى trainings");
//         studentController.changeTabPage(1);
//         break;
//
//       case 'receiveMessage':
//         print("💬 استقبال رسالة محادثة جديدة");
//         if (Get.isRegistered<ChatPaginationController>()) {
//           ChatPaginationController chatPaginationController = Get.find<ChatPaginationController>();
//           try {
//             ChatModel chatModel = ChatModel.fromJson(jsonDecode(dataAgs['data']));
//             chatPaginationController.list.insert(0, chatModel);
//             Get.toNamed(Routes.chatScreen);
//           } catch (e) {
//             print("❌ فشل في تحويل الرسالة إلى ChatModel: $e");
//           }
//         } else {
//           print("⚠️ ChatPaginationController غير مسجل");
//         }
//         break;
//
//       default:
//         print("❗️قيمة state غير معروفة: $state - الرجوع للتبويب الأساسي");
//         studentController.changeTabPage(0);
//     }
//   }
//
// }
class FirebaseFcm {

  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> setUp() async {
    await Firebase.initializeApp();

    // تسجيل الكائنات في GetIt
    getIt.registerSingleton<NotificationRemoteDataSource>(NotificationRemoteDataSource());
    getIt.registerSingleton<NotificationLocalDataSource>(NotificationLocalDataSource());

    final repository = NotificationRepositoryImpl(
      getIt<NotificationRemoteDataSource>(),
      getIt<NotificationLocalDataSource>(),
    );


    getIt.registerSingleton<RequestPermissionUseCase>(RequestPermissionUseCase(repository));
    getIt.registerSingleton<GetNotificationsUseCase>(GetNotificationsUseCase(repository));



    // الاشتراك في الإشعارات
    _requestPermission();
    _subscribeToNotifications();
    getFcmToken();

  }



  static Future<void> _requestPermission() async {
    await getIt<GetNotificationsUseCase>().repository.requestPermission();
  }

  static void _subscribeToNotifications() {
    getIt<GetNotificationsUseCase>()().listen((NotificationEntity notification) {
      _showNotification(notification);
    });
  }

  static Future<String?> getFcmToken() async {
    try {
      final box = GetStorage();
      String? token =  await FirebaseMessaging.instance.getToken();
      box.write('deviceToken',token);
      print('FCM Tokennnn: ${box.read('deviceToken')}');
      return token ;
    }catch(e){
      print(e);
    }
    return null;
  }

  // دالة لإرسال إشعار اختبار

  static Future<void> subscribeToTopic(String topic) async {
    final box = GetStorage();
    final key = 'subscribed_to_$topic';

    if (box.read(key) == true) {
      print('🔁 بالفعل مشترك في $topic');
      return;
    }

    try {
       getIt<NotificationRemoteDataSource>().subscribeToTopic(topic);
      box.write(key, true);
      print('✅ Subscribed to $topic');
    } catch (e) {
      print('❌ Failed to subscribe to $topic: $e');
    }
  }

  static Future<void> unsubscribeFromTopic(String topic) async {
    final box = GetStorage();
    final key = 'subscribed_to_$topic';

    if (box.read(key) != true) {
      print('ℹ️ غير مشترك في $topic أساسًا');
      return;
    }

    try {
      getIt<NotificationRemoteDataSource>().unSubscribeToTopic(topic);
      box.remove(key);
      print('🚫 تم إلغاء الاشتراك من $topic');
    } catch (e) {
      print('❌ فشل في إلغاء الاشتراك من $topic: $e');
    }
  }



  static void _showNotification(NotificationEntity message) async {
    // إعدادات Android
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id', // استخدم نفس معرف القناة
      'Your Channel Name',
      channelDescription: 'Your channel description',
      importance: Importance.max,
      ticker: 'New Notification',
      enableLights: true,
      priority: Priority.high ,
      color: ColorManager.white,
      icon: '@drawable/ic_launcher',
      visibility: NotificationVisibility.public,
    );

    // إعدادات iOS
    DarwinNotificationDetails iOSPlatformChannelSpecifics = DarwinNotificationDetails();

    // إعدادات الإشعار العامة
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.title ?? '',
      message.body ?? '',
      platformChannelSpecifics,
      payload: 'Notification Payload',
    );
  }

}