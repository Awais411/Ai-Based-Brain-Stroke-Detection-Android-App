import 'package:cogniosis/utils/basic_screen_imports.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.whiteColor,
        title: const Text('About Us'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Dimensions.paddingSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: 150.w,
                height: 150.h,
                // Replace 'logo.png' with your logo image asset
                child: Image.asset('assets/logo/logo.png'),
              ),
            ),
            SizedBox(height: Dimensions.heightSize),
            Center(
              child: Text(
                'Empowering Early Stroke Detection with AI',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: Dimensions.heightSize),
            Text(
              'We are a team passionate about revolutionizing healthcare through cutting-edge technology. Our mission is to empower individuals with knowledge about their health and equip them to take a proactive approach to stroke prevention.',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: CustomColor.greyColor, fontWeight: FontWeight.w300),
            ),
            SizedBox(height: Dimensions.heightSize),
            Text(
              'This app is the culmination of our dedication to developing a user-friendly tool for early stroke detection. Our AI model, trained on a vast dataset of medical images, identifies potential signs of stroke with high accuracy.',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: CustomColor.greyColor, fontWeight: FontWeight.w300),

            ),
            SizedBox(height: Dimensions.heightSize),
            Text(
              'We believe early detection is key to minimizing stroke damage and improving patient outcomes. With this app, we aim to:',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: CustomColor.greyColor, fontWeight: FontWeight.w300),
            ),
            SizedBox(height: Dimensions.heightSize),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('\u25CF Increase awareness about stroke risk factors and symptoms.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: CustomColor.blackColor),
                  ),
                  Text('\u25CF Provide a convenient and non-invasive way to assess potential stroke risk.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: CustomColor.blackColor),
                  ),
                  Text('\u25CF Encourage individuals to seek professional medical advice if necessary.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: CustomColor.blackColor),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimensions.heightSize),
            Text(
              'We are committed to constantly improving our app and staying at the forefront of stroke detection technology, providing a valuable resource for everyone concerned about their health.',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: CustomColor.greyColor, fontWeight: FontWeight.w300),

            ),
          ],
        ),
      ),
    );
  }
}
