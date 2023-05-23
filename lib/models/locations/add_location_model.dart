class AddLocationReqModel {
  AddLocationReqModel({
    required this.latitude,
    required this.longitude,
    required this.user_id,
    required this.locationName,
    required this.createdAt,
    required this.id,
    required this.isApproved,
  });

  double latitude;
  String id;
  String user_id;
  double longitude;
  String locationName;
  DateTime createdAt;
  bool isApproved;

  factory AddLocationReqModel.fromJson(Map<String, dynamic> json) {
    // logI("DDDD:${json["createdAt"].runtimeType}");
    if (json["createdAt"].runtimeType.toString().trim() == "Timestamp") {
      return AddLocationReqModel(
        id: json["id"],
        latitude: json["latitude"],
        user_id: json["user_id"],
        longitude: json["longitude"],
        locationName: json["locationName"],
        createdAt: json['createdAt'],
        isApproved: json["isApproved"],
      );
    } else {
      return AddLocationReqModel(
        id: json["id"],
        user_id: json["user_id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        locationName: json["locationName"],
        createdAt: DateTime.parse(json['createdAt']),
        isApproved: json["isApproved"],
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": user_id,
      "latitude": latitude,
      "longitude": longitude,
      "locationName": locationName,
      "createdAt": createdAt.toIso8601String(),
      "isApproved": isApproved,
    };
  }
}
