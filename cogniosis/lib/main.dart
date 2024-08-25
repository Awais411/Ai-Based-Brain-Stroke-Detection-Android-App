import 'package:cogniosis/screens/notification.dart';
import 'package:cogniosis/screens/splash_screen.dart';
import 'package:cogniosis/theme/theme.dart';
import 'package:cogniosis/utils/basic_screen_imports.dart';
import 'package:cogniosis/utils/appConstant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AppConstants());

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'Your API Key',
          appId: '1:710152295683:android:e4cd479cd08f74798e8536',
          messagingSenderId: '710152295683',
          projectId: 'cogniosis-app',
          storageBucket: "cogniosis-app.appspot.com"
      ),
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  FirebaseMessageApi.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (context, _) => GetMaterialApp(
        theme: Congniosis.lightTheme,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
