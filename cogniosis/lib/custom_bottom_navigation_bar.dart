import 'package:cogniosis/screens/home_screen.dart';
import 'package:cogniosis/screens/notifications_screen.dart';
import 'package:cogniosis/screens/profiel_screen.dart';
import 'package:cogniosis/screens/upload_report.dart';
import 'package:cogniosis/utils/appConstant.dart';
import 'package:cogniosis/utils/basic_screen_imports.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key, this.index});
  final int? index;

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late int _selectedIndex;

  final List<Widget> _screens = [
    const HomeScreen(),
    const UploadReport(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index ?? 0;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.bluebg,
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(Dimensions.radiusLarge),
          topLeft: Radius.circular(Dimensions.radiusLarge),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: CustomColor.blackColor,
          selectedItemColor: CustomColor.blueColor,
          unselectedItemColor: CustomColor.whiteColor,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.upload),
              label: 'Upload',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notification',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {

    if (AppConstants.to.isGuest.value && index == 3) {
      // Do nothing if the user is a guest and clicks on the profile screen
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }
}