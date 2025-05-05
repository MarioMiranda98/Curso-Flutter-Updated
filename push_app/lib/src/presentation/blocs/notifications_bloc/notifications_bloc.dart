import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:push_app/firebase_options.dart';
import 'package:push_app/src/config/local_notifications/local_notifications.dart';
import 'package:push_app/src/domain/entities/push_message_entity.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

Future<void> firebaseMessagingBackgorundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  int pushNumberId = 0;

  NotificationsBloc({required this.requestLocalNoticiationsPermissions})
    : super(const NotificationsState()) {
    on<NotificationStatusChanged>(_notificationStatusChanged);
    on<NotificationReceived>(_onNotificationReceived);
    _initialStatusCheck();
    _onForegroundMessage();
  }

  final Future<void> Function() requestLocalNoticiationsPermissions;

  static Future<void> initializaFirebaseNotifications() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await requestLocalNoticiationsPermissions();
    add(NotificationStatusChanged(status: settings.authorizationStatus));
  }

  void _getFCMToken() async {
    final settings = await messaging.getNotificationSettings();

    if (settings.authorizationStatus != AuthorizationStatus.authorized) return;

    final token = await messaging.getToken();

    print(token);
  }

  void handleRemoteMessage(RemoteMessage message) {
    if (message.notification == null) return;

    final notification = PushMessageEntity(
      messageId:
          message.messageId?.replaceAll(':', '').replaceAll('%', '') ?? '',
      title: message.notification!.title ?? '',
      body: message.notification!.body ?? '',
      sentDate: message.sentTime ?? DateTime.now(),
      data: message.data,
      imageUrl:
          Platform.isAndroid
              ? message.notification?.android?.imageUrl
              : message.notification?.apple?.imageUrl,
    );

    LocalNotifications.showLocalNotification(
      id: ++pushNumberId,
      title: notification.title,
      body: notification.body,
      data: notification.data.toString(),
    );

    add(NotificationReceived(notification: notification));
  }

  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

  void _initialStatusCheck() async {
    final settings = await messaging.getNotificationSettings();
    add(NotificationStatusChanged(status: settings.authorizationStatus));
  }

  void _notificationStatusChanged(
    NotificationStatusChanged event,
    Emitter<NotificationsState> emit,
  ) {
    emit(state.copyWith(status: event.status));
    _getFCMToken();
  }

  void _onNotificationReceived(
    NotificationReceived event,
    Emitter<NotificationsState> emit,
  ) {
    final newList = [...state.notifications, event.notification];
    emit(state.copyWith(notifications: newList));
  }

  PushMessageEntity? getMessageById(String pushMessageId) {
    final exist = state.notifications.any((m) => m.messageId == pushMessageId);

    if (!exist) return null;

    return state.notifications.firstWhere((m) => m.messageId == pushMessageId);
  }
}
