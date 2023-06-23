import 'package:flutter/widgets.dart';

class LoginTypeProvider extends ChangeNotifier {
  bool isAdmin = false;

  void setISAdmin({required bool isAdmin}) {
    this.isAdmin = isAdmin;
    notifyListeners();
  }
}
