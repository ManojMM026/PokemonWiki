import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mypokedex/util/app_constants.dart';
import 'package:mypokedex/util/file_util.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';

showPictureNotification(RemoteMessage message) async {
  if (message == null) {
    return;
  }
  if (message.data != null && message.data.isNotEmpty) {
    String url = message.data["poke_image"];
    RemoteNotification notification = message.notification;

    String bigPicturePath = "";
    if (url != null || url.isNotEmpty) {
      bigPicturePath = await downloadAndSaveFile(
          url: message.data["poke_image"],
          fileName: url.replaceAll(AppConstants.pokemonImageUrl, ""));
    }
    print("Pokemon image: " + bigPicturePath);
    final String largeIconPath = bigPicturePath;
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),
            largeIcon: FilePathAndroidBitmap(largeIconPath),
            contentTitle: notification.title,
            htmlFormatContentTitle: true,
            summaryText: notification.body,
            htmlFormatSummaryText: true);
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'Poke desk API', 'Pokemon', 'Displaying Pokemon description',
            icon: "launch_background",
            styleInformation: bigPictureStyleInformation);
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(Random().nextInt(100),
        notification.title, notification.body, platformChannelSpecifics);
  }
}

showNotification(RemoteMessage message) {
  RemoteNotification notification = message.notification;
  flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channel.description,
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ));
}
