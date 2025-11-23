import 'package:firebase_messaging/firebase_messaging.dart';

/// Notification model that represents a push notification
class NotificationModel {
  final String? title;
  final String? body;
  final String? imageUrl;
  final Map<String, dynamic>? data;
  final DateTime receivedAt;

  NotificationModel({
    this.title,
    this.body,
    this.imageUrl,
    this.data,
    DateTime? receivedAt,
  }) : receivedAt = receivedAt ?? DateTime.now();

  /// Create NotificationModel from Firebase RemoteMessage
  factory NotificationModel.fromRemoteMessage(RemoteMessage message) {
    return NotificationModel(
      title: message.notification?.title,
      body: message.notification?.body,
      imageUrl: message.notification?.android?.imageUrl ??
          message.notification?.apple?.imageUrl,
      data: message.data,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'imageUrl': imageUrl,
      'data': data,
      'receivedAt': receivedAt.toIso8601String(),
    };
  }

  /// Create from JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'],
      body: json['body'],
      imageUrl: json['imageUrl'],
      data: json['data'] != null ? Map<String, dynamic>.from(json['data']) : null,
      receivedAt: DateTime.parse(json['receivedAt']),
    );
  }

  @override
  String toString() {
    return 'NotificationModel(title: $title, body: $body, receivedAt: $receivedAt)';
  }
}
