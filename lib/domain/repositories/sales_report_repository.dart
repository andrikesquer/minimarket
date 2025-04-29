import 'package:dio/dio.dart';
import 'package:pos2/core/services/api_reports.dart';
import 'package:pos2/data/models/report_request.dart';
import 'package:pos2/data/models/report_response.dart';

class ReportRepository {
  final ApiReports _apiReports;

  ReportRepository()
    : _apiReports = ApiReports(
        Dio(BaseOptions(contentType: "application/json")),
      );

  Future<List<ReportResponse>> reports(
    String idSa,
    int idCom,
    int idSub,
    String fIni,
    String fFin,
    int idSuc,
    int tRep,
    int tA,
    String idArts,
    int idClPr,
    bool cCont,
  ) async {
    final ReportRequest reportRequest = ReportRequest(
      idSa: idSa,
      idCom: idCom,
      idSub: idSub,
      fIni: fIni,
      fFin: fFin,
      idSuc: idSuc,
      tRep: tRep,
      tA: tA,
      idArts: idArts,
      idClPr: idClPr,
      cCont: cCont,
    );

    try {
      final List<ReportResponse> response = await _apiReports.getReports(
        idSa,
        idCom,
        idSub,
        fIni,
        fFin,
        idSuc,
        tRep,
        tA,
        idArts,
        idClPr,
        cCont,
      );
      // final List<ReportResponse> response = await _apiReports.getReports(
      //   reportRequest,
      // );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
