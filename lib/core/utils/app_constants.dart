class AppConstants{
  static String fcmToken='';
  static const String baseNotificationUrl =
      "https://fcm.googleapis.com/fcm/send";
  static const String SERVER_KEY ='AAAAAeqQr-k:APA91bGhnwV3SZvIW6UghwIhoSt-WRbMAD8U-G7yRE47uU3U-0F7P76GKG1PWq8ZGNldUfVJC30sgm5r4dZ8TzMyFlWKu2BT9ecEpFghYgVT1ONHOusF6-RUdhibr-nMiqyRml5Wj1SO';

  /// Firebase
  /// st stands for cloud storage
  static String adminPermission='firebase-admin';
  static String stPostPath='post-images';
  static String stProfilePath='profile-images';
  static String stEventPath='event-images';
  /// st stands for firestore
  static String fsPostPath='posts';
  static String fsAdminPath='admin';
  static String fsEventPath='events';
  static String fsMemberPath='users';


  /// Warning and error messages
  static String noDataCheckConnection="No data found \n Please check your internet connection and try again";

}