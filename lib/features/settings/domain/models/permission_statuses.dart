enum PermissionStatus { unknown, granted, denied, unavailable }

class PermissionStatuses {
  const PermissionStatuses({
    this.notifications = PermissionStatus.unknown,
    this.microphone = PermissionStatus.unknown,
    this.biometric = PermissionStatus.unknown,
  });

  final PermissionStatus notifications;
  final PermissionStatus microphone;
  final PermissionStatus biometric;

  PermissionStatuses copyWith({
    PermissionStatus? notifications,
    PermissionStatus? microphone,
    PermissionStatus? biometric,
  }) =>
      PermissionStatuses(
        notifications: notifications ?? this.notifications,
        microphone: microphone ?? this.microphone,
        biometric: biometric ?? this.biometric,
      );

  String label(PermissionStatus status) => switch (status) {
        PermissionStatus.granted => 'Allowed',
        PermissionStatus.denied => 'Blocked',
        PermissionStatus.unavailable => 'Unavailable',
        PermissionStatus.unknown => 'Not requested',
      };
}
