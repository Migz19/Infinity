import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinity/data/local/cache_helper.dart';
import 'package:infinity/provider/admin_options/add_member/add_member_provider.dart';
import 'package:infinity/provider/authentication/login/admin_login_provider.dart';
import 'package:infinity/provider/home/home_provider.dart';
import 'package:infinity/provider/login_type/login_type_provider.dart';
import 'package:infinity/provider/navigator/navigator_provider.dart';
import 'package:infinity/src/app_root.dart';
import 'package:provider/provider.dart';

void main() async {
    await SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await CacheHelper.init();
    runApp(
        MultiProvider(
        providers: [
          ChangeNotifierProvider<HomeProvider>(
            create: (_) => HomeProvider(),
          ),
            ChangeNotifierProvider<LoginTypeProvider>(
                create: (_) => LoginTypeProvider(),
            ),
          ChangeNotifierProvider<NavigatorProvider>(
            create: (_) => NavigatorProvider(),
          ),
            ChangeNotifierProvider<AdminLoginProvider>(
                create: (_) => AdminLoginProvider(),
            ),
          ChangeNotifierProvider<AddMemberProvider>(
            create: (_) => AddMemberProvider(),
          ),
        ],
        child: const AppRoot()));
}

