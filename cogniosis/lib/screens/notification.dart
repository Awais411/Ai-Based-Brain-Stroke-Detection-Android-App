// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:tradeviser/global.dart';
//
// final _firebaseMessaging = FirebaseMessaging.instance;
//
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();
//
// class FirebaseMessageApi {
//   /// Initialization
//   static Future<void> initialize() async {
//     await _firebaseMessaging.requestPermission(sound: true);
//     final fcmToken = await _firebaseMessaging.getToken();
//     print("fcmToken :: $fcmToken");
//
//
//     // Define Android notification details with custom sound
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//     AndroidNotificationDetails(
//         'channel_id', 'channel_name',
//         importance: Importance.max,
//         priority: Priority.high,
//         sound: RawResourceAndroidNotificationSound('images/ding.mp3'),
//         playSound: true);
//     const NotificationDetails platformChannelSpecifics =
//     NotificationDetails(android: androidPlatformChannelSpecifics);
//
//     FirebaseMessaging.onBackgroundMessage(backgroundHandler);
//
//     // Handle foreground messages
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Received message in foreground:');
//       print('Title 11: ${message.notification?.title}');
//       print('Body 11: ${message.notification?.body}');
//       print('Payload 11: ${message.data}');
//       customPrint(message.data.toString());
//       customPrint(message.notification?.title);
//       flutterLocalNotificationsPlugin.show(
//           0,
//           message.notification?.title ?? '',
//           message.notification?.body ?? '',
//           platformChannelSpecifics,
//       );
//     });
//
//     // Handle when the app is terminated but the user clicks on the notification
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('User clicked on notification:');
//       print('Title 22: ${message.notification?.title}');
//       print('Body 22: ${message.notification?.body}');
//       print('Payload 22: ${message.data}');
//       customPrint(message.data.toString());
//       customPrint(message.notification?.title);
//       // Handle the message here, e.g., navigate to a specific screen
//     });
//   }
// }
//
// Future<void> backgroundHandler(RemoteMessage message) async {
//   print('Handling background message:');
//   print('Title 33: ${message.notification?.title}');
//   print('Body 33: ${message.notification?.body}');
//   print('Payload 33: ${message.data}');
//   print('Payload 33: ${message.data['advise_id']}');
//   customPrint(message.data.toString());
//   customPrint(message.notification?.title);
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final _firebaseMessaging = FirebaseMessaging.instance;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class FirebaseMessageApi {
  /// Initialization
  static Future<void> initialize() async {
    await _firebaseMessaging.requestPermission(sound: true);
    final fcmToken = await _firebaseMessaging.getToken();
    print("fcmToken :: $fcmToken");

    // Initialize the FlutterLocalNotificationsPlugin
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Define Android notification details with custom sound
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      // Use the name without extension
      playSound: true,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // print('Received message in foreground:');
      // print('Title 11: ${message.notification?.title}');
      // print('Body 11: ${message.notification?.body}');
      // print('Payload 11: ${message.data}');
      // customPrint(message.data.toString());
      // customPrint(message.notification?.title);
      flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title ?? '',
        message.notification?.body ?? '',
        platformChannelSpecifics,
      );
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Received message in foreground:');
      print('Title: ${message.notification?.title}');
      print('Body: ${message.notification?.body}');
      print('Payload: ${message.data}');
      flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title ?? '',
        message.notification?.body ?? '',
        platformChannelSpecifics,
      );
      await _saveNotificationToFirestore(
        message.notification?.title ?? '',
        message.notification?.body ?? '',
      );
    });
    // Handle when the app is terminated but the user clicks on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // print('User clicked on notification:');
      // print('Title 22: ${message.notification?.title}');
      // print('Body 22: ${message.notification?.body}');
      // print('Payload 22: ${message.data}');
      // customPrint(message.data.toString());
      // customPrint(message.notification?.title);
      // Handle the message here, e.g., navigate to a specific screen
    });
  }

  static Future<void> _saveNotificationToFirestore(
      String title, String body) async {
    CollectionReference notifications =
        FirebaseFirestore.instance.collection('notifications');
    await notifications.add({
      'title': title,
      'body': body,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}

Future<void> backgroundHandler(RemoteMessage message) async {
  await FirebaseMessageApi._saveNotificationToFirestore(
    message.notification?.title ?? '',
    message.notification?.body ?? '',
  );
  // print('Handling background message:');
  // print('Title 33: ${message.notification?.title}');
  // print('Body 33: ${message.notification?.body}');
  // print('Payload 33: ${message.data}');
  // print('Payload 33: ${message.data['advise_id']}');
  // customPrint(message.data.toString());
  // customPrint(message.notification?.title);
}
