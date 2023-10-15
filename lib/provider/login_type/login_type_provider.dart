import 'package:flutter/widgets.dart';

class LoginTypeProvider extends ChangeNotifier {
  // Visitor =3
  // Admin =1
  // Member =2
  int loginType = 3;
  bool ?isLoading;

  void setLoginType({required int loginType}) {
    isLoading=true;
    notifyListeners();
    this.loginType = loginType;
    isLoading=false;
    notifyListeners();
  }
}
