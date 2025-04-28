import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:pos2/data/models/report_model.dart';

part 'api_reports.g.dart';

@RestApi(baseUrl: 'http://192.168.1.128:8080/api/reportes/')
abstract class ApiReports {
  factory ApiReports(Dio dio) = _ApiReports;

  @GET(
    'ObtenerLibroGeneral?idSa=19cf4bcd-c52c-41bf-9fc8-b1f3d91af2df&idCom=2&idSub=10&fIni=01/01/2025&fFin=31/01/2025&idSuc=1&tRep=1&tA=2&idArts=&idClPr=0&cCont=false',
  )
  Future<List<ReportModel>> getReports();
}
