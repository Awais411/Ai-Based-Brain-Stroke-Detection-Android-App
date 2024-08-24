import 'dart:io';
import 'dart:math';

import 'package:cogniosis/screens/notifications_screen.dart';
import 'package:cogniosis/screens/upload_report.dart';
import 'package:cogniosis/widgets/custom_appbar.dart';
import 'package:cogniosis/widgets/graph_container.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/basic_screen_imports.dart';
import '../widgets/ask_us_container.dart';
import '../widgets/custom_container_list.dart';
import '../widgets/custom_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        // Show notification in foreground
        print('Foreground notification received: ${notification.title}');
        // Here, you can show a dialog, a toast, or any UI element
      }
    });
    getToken();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // Handle notification tap when the app is in background
    });

    // Request permissions for iOS
    if (Platform.isIOS) {
      _requestPermission();
    }
  }

  Future<void> getToken() async {
    String? token = await messaging.getToken();
    print("Device token: $token");
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void _requestPermission() async {
    if (Platform.isAndroid) {
      final NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
      } else {
        print('User declined or has not accepted permission');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: CustomColor.shade2Blue, // Set the status bar color here
      statusBarIconBrightness:
      Brightness.light, // Set the status bar icon brightness
    ));
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: CustomColor.bluebg,
      drawer: SizedBox(
        width: 250.w,
        child: CustomDrawer(),
      ),
      appBar: CustomAppBar(
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        onNotificationPressed: () {
          Get.to(NotificationScreen());
        },
        scaffoldContext: context,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 5.h,
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                minHeight: 173.h,
                maxHeight: 173.h,
                child: const CustomContainerList(),
              ),
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  BrainStrokeContainer(),
                  const GraphContainer(),
                  SizedBox(height: Dimensions.heightSize),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSize),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UploadReport()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColor.shade4Blue,
                      ),
                      child: Center(
                          child: Text(
                            'Detect Brain Stroke Now!!!',
                            style: Theme.of(context).textTheme.headlineSmall,
                          )),
                    ),
                  ),
                  SizedBox(height: Dimensions.heightSize),
                  SizedBox(
                    height: 203.h,
                    child: const AskUsContainer(),
                  ),
                  SizedBox(
                    height: Dimensions.heightSizelarge,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding BrainStrokeContainer() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 5.r, horizontal: Dimensions.paddingSize),
      child: Container(
        padding: EdgeInsets.all(Dimensions.paddingSize - 5),
        //height: 125.h,
        decoration: BoxDecoration(
          borderRadius:
          BorderRadius.all(Radius.circular(Dimensions.radiusLarge)),
          color: CustomColor.whiteColor,
        ),
        child: Column(
          children: [
            Text('Brain Stroke!',
                style: CustomStyle.brainStroke.copyWith(fontSize: 24)),
            Text.rich(
                TextSpan(text: "A ", style: CustomStyle.paragraph.copyWith(fontSize: 20), children: [
                  TextSpan(
                      text: 'Brain Stroke, ',
                      style: CustomStyle.paragraph
                          .copyWith(color: CustomColor.shade1Blue, fontSize: 20)),
                  TextSpan(
                    text:
                    'also known as a cerebrovascular accident (CVA), is a medical emergency that occurs when the blood supply to a part of the brain is interrupted or reduced, depriving brain tissue of oxygen and nutrients. This can cause brain cells to begin dying within minutes.',
                    style: CustomStyle.paragraph.copyWith(fontSize: 20),
                  )
                ])),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
