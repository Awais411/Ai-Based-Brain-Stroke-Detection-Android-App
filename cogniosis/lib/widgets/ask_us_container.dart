import 'package:cogniosis/utils/basic_screen_imports.dart';
import 'package:get/get.dart';

import '../ask_us.dart';

class AskUsContainer extends StatelessWidget {
  const AskUsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSize, vertical: 10.r),
      child: GestureDetector(
        onTap: () {
          Get.to(AskUsScreen());
        },
        child: Container(
          width: 332.w,
          padding: EdgeInsets.all(Dimensions.paddingSize - 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: const Color(0xFF5659A9),
          ),
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Any Questions!',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.w800, // Extra bold
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Ask Us',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w500, // Medium
                        color: Colors.black,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Write us your question?',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w300, // Light
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
              Image.asset(
                'assets/home/OBJECTS.png',
                width: 100,
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
