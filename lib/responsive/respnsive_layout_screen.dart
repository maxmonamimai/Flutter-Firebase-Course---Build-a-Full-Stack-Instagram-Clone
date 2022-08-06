import 'package:flutter/material.dart';
import 'package:instragrame_flutter/utils/dimemnsion.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const ResponsiveLayout({Key? key, required this.webScreenLayout, required this.mobileScreenLayout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: dead_code
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        //web screen
        return webScreenLayout;
      }
      // mobile layout
        return mobileScreenLayout;
    });
  }
}