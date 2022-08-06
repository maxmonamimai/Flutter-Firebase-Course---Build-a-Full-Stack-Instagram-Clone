import 'package:flutter/material.dart';
import 'package:instragrame_flutter/provider/user_provider.dart';
import 'package:instragrame_flutter/utils/global_varialable.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const ResponsiveLayout({Key? key, required this.webScreenLayout, required this.mobileScreenLayout}) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {

  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }
  
  @override
  Widget build(BuildContext context) {
    // ignore: dead_code
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        //web screen
        return widget.webScreenLayout;
      }
      // mobile layout
        return widget.mobileScreenLayout;
    });
  }
}