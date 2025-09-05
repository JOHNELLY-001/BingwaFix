import 'package:flutter/material.dart';
import '../model/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners(); //Tells the app to refresh when the user changes
  }

}