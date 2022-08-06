import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instragrame_flutter/models/user.dart' as model;
import 'package:instragrame_flutter/resources/storage_method.dart';

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetail() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap = await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  // Sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        // register User
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(cred.user!.uid);

        String photoUrl = await StorageMethod()
            .uploadImageToStorage('profilePics', file, false);

        // Add user to database

        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
          followers: [],
          folowing: [],
          photoUrl: photoUrl,
        );

        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );

        res = "success";
      }
    }

    // on FirebaseAuthException catch (err) {
    //   if (err.code == 'invalid-email') {
    //     res = 'The email is badly formatted.';
    //   } else if(err.code == 'weak-password') {
    //     res = 'Password should be at least 6 charactor';
    //   }
    // }

    catch (err) {
      res = err.toString();
    }

    return res;
  }

  // Login User
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occourse";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all the field";
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }
}
