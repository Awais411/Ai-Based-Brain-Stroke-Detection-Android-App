import 'dart:async';

import 'package:cogniosis/utils/basic_screen_imports.dart';
import 'package:cogniosis/widgets/custom_container.dart'; // Adjust the import as per your project structure
import 'package:flutter/material.dart';

class CustomContainerList extends StatefulWidget {
  const CustomContainerList({super.key});

  @override
  _CustomContainerListState createState() => _CustomContainerListState();
}

class _CustomContainerListState extends State<CustomContainerList> {
  int _currentPage = 0;
  PageController _pageController = PageController(initialPage: 0);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);

    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              const CustomContainer(
                startColor: Color(0xFF4984F7),
                endColor: Color(0xFFFF578A),
                heading: 'Friendly & Encouraging: ',
                subheading: '',
                description:
                    'Let’s work together for early stroke detection. Welcome!',
              ),
              const CustomContainer(
                startColor: Color(0xFF20E1FB),
                endColor: Color(0xff4739EA),
                heading: 'Tech-Forward: ',
                subheading: '',
                description: 'Our AI model, your stroke detection guardian.',
              ),
              CustomContainer(
                startColor: const Color(0xFF4739EA),
                endColor: const Color(0xFF20E1FB).withOpacity(0.9),
                heading: 'Accuracy Focused: ',
                subheading: '',
                description:
                    'Sharp AI. Early stroke detection, just a tap away.',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: _currentPage == index ? 12 : 8,
      width: _currentPage == index ? 12 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
