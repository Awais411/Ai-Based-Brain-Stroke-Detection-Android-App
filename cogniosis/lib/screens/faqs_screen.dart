import 'package:flutter/material.dart';

import '../utils/custom_color.dart';

class FAQsScreen extends StatelessWidget {
  const FAQsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.whiteColor,
        title: const Text('FAQs'),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FaqItem(
              question: 'What is this app and what does it do?',
              answer:
                  'Answer: This app is an AI-powered tool that helps assess potential risk factors for stroke. It uses a cutting-edge AI model trained on a massive dataset of medical images to analyze user input and identify potential signs of stroke.',
            ),
            FaqItem(
              question: 'Is this app a replacement for a doctor’s diagnosis?',
              answer:
                  'Answer: No, absolutely not. This app is for informational purposes only and should not be used as a substitute for professional medical advice. If you have any concerns about your health, especially if you experience any stroke symptoms (F.A.S.T – Face drooping, Arm weakness, Speech difficulty, Time to call emergency services), always consult with a doctor immediately.',
            ),
            FaqItem(
              question: 'How accurate is the AI model?',
              answer:
                  'Answer: Our AI model is trained on a vast dataset and designed for high accuracy, about 97%. However, no medical tool is perfect, and further medical evaluation is crucial for definitive diagnosis.',
            ),
            FaqItem(
              question: 'What information does the app collect?',
              answer:
                  'Answer: This app respects your privacy. It does not collect any personal identifiable information (PII) from you.',
            ),
            FaqItem(
              question: 'What happens after I use the app?',
              answer:
                  'Answer: The app will provide you with an assessment based on the AI model’s analysis. It is highly recommended to consult with a doctor, especially if the app suggests a potential risk of stroke.',
            ),
            FaqItem(
              question: 'How can I learn more about stroke?',
              answer:
                  'Answer: The app may offer resources within the app itself or include links to credible health information websites. You can also consult your doctor or a healthcare professional for further information.',
            ),
            FaqItem(
              question: 'How can I provide feedback on the app?',
              answer:
                  'Answer: We value your feedback! Most apps have a dedicated feedback section within the settings or a contact us option. Your input helps us improve the app and its functionality.',
            ),
          ],
        ),
      ),
    );
  }
}

class FaqItem extends StatefulWidget {
  final String question;
  final String answer;

  const FaqItem({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  _FaqItemState createState() => _FaqItemState();
}

class _FaqItemState extends State<FaqItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Text(
            widget.question,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: CustomColor.blackColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const SizedBox(height: 8),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState:
              isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          firstChild: Container(), // Empty container when collapsed
          secondChild: Text(
            widget.answer,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: CustomColor.greyColor,
                  fontWeight: FontWeight.w300,
                ),
          ),
        ),
        const Divider(),
        const SizedBox(height: 16),
      ],
    );
  }
}
