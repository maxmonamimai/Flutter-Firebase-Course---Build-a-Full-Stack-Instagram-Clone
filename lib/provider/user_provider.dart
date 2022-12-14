import 'package:flutter/cupertino.dart';
import 'package:instragrame_flutter/models/user.dart';
import 'package:instragrame_flutter/resources/auth_method.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethod _authMethod = AuthMethod();
  
  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethod.getUserDetail();
    _user = user;
    notifyListeners();
  }
}