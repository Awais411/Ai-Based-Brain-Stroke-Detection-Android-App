import 'package:cogniosis/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onMenuPressed;
  final VoidCallback onNotificationPressed;
  final bool showBorder;
  final double elevation;
  final BuildContext scaffoldContext; // Pass the context here


  const CustomAppBar({super.key, 
    required this.onMenuPressed,
    required this.onNotificationPressed,
    this.showBorder = false,
    this.elevation = 4.0,
    required this.scaffoldContext,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      color: Colors.white,
      child: Container(
        decoration: showBorder
            ? const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black, width: 2.0),
          ),
        )
            : null,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent, // Set AppBar's background color to transparent
            leading: Builder(
              builder: (scaffoldContext)=>IconButton(
                icon: const Icon(Icons.menu),
                color: Colors.black,
                onPressed: onMenuPressed,
              ),
            ),
            title: const CustomText(firstPart: 'Cognio', secondPart: 'sis',),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.notifications),
                color: Colors.black,
                onPressed: onNotificationPressed,
              ),
            ],
            elevation: 0, // Set AppBar's elevation to 0 to prevent duplicate shadow
            iconTheme: const IconThemeData(color: Colors.black),
          ),
        ),
      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
