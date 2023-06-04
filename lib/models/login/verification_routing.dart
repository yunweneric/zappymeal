import 'dart:convert';

VerificationRoutingResponse verificationRoutingResponseFromJson(String str) => VerificationRoutingResponse.fromJson(json.decode(str));

String verificationRoutingResponseToJson(VerificationRoutingResponse data) => json.encode(data.toJson());

class VerificationRoutingResponse {
  VerificationRoutingResponse({
    required this.id,
    required this.code,
  });

  String id;
  String code;

  factory VerificationRoutingResponse.fromJson(Map<String, dynamic> json) => VerificationRoutingResponse(
        id: json["id"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
      };
}
