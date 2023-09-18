import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinity/data/local/cache_helper.dart';
import 'package:infinity/provider/admin_options/add_event/add_event_provider.dart';
import 'package:infinity/provider/admin_options/add_member/add_member_provider.dart';
import 'package:infinity/provider/admin_options/add_post/add_post_provider.dart';
import 'package:infinity/provider/authentication/login/admin_login_provider.dart';
import 'package:infinity/provider/authentication/login/member_login_provider.dart';
import 'package:infinity/provider/events/events_provider.dart';
import 'package:infinity/provider/home/home_provider.dart';
import 'package:infinity/provider/login_type/login_type_provider.dart';
import 'package:infinity/provider/navigator/navigator_provider.dart';
import 'package:infinity/provider/profile/profile_provider.dart';
import 'package:infinity/src/app_root.dart';
import 'package:infinity/views/committees/providers/committee_details_provider.dart';
import 'package:provider/provider.dart';

void main() async {
    await const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await CacheHelper.init();
    runApp(
        MultiProvider(
        providers: [
          ChangeNotifierProvider<HomeProvider>(
            create: (_) => HomeProvider(),
          ),
          ChangeNotifierProvider<MemberLoginProvider>(
            create: (_) => MemberLoginProvider(),
          ),
            ChangeNotifierProvider<LoginTypeProvider>(
                create: (_) => LoginTypeProvider(),
            ),
          ChangeNotifierProvider<HomeProvider>(
            create: (_) => HomeProvider(),
          ),
          ChangeNotifierProvider<ProfileProvider>(
            create: (_) => ProfileProvider(),
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
          ChangeNotifierProvider<AddPostProvider>(
            create: (_) => AddPostProvider(),
          ),
          ChangeNotifierProvider<AddEventProvider>(
            create: (_) => AddEventProvider(),
          ),
          ChangeNotifierProvider<EventsProvider>(
            create: (_) => EventsProvider(),
          ),
          ChangeNotifierProvider<CommitteeDetailsProvider>(create:(_) =>CommitteeDetailsProvider()),
        ],
        child: const AppRoot()));
}


