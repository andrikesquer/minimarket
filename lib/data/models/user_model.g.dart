// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      Success: json['Success'] as bool,
      Master: json['Master'] as bool,
      CompanyName: json['CompanyName'] as String,
      Email: json['Email'] as String,
      LoginDate: json['LoginDate'] as String,
      IdSaas: json['IdSaas'] as String,
      IdCompany: (json['IdCompany'] as num).toInt(),
      IdSubscription: (json['IdSubscription'] as num).toInt(),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'Success': instance.Success,
      'Master': instance.Master,
      'CompanyName': instance.CompanyName,
      'Email': instance.Email,
      'LoginDate': instance.LoginDate,
      'IdSaas': instance.IdSaas,
      'IdCompany': instance.IdCompany,
      'IdSubscription': instance.IdSubscription,
    };
