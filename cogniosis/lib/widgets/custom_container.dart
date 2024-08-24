import '../utils/basic_screen_imports.dart';

class CustomContainer extends StatelessWidget {
  final Color startColor;
  final Color endColor;
  final String heading;
  final String subheading;
  final String description;

  const CustomContainer({
    super.key,
    required this.startColor,
    required this.endColor,
    required this.heading,
    required this.subheading,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 173.h,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [startColor, endColor],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: heading,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: subheading,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w200),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  description,
                  style: GoogleFonts.pontanoSans(
                    color: Colors.white,
                    fontSize: Dimensions.headingTextSize4,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Image.asset(
              'assets/home/doctor.png',
              height: 140.h,
              width: 200.w,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
