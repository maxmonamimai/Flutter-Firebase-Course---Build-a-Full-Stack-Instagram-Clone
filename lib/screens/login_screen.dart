import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instragrame_flutter/resources/auth_method.dart';
import 'package:instragrame_flutter/screens/signup_screen.dart';
import 'package:instragrame_flutter/utils/colors.dart';
import 'package:instragrame_flutter/utils/utils.dart';
import 'package:instragrame_flutter/widgets/text_field_input.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/respnsive_layout_screen.dart';
import '../responsive/webscreenlayout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethod().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (res == 'success') {
      //
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const ResponsiveLayout(
          webScreenLayout: WebscreenLayout(),
          mobileScreenLayout: MobileScreenLayout(),
        ),
      ));
    } else {
      //
      showSnackBar(res, context);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignup() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SignupScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(),
              flex: 2,
            ),
            // SVG image
            SvgPicture.network(
              'https://raw.githubusercontent.com/RivaanRanawat/instagram-flutter-clone/master/assets/ic_instagram.svg',
              color: primaryColor,
              height: 64,
            ),
            SizedBox(
              height: 45,
            ),
            // text field for email
            TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress),
            SizedBox(
              height: 24,
            ),
            // text field for password
            TextFieldInput(
              textEditingController: _passwordController,
              hintText: 'Enter your password',
              textInputType: TextInputType.text,
              isPass: true,
            ),
            SizedBox(
              height: 24,
            ),
            // button to login
            InkWell(
              onTap: loginUser,
              child: Container(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text('Log in'),
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    color: blueColor),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Flexible(
              child: Container(),
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: InkWell(
                    child: Container(
                      child: Text("Don't have an account? "),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: GestureDetector(
                    onTap: navigateToSignup,
                    child: Container(
                      child: Text(
                        "Sign up",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            )
            //transitioning tp signing up
          ],
        ),
      )),
    );
  }
}
