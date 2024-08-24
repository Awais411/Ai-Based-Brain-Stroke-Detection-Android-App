import 'package:cogniosis/screens/faqs_screen.dart';
import 'package:cogniosis/utils/basic_screen_imports.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../screens/about_us.dart';
import '../screens/auth.dart';
import '../screens/login_screen.dart';
import '../screens/profiel_screen.dart';
import '../utils/appConstant.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 470.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20.r),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  offset: Offset(9, 7),
                  blurRadius: 8.3,
                ),
              ],
              color: const Color.fromRGBO(255, 255, 255, 1),
            ),
            child: Column(
              children: [
                Container(
                  height: 90.h,
                  color: const Color.fromRGBO(0, 0, 0, 1),
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                          color: Colors.transparent,
                          image: DecorationImage(
                              image: AssetImage('assets/home/dummy-profile-pic.png'),
                              fit: BoxFit.cover
                          )
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: AppConstants.to.profilePic.value != ''
                            ? Image.network(AppConstants.to.profilePic.value,
                          fit: BoxFit.cover,
                        )
                            : Image.asset(
                          "assets/home/dummy-profile-pic.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      AppConstants.to.isGuest.value ? 'Guest User' : AppConstants.to.name.value,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Text(
                      AppConstants.to.isGuest.value ? 'guest@example.com' : AppConstants.to.email.value,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontFamily: 'Poppins',
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'My Profile',
                    style: buildTextStyle(),
                  ),
                  leading: const Icon(Icons.person),
                  onTap: () {
                    if(AppConstants.to.isGuest.value == false)
                    {
                      Get.to(const ProfileScreen());
                    }
                  },
                ),
                ListTile(
                  title: Text(
                    'FAQs',
                    style: buildTextStyle(),
                  ),
                  leading: const Icon(Icons.question_answer),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FAQsScreen()));
                  },
                ),
                ListTile(
                  title: Text(
                    'About US',
                    style: buildTextStyle(),
                  ),
                  leading: const Icon(Icons.info),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AboutUsScreen()));
                  },
                ),
                ListTile(
                  title: Text(
                    'Log Out',
                    style: buildTextStyle(),
                  ),
                  leading: const Icon(Icons.logout),
                  onTap: () async {
                    AuthService authService = AuthService();
                    await authService.signOut();
                  },
                ),
                SizedBox(
                  height: Dimensions.heightSizelarge,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.arrow_back,
                    color: CustomColor.blackColor,
                  ),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle buildTextStyle() {
    return GoogleFonts.poppins(
      color: Colors.black,
      fontSize: Dimensions.hTextSize3,
      fontWeight: FontWeight.bold,
    );
  }
}
