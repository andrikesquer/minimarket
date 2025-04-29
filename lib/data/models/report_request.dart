import 'package:json_annotation/json_annotation.dart';

part 'report_request.g.dart';

@JsonSerializable()
class ReportRequest {
  final String idSa;

  final int idCom;

  final int idSub;

  final String fIni;

  final String fFin;

  final int idSuc;

  final int tRep;

  final int tA;

  final String idArts;

  final int idClPr;

  final bool cCont;

  ReportRequest({
    required this.idSa,
    required this.idCom,
    required this.idSub,
    required this.fIni,
    required this.fFin,
    required this.idSuc,
    required this.tRep,
    required this.tA,
    required this.idArts,
    required this.idClPr,
    required this.cCont,
  });

  // factory ReportRequest.fromJson(Map<String, dynamic> json) =>
  //     _$ReportRequestFromJson(json);
  //
  // Map<String, dynamic> toJson() => _$ReportRequestToJson(this);

  // Map<String, dynamic> toQueryParams() => {
  //   'idSa': idSa,
  //   'idCom': idCom,
  //   'idSub': idSub,
  //   'fIni': fIni,
  //   'fFin': fFin,
  //   'idSuc': idSuc,
  //   'tRep': tRep,
  //   'tA': tA,
  //   'idArts': idArts,
  //   'idClPr': idClPr,
  //   'cCont': cCont.toString(),
  // };
}
