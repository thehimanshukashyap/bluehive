import 'package:flutter/widgets.dart';
import 'package:skype_clone/models/user.dart';
import 'package:skype_clone/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  UserInformation _user;
  AuthMethods _authMethods = AuthMethods();

  UserInformation get getUser => _user;

  Future<void> refreshUser() async {
    UserInformation user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
