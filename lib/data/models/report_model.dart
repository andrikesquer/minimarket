import 'package:json_annotation/json_annotation.dart';

part 'report_model.g.dart';

@JsonSerializable()
class ReportModel {
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

  ReportModel({
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

  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportModelToJson(this);
}
