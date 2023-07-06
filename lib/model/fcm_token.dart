class FCMToken {
  FCMToken({
    required this.deviceId,
    required this.fcmId,
  });
  late final String deviceId;
  late final String fcmId;

  FCMToken.fromJson(Map<String, dynamic> json) {
    deviceId = json['device_id'];
    fcmId = json['fcm_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['device_id'] = deviceId;
    _data['fcm_id'] = fcmId;
    return _data;
  }
}
