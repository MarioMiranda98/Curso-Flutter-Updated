part of 'notifications_bloc.dart';

sealed class NotificationsEvent extends Equatable {
  const NotificationsEvent();
}

class NotificationStatusChanged extends NotificationsEvent {
  const NotificationStatusChanged({required this.status});

  final AuthorizationStatus status;

  @override
  List<Object?> get props => [];
}

class NotificationReceived extends NotificationsEvent {
  const NotificationReceived({required this.notification});

  final PushMessageEntity notification;

  @override
  List<Object?> get props => [];
}
