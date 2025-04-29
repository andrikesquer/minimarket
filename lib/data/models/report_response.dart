import 'package:json_annotation/json_annotation.dart';

part 'report_response.g.dart';

@JsonSerializable()
class ReportResponse {
  final int ID_ZONA;

  final int ID_SUCURSAL;

  final int ID_TIPO;

  final int YEAR;

  final int MES;

  final int SEMANA;

  final int MOVIMIENTOS;

  final double VALOR;

  final double VALOR_USD;

  final bool FILIAL;

  final double CANTIDAD;

  final bool CANCELADO;

  ReportResponse({
    required this.ID_ZONA,
    required this.ID_SUCURSAL,
    required this.ID_TIPO,
    required this.YEAR,
    required this.MES,
    required this.SEMANA,
    required this.MOVIMIENTOS,
    required this.VALOR,
    required this.VALOR_USD,
    required this.FILIAL,
    required this.CANTIDAD,
    required this.CANCELADO,
  });

  factory ReportResponse.fromJson(Map<String, dynamic> json) =>
      _$ReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReportResponseToJson(this);
}
