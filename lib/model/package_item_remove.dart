class PackageItemRemove {
  PackageItemRemove({
    required this.deviceId,
    required this.unitId,
  });
  late final String deviceId;
  late final String unitId;

  PackageItemRemove.fromJson(Map<String, dynamic> json) {
    deviceId = json['device_id'];
    unitId = json['unit_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['device_id'] = deviceId;
    _data['unit_id'] = unitId;
    return _data;
  }
}
