class NotificationsEntity {
  final String message;
  final String status;
  final String notificationType;
  final String createdAt;
  final String senderName;
  final String senderEmail;

  NotificationsEntity({
    required this.message,
    required this.status,
    required this.notificationType,
    required this.createdAt,
    required this.senderName,
    required this.senderEmail,
  });
}
