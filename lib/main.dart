import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinity/data/local/cache_helper.dart';
import 'package:infinity/data/remote/helpers/fcm_token.dart';
import 'package:infinity/provider/admin_options/add_event/add_event_provider.dart';
import 'package:infinity/provider/admin_options/add_member/add_member_provider.dart';
import 'package:infinity/provider/admin_options/add_post/add_post_provider.dart';
import 'package:infinity/provider/admin_options/add_task/add_task_provider.dart';
import 'package:infinity/provider/authentication/login/admin_login_provider.dart';
import 'package:infinity/provider/authentication/login/member_login_provider.dart';
import 'package:infinity/provider/events/events_provider.dart';
import 'package:infinity/provider/home/home_provider.dart';
import 'package:infinity/provider/login_type/login_type_provider.dart';
import 'package:infinity/provider/navigator/navigator_provider.dart';
import 'package:infinity/provider/notifications/notification_provider.dart';
import 'package:infinity/provider/profile/profile_provider.dart';
import 'package:infinity/src/app_root.dart';
import 'package:infinity/views/committees/providers/committee_details_provider.dart';
import 'package:provider/provider.dart';

import 'config/firebase/notification_config.dart';

void main() async {
    init();
    runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider<NotificationProvider>(
            create: (_) => NotificationProvider().sendNotificationToUser
              (content: 'add new event now', title: 'Event'),
          ),
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
          ChangeNotifierProvider<AddTaskProvider>(
            create: (_) => AddTaskProvider(),
          ),
          ChangeNotifierProvider<CommitteeDetailsProvider>(create:(_) =>CommitteeDetailsProvider()),
        ],
        child: const AppRoot()));
}
Future<void> init()async{
  const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseConfig.init();
 // await Firebase.initializeApp();

  await CacheHelper.init();
}



