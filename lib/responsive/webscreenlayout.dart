import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class WebscreenLayout extends StatefulWidget {
  const WebscreenLayout({Key? key}) : super(key: key);

  @override
  State<WebscreenLayout> createState() => _WebscreenLayoutState();
}

class _WebscreenLayoutState extends State<WebscreenLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('This is web')),
    );
  }
}