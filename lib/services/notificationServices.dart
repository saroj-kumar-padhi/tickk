import 'dart:convert';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:logger/logger.dart';

import '../models/stores_fcm.dart';

class PushNotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  Logger logger = Logger();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void inItLocalNotification(
      BuildContext context, RemoteMessage message) async {
    var androidInitialization =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initilizationSettings =
        InitializationSettings(android: androidInitialization);
    await flutterLocalNotificationsPlugin.initialize(
      initilizationSettings,
      onDidReceiveNotificationResponse: (payload) {},
    );
  }

  void showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(),
        'High Importance Notification',
        importance: Importance.max);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: 'your channel description',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      ticker: 'ticker',
      icon: '@mipmap/ic_launcher',
    );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    Future.delayed(Duration.zero, () {
      flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.title.toString(),
          notificationDetails);
    });
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      logger.i(message.notification!.title.toString());
      logger.i(message.notification!.body.toString());
      showNotification(message);
    });
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      Logger().d("user granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      Logger().d("user granted permission");
    } else {
      Logger().d("user deniee permission");
    }
  }

  static Future<String> getAccessToken() async {
    final Map<String, dynamic> serviceAccountJSon = {
      "type": "service_account",
      "project_id": "tickk-90b57",
      "private_key_id": "a09df61db2ef762e96934c651fbfa7b89a06bee1",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDgggcX65Q/lwQQ\nHlJ3iJ/u6nP/rM0JjDFzcLic1fdmGKOIxvjJ0rXqYBQQXhHi8XiDuOlpS6YqEb7f\nV99ElhUekS2XLCUVCGPFHcaAoklZ08LQ/2U2bEo+/ksNjSPJIDkMjOSZ/Tp8Kvdt\nsJW+Riu4AZlAoMe+tsstsWs6VL9PDfyFrk7X73+fpGN95870zIu/fn5gmFwdlgz6\nUCCkYfPN+F7ctQVouS6zMSAYmnt+H4ldslvtosbr2lDnkI1AIYkAswKvucFUfh9Y\n8V8exSS77gwoZq7N80yy65N1B5TWSr7I8XfzF6M3Jxi3MToiqcSalmGkpymbwQAW\nxMmNqFbnAgMBAAECggEAFd4kcbyFDqKXhzhk4PbCWUOl89fxisYIhQ2MNd6Tf/LT\nbv2uev4WsRMVsThwdpH9opruxU5Ui5F57YhCG4yg1v7eGXT30bIlAayySpJEIcdC\nGRhfU+s9WiBr0BCY1TzZwbKxi5xCR5jpy9ng5A0ysfQZ6NUgT5+/b55x6tcZYUo1\nRBne6wrFtZS5/yBTFjsEQcsLrjJ9BavqV4z5Qjwn9F34Z0DD5MWIAjCfdnGqknTH\n4YphI8Qc66Sl0prslRF0vy13PMZFsudX8nskC7IKza+j860d2NzoJ03HRDD8522I\na+/6MEdC7hVxvoXAzhPJmKteYTURKBdy69CcELd2yQKBgQDv5mltc0M/QwtK2Zyx\nKJVw00/2BKYEkG4lW+XnplJoep1zGqCqgcrPzvEjbO4nHfQ+DG1huAROpoGScQV0\n4qrlgxjPof9CIXLGxEPG7ggyIaXl9tTsvQCQumWNBrY6v8lcSvY+mzeTlLPTY6HE\nHd/sg3aFmzcMgnTTUVcD2uCc7wKBgQDvkywiyQtELWtBRbye2ST6m1x+ALRkvS6k\nPxi4WjjDTxtyS8mtO5zKBNlGrcDcpF7vERf0P431tDrUB06C8K5zLkTxai+9fjJF\nuBsdpBeKkLgsKAWiyVA28HxMF3vWbo4QPcKDQ3wTMJ8w4ACo5YtQ4itY4Cx29tMP\n5/8m4DdViQKBgQDdPgmMvvgNp68KYJZ5a4wmeTsNEExreSebnJzyfhkR8cKzHKN/\nnCOGcrtAiH055g4SCzP1ItgWEMj+XO1DVqd08uo20peuTVqkpOw80dkNIqr04iaM\nDeIvlzeAT+hPVgBF9XwTUOJ4YHNXSFMvor2YScVMglDKYKWNHT66d2keUQKBgBJ0\nC5pCUhPWS8SjUnwJzcdf4Cf0dfCsgcM0+Pp6OJUSqtKK8+XcCZ+l7/Z5u7lDD+zq\nLCYsHwsl7sIWLf33+/fzQGw3+aVm6whjvfLyiL2rmAQOsSBw0TTqISjbRjamHVsy\n5qCluhDgVeK13lckFy8LvLsDyWkAahF3lTexXZHBAoGBAOxPZTWlqDpxvIauDxW6\nB2XlEpWoUneoMy2EWG6l1mrVg0e2QtPDA7TQz6+rIgkl17LgA38SVyY/UGSD+FHN\nQdsXQKNdAdH5Dlt3aiAx7SuPKi8Pv3FV7OwfsqH+/gXTl2GZ5MmGmgVp03jifSyA\niVHFRfhqCdlhF+NOjp0teIHp\n-----END PRIVATE KEY-----\n",
      "client_email":
          "tickk-notification-service@tickk-90b57.iam.gserviceaccount.com",
      "client_id": "112307603954970955398",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/tickk-notification-service%40tickk-90b57.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    var client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJSon),
      scopes,
    );

    // Get access token
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccountJSon),
            scopes,
            client);

    client.close();

    return credentials.accessToken.data;
  }

  static Future<void> sendNotification(
      List<dynamic> deviceTokens, BuildContext context, String data) async {
    Logger().f(deviceTokens);
    final String serverKey = await getAccessToken();
    String endpointFirebaseCloudMessaging =
        'https://fcm.googleapis.com/v1/projects/tickk-90b57/messages:send';

    for (String token in deviceTokens) {
      final Map<String, dynamic> message = {
        'message': {
          'token': token,
          'notification': {'title': data, 'body': 'Test message'},
          'data': {
            'tripID': '123',
          }
        }
      };

      final http.Response response = await http.post(
        Uri.parse(endpointFirebaseCloudMessaging),
        headers: <String, String>{
          "Content-Type": 'application/json',
          "Authorization": 'Bearer $serverKey'
        },
        body: jsonEncode(message),
      );

      if (response.statusCode == 200) {
        Logger().d('Notification sent successfully to token: $token');
      } else {
        Logger().d('Failed to send notification to token: $token');
        Logger().d('Status code: ${response.statusCode}');
        Logger().d('Response body: ${response.body}');
      }
    }
  }

  static Future<void> sendNotificationtoBuyer(
      String deviceTokens, BuildContext context, String data) async {
    final String serverKey = await getAccessToken();
    String endpointFirebaseCloudMessaging =
        'https://fcm.googleapis.com/v1/projects/tickk-90b57/messages:send';

    final Map<String, dynamic> message = {
      'message': {
        'token': deviceTokens,
        'notification': {'title': data, 'body': 'Test message'},
        'data': {
          'tripID': '123',
        }
      }
    };

    final http.Response response = await http.post(
      Uri.parse(endpointFirebaseCloudMessaging),
      headers: <String, String>{
        "Content-Type": 'application/json',
        "Authorization": 'Bearer $serverKey'
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      Logger().d('Notification sent successfully to token: $deviceTokens');
    } else {
      Logger().d('Failed to send notification to token: $deviceTokens');
      Logger().d('Status code: ${response.statusCode}');
      Logger().d('Response body: ${response.body}');
    }
  }
}
