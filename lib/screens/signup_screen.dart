import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instragrame_flutter/resources/auth_method.dart';
import 'package:instragrame_flutter/screens/login_screen.dart';
import 'package:instragrame_flutter/utils/colors.dart';
import 'package:instragrame_flutter/utils/utils.dart';
import 'package:instragrame_flutter/widgets/text_field_input.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/respnsive_layout_screen.dart';
import '../responsive/webscreenlayout.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im as Uint8List?;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethod().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!);

    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const ResponsiveLayout(
          webScreenLayout: WebscreenLayout(),
          mobileScreenLayout: MobileScreenLayout(),
        ),
      ));
    }

    setState(() {
      _isLoading = false;
    });
  }

  void navigateToLogin() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LoginScreen(),
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
            // cicular widget to accept amd show our selected file
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64, backgroundImage: MemoryImage(_image!))
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            "https://thumbs.dreamstime.com/b/default-avatar-profile-vector-user-profile-default-avatar-profile-vector-user-profile-profile-179376714.jpg"),
                      ),
                Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                        onPressed: selectImage, icon: Icon(Icons.add_a_photo)))
              ],
            ),
            SizedBox(
              height: 24,
            ),
            // Text Filed for username
            TextFieldInput(
                textEditingController: _usernameController,
                hintText: 'Enter your username',
                textInputType: TextInputType.text),
            SizedBox(
              height: 24,
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
            TextFieldInput(
                textEditingController: _bioController,
                hintText: 'Enter your bio',
                textInputType: TextInputType.text),
            SizedBox(
              height: 24,
            ),
            // button to login
            InkWell(
              onTap: signUpUser,
              child: Container(
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : const Text('Sign up'),
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
                    onTap: () {},
                    child: Container(
                      child: Text("have an account? "),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: GestureDetector(
                    onTap: navigateToLogin,
                    child: Container(
                      child: Text(
                        "Login",
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
