import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:pos2/data/models/report_response.dart';

part 'api_reports.g.dart';

@RestApi(baseUrl: 'http://192.168.1.128:8080/api/reportes/')
abstract class ApiReports {
  factory ApiReports(Dio dio) = _ApiReports;
  @GET('ObtenerLibroGeneral')
  Future<List<ReportResponse>> getReports(
    @Query('idSa') String idSa,
    @Query('idCom') int idCom,
    @Query('idSub') int idSub,
    @Query('fIni') String fIni,
    @Query('fFin') String fFin,
    @Query('idSuc') int idSuc,
    @Query('tRep') int tRep,
    @Query('tA') int tA,
    @Query('idArts') String idArts,
    @Query('idClPr') int idClPr,
    @Query('cCont') bool cCont,
  );

  // factory ApiReports(Dio dio) = _ApiReports;
  // @GET('ObtenerLibroGeneral')
  // Future<List<ReportResponse>> getReports(@Body() ReportRequest request);
}
