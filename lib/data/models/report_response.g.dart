// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportResponse _$ReportResponseFromJson(Map<String, dynamic> json) =>
    ReportResponse(
      ID_ZONA: (json['ID_ZONA'] as num).toInt(),
      ID_SUCURSAL: (json['ID_SUCURSAL'] as num).toInt(),
      ID_TIPO: (json['ID_TIPO'] as num).toInt(),
      YEAR: (json['YEAR'] as num).toInt(),
      MES: (json['MES'] as num).toInt(),
      SEMANA: (json['SEMANA'] as num).toInt(),
      MOVIMIENTOS: (json['MOVIMIENTOS'] as num).toInt(),
      VALOR: (json['VALOR'] as num).toDouble(),
      VALOR_USD: (json['VALOR_USD'] as num).toDouble(),
      FILIAL: json['FILIAL'] as bool,
      CANTIDAD: (json['CANTIDAD'] as num).toDouble(),
      CANCELADO: json['CANCELADO'] as bool,
    );

Map<String, dynamic> _$ReportResponseToJson(ReportResponse instance) =>
    <String, dynamic>{
      'ID_ZONA': instance.ID_ZONA,
      'ID_SUCURSAL': instance.ID_SUCURSAL,
      'ID_TIPO': instance.ID_TIPO,
      'YEAR': instance.YEAR,
      'MES': instance.MES,
      'SEMANA': instance.SEMANA,
      'MOVIMIENTOS': instance.MOVIMIENTOS,
      'VALOR': instance.VALOR,
      'VALOR_USD': instance.VALOR_USD,
      'FILIAL': instance.FILIAL,
      'CANTIDAD': instance.CANTIDAD,
      'CANCELADO': instance.CANCELADO,
    };
