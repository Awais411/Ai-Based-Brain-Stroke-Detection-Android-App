import 'package:cogniosis/screens/result.dart';

import '../utils/basic_screen_imports.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_menu.dart';

class UploadedImage extends StatelessWidget {
  const UploadedImage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: CustomColor.bluebg,
      drawer: SizedBox(width: 250.w, child: CustomDrawer()),
      appBar: CustomAppBar(
        onMenuPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
        onNotificationPressed: () {},
        showBorder: true,
        scaffoldContext: context,
      ),
      body: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back,
                  color: CustomColor.uploadReporsScreen),
            )),
        SizedBox(height: Dimensions.heightSizelarge),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: 313.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            border: Border.all(color: CustomColor.uploadReporsScreen, width: 5),
          ),
          child: Image.asset(
            'assets/results/brain_detection.jpeg',
            fit: BoxFit.fitWidth,
          ),
        ),
        SizedBox(height: Dimensions.heightSizelarge),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Result()));
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
                vertical: 0,
                horizontal: Dimensions.paddingSizeHorizontalSize * 2),
            backgroundColor: CustomColor.uploadReporsScreen,
          ),
          child: const Text('Get Results'),
        )
      ])),
    );
  }
}
