import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instragrame_flutter/provider/user_provider.dart';
import 'package:instragrame_flutter/responsive/mobile_screen_layout.dart';
import 'package:instragrame_flutter/responsive/respnsive_layout_screen.dart';
import 'package:instragrame_flutter/responsive/webscreenlayout.dart';
import 'package:instragrame_flutter/screens/login_screen.dart';
import 'package:instragrame_flutter/screens/signup_screen.dart';
import 'package:instragrame_flutter/utils/colors.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: 'AIzaSyCXub8cO-4Lq7v5uYWq1TblLITFKaSLqBg',
      appId: "1:870728263789:web:c1748784def26c748cf764",
      messagingSenderId: "870728263789",
      projectId: "instragram-clone-554ec",
      storageBucket: "instragram-clone-554ec.appspot.com",
    )); // New

  } else {
    await Firebase.initializeApp(); // New
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Intragram Clone',
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return ResponsiveLayout(
                    webScreenLayout: WebscreenLayout(),
                    mobileScreenLayout: MobileScreenLayout());
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }

            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
