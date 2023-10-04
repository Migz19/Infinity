import 'dart:convert';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'dart:io' show Directory, File, Platform;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../../core/utils/app_constants.dart';
import '../../data/remote/helpers/fcm_token.dart';

class FirebaseConfig {
  static Future<void> init() async {
    await Firebase.initializeApp();
    FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    AppConstants.fcmToken =
        (await FirebaseMessaging.instance.getToken()).toString();

    print("FCM Token11 : ${AppConstants.fcmToken}");
    getFCMToken(token:AppConstants.fcmToken );
    FirebaseMessaging.onMessage.listen((event) {
      String? imageUrl;
      if (event.notification != null) {
        if (Platform.isIOS) {
          if (event.notification!.apple != null)
            imageUrl = event.notification!.apple!.imageUrl ?? "";
        } else if (Platform.isAndroid) {
          if (event.notification!.android != null)
            imageUrl = event.notification!.android!.imageUrl ?? "";

        }
        print("imageUrl ${imageUrl}");
      }

      showNotification(
          id: 0,
          body: event.notification!.body!,
          title: event.notification!.title.toString(),
          payload: imageUrl ?? "");
    });
  }

  //foreground
  static final FlutterLocalNotificationsPlugin _notification =
  FlutterLocalNotificationsPlugin();

  static Future<void> showNotification({
    int id = 0,
    required String title,
    required String body,
    required String payload,
  }) async {
    File? file;
    await _pluginInit();
    BigPictureStyleInformation? bigPictureStyleInformation;
    if (payload.isNotEmpty) {
      if (Platform.isIOS) {
        file = await urlToFile(payload);
      }
      final http.Response response = await http.get(Uri.parse(payload));
      bigPictureStyleInformation = BigPictureStyleInformation(
        ByteArrayAndroidBitmap.fromBase64String(
            base64Encode(response.bodyBytes)),
        largeIcon: ByteArrayAndroidBitmap.fromBase64String(
            base64Encode(response.bodyBytes)),
      );
    }

    _notification.show(
      id,
      title,
      body,
      await _notificationDetails(
          styleInformation: bigPictureStyleInformation, payload: file),
    );
  }

  static Future<File> urlToFile(String imageUrl) async {
// generate random number.
    var rng = new Random();
// get temporary directory of device.
    Directory tempDir = await getTemporaryDirectory();
// get temporary path from temporary directory.
    String tempPath = tempDir.path;
// create a new file in temporary path with random file name.
    File file = new File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
// call http.get method and pass imageUrl into it to get response.
    http.Response response = await http.get(Uri.parse(imageUrl));
// write bodyBytes received in response to file.
    await file.writeAsBytes(response.bodyBytes);
// now return the file which is created with random name in
// temporary directory and image bytes from response is written to // that file.
    return file;
  }

  void notificationTapBackground(NotificationResponse notificationResponse) {
    // handle action
  }

  static Future _notificationDetails(
      {BigPictureStyleInformation? styleInformation, File? payload}) async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: styleInformation,
      ),
      iOS: DarwinNotificationDetails(
          categoryIdentifier: 'plain category',
          attachments: [
            if (payload != null) DarwinNotificationAttachment(payload.path)
          ]),
    );
  }

  static Future<void> _pluginInit() async {
    if (Platform.isAndroid) {
      //request permission
      _notification
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()!
          .requestPermission();
    } else if (Platform.isIOS) {
      _notification
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()!
          .requestPermissions();
    }
    //init settings (ios,android)
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings("@mipmap/ic_launcher");
    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await _notification.initialize(initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,);
  }

  static void _onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
    // );
  }

  static void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
  }
  static Future<void> getFCMToken({required String token}) async {


    if (token != null) {
      // Use the token for sending push notifications to this device
      print('FCM Token: $token');
      await FCMToken().addToken(fcmToken: token);
    } else {
      print('Unable to get FCM token.');
    }
  }
}
