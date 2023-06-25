import 'package:flutter/widgets.dart';

class LoginTypeProvider extends ChangeNotifier {
  bool isAdmin = false;
  bool ?isLoading;

  void setISAdmin({required bool isAdmin}) {
    isLoading=true;
    notifyListeners();
    this.isAdmin = isAdmin;
    isLoading=false;
    notifyListeners();
  }
}
