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
      "private_key_id": "c97ce25b0a6fca0e749d0f5d67b0a6693990eea9",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDU8ctVej/Zse7c\noy5VpXRocYOp8FzRh+9VOT1o3Un33izuKRBhIjo3aknpI8Osh1ZnsjJUrC5+2ww+\nZNpb8Q/boKLWLv3ToNpwNTqvhZstRarA6sMHlXVIAFuYHB5hev41ooiKvAF1lY7l\nBTi2EQ/0DWvOUVNY2zfDmGaq0cNfTj/JO77B9CsL8ADWq/KAIwbdvm6cGkFfW7O9\n3Fchf3gDTvABME4Lux0FvDO6Vpm32CYORZOOvVr8qNulGNGYZZClpc5HBziNm2rv\nCf24nl54Vx0mwGzsIdrV17IN41hvPsEdH2Y9XzsFcTQ3+gRtn3ax+qVUP9J7nyo9\nLAYpYDYvAgMBAAECggEAVVWcTWHTKpMijKqcC9hlIOG0iKp5F8Kox3dLw7VCSiFv\n0fUEylgkCkb+3X3mkUIe/ykrAEGL1GxFqM9TrhqZZ0MlXj2wnFlOkD7UiLg66laL\nygmKJIThXfw+uGM0TY4zRx0eKLKUxyErBV4lTtjhksS6GhD/HJGk9C4jnnq3F36R\nvTasTZsCFvaA4x3U3ik1+GZJ/n5TV8fA2wKkTZUpT2GKDKSiCBvUuKX9oGfwhIJj\nlutnXsT/C2YIURJyl/JYBC4UXnZYrgQhVaEVPhY9NvQm0oDAEyDm+D0R9hEKKKu5\ndrnFlRH8sw28ilKqqt9O1fkhz6jIdu6kEw450kAj4QKBgQD0pbsOUim3iP8Ao/nl\n/K+qfagKFU1xszfJ9BVS50z/Stv1ZdBFuJo9OrQrp1ayjdXPJy5qWNSq2dmAmDDs\nM5UBhADfHgrcCgMw3dE4xzWNzITjJk71x1lKIV8zviyBjnlhRowexzurOTQpC+oz\n9wIhJRxOzDYOiMk0K5JlKUbvcQKBgQDe03Om1ScQ0VrNW8ZBdlbjD6NtG0WLx5kk\nD7YU+y83iIgZAf2f19y4kHON2wOPHqxz6wxMpCjyGoOZt2cQ37Flg5Y1xp3CjsHn\naQ2KR9OYvOK2PNfeGTkcC3yYXYHKfd+ajZVVN4FdWpPl9xJyPPy+/x6xht9VRxK3\nt3Op07fvnwKBgHN8nK2o+YprQD00Ku53dxFbWezQm4tV17sc3sgQ6hcFZooUMtoG\nx8Cpqo2E4/dL3yd3zoBjSJkSV4tNzKJjwy5A+wxYKTYv/8ucmnxcBZrXdc+osNNy\n9GJ7GG7bkjTiZcgWvmR1FmTAjy/lMPyw2K9+zjsgSVBZH+nhu6zHbHXxAoGBANxC\nTJnnLVyUdZt1Un43CiAcv0EEqjRHsvtQhH4s5TmRvmZp71jnugi+0Vqx2czJV1Km\nT1wbEVZwGxIBluG5HNPpxLuXfy5oiwfCcl30LhdW7wuRDRk/+ZHdUOYT2E5fKn7N\n4YWA/mFXPccd+Z/u5S+vY5m8ZlsXjEsKDk0bOUClAoGBALw3IWxtFqeEJDkNwXos\nBKwNqPo5IQzzmD5O03FS1TcypsJdKq9YYkvuH7D9pjizC4Cd5SnK+C7e3Zv1QZMS\npI/vBqVX/sVRVRW4tTHZ3H/ohhrkspi7WZOzF97JSVQcH0xxrdsZEjLvsO6zT0AW\nCOLhjCSsz+jnn8QxQ1ukr3M5\n-----END PRIVATE KEY-----\n",
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
}
