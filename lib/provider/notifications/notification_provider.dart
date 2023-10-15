
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:infinity/core/utils/app_constants.dart';

class NotificationProvider extends ChangeNotifier
{



   sendNotificationToUser({required String content,required String title}) async{

    await http.post(
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
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'type': title,
            //'chat_user_id': sender!.id,
            'id': '1',
            'status': 'done'
          },
          'to': 'e1K2qjxDTxOw6FkhnEpx_L:APA91bFSVg0y1HoN00iYLFC_OCWdXEciOvdRgx798vEdLGKG7KBDuQ8LT6iSCqzfz4TF2Z6_RNOUlYgNyBrH6un0J8x3VMIACWG_hzZpw0i0eQ77rjkLotnRaUl5NK6VB9VXXnDX3lIc',
          // 'registration_ids':[
          //   'iIk1t9mTha7bi0eJZ-cZE:APA91bFzojeYTkAb39maHzoFTMjbRSd6rzNgbK9TiyG1Pda9muWrTcYjDupefyTl5DHj4C5GFSfXuu99C7WH8kPWzZYQx9t6L5IKIXPu_3nZbcPyfjygsWjgNvx34FyqckFq3PGLS7ww',
          //   'iIk1t9mTha7bi0eJZ-cZE:APA91bFzojeYTkAb39maHzoFTMjbRSd6rzNgbK9TiyG1Pda9muWrTcYjDupefyTl5DHj4C5GFSfXuu99C7WH8kPWzZYQx9t6L5IKIXPu_3nZbcPyfjygsWjgNvx34FyqckFq3PGLS7ww',
          //   'iIk1t9mTha7bi0eJZ-cZE:APA91bFzojeYTkAb39maHzoFTMjbRSd6rzNgbK9TiyG1Pda9muWrTcYjDupefyTl5DHj4C5GFSfXuu99C7WH8kPWzZYQx9t6L5IKIXPu_3nZbcPyfjygsWjgNvx34FyqckFq3PGLS7ww',
          //
          // ]
        },
      ),
    )
        .then((value) => debugPrint(value.body.toString()));
  }
}