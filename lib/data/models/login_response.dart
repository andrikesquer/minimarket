import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final bool Success;
  final bool Master;
  final String CompanyName;
  final String Email;
  final String LoginDate;
  final String IdSaas;
  final int IdCompany;
  final int IdSubscription;

  LoginResponse({
    required this.Success,
    required this.Master,
    required this.CompanyName,
    required this.Email,
    required this.LoginDate,
    required this.IdSaas,
    required this.IdCompany,
    required this.IdSubscription,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
