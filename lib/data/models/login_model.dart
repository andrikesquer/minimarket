import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginRequest {
  final String Email;
  final String Password;
  LoginRequest({required this.Email, required this.Password});
  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
