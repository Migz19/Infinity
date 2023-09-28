import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/app_constants.dart';


class NotificationBaseHelper {
  static final String _baseUrl = AppConstants.baseNotificationUrl;


  static Future<dynamic> post({required Map<String, dynamic>? body}) async {
    var responseJson;
    try {
      print("Calling [Notification POST] " + _baseUrl);
      final response = await http.post(
        Uri.parse(_baseUrl),
        body: jsonEncode(body),
        headers: {
          "Authorization":
              "key=${AppConstants.SERVER_KEY}",
          "Content-Type": "application/json"
        },
      );
      print('Api posted and received data!');
      print(responseJson.toString());
      return responseJson;
    } catch (error) {
      print("notification error " + error.toString());
    }
  }

  static Future<void> sendNotificationToUsers(
      {required String content,
        required String title,
        required String image,
        required List<String> listOfTokens}) async {
    await http
        .post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=${AppConstants.SERVER_KEY}',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': content,
            'title': title,
            "image": image,
            "android": {
              "image_url": image,
            },
            "apple": {
              "image_url": image,
            },
          },

          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'type': title,
            //'chat_user_id': sender!.id,
            'id': '1',
            'status': 'done',
            "image_url": image,
          },

          //'to': 'e1K2qjxDTxOw6FkhnEpx_L:APA91bFSVg0y1HoN00iYLFC_OCWdXEciOvdRgx798vEdLGKG7KBDuQ8LT6iSCqzfz4TF2Z6_RNOUlYgNyBrH6un0J8x3VMIACWG_hzZpw0i0eQ77rjkLotnRaUl5NK6VB9VXXnDX3lIc',
          'registration_ids': listOfTokens,

          'fcm_options':{
            "image":image,
          },
        },
      ),
    )
        .then((value) => debugPrint(value.body.toString()));
  }
}
