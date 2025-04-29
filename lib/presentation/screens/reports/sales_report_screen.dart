import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/core/services/api_reports.dart';
import 'package:pos2/data/models/report_response.dart';
import 'package:pos2/domain/repositories/sales_report_repository.dart';
import 'package:pos2/presentation/providers/sales_report_provider.dart';
import 'package:pos2/presentation/screens/reports/widgets/sales_report/filters.dart';
import 'package:pos2/presentation/screens/reports/widgets/sales_report/sales_report_app_bar.dart';

class SalesReport extends ConsumerStatefulWidget {
  const SalesReport({super.key});

  @override
  ConsumerState<SalesReport> createState() => _SalesReportState();
}

class _SalesReportState extends ConsumerState<SalesReport> {
  final ReportRepository reportRepository = ReportRepository();

  List<ReportResponse> reports = [];

  int startYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    final bool isFiltering = ref.watch(isFilteringProvider);

    return SafeArea(
      child: Scaffold(
        appBar: SalesReportAppBar(),
        body: isFiltering ? Filters(startYear: startYear) : _body(startYear),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (isFiltering) {
              _getReports('01/01/2025', '31/01/2025');
              ref.watch(isFilteringProvider.notifier).toggleFiltering();
            }
          },
          tooltip: 'Buscar',
          elevation: 5,
          child: const Icon(Icons.search),
        ),
      ),
    );
  }

  void _getReports(String fIni, String fFin) async {
    try {
      final List<ReportResponse> reports = await reportRepository.reports(
        '19cf4bcd-c52c-41bf-9fc8-b1f3d91af2df',
        2,
        10,
        fIni,
        fFin,
        1,
        1,
        2,
        '',
        0,
        false,
      );
      debugPrint('Reports');
      print(reports.length);
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    }
  }

  FutureBuilder _body(startYear) {
    final ApiReports apiReports = ApiReports(
      Dio(BaseOptions(contentType: "application/json")),
    );

    // ReportRequest request = ReportRequest(
    //   idSa: '19cf4bcd-c52c-41bf-9fc8-b1f3d91af2df',
    //   idCom: 2,
    //   idSub: 10,
    //   fIni: '01/01/2025',
    //   fFin: '31/01/2025',
    //   idSuc: 1,
    //   tRep: 1,
    //   tA: 2,
    //   idArts: '',
    //   idClPr: 0,
    //   cCont: false,
    // );

    return FutureBuilder(
      future: apiReports.getReports(
        '19cf4bcd-c52c-41bf-9fc8-b1f3d91af2df',
        2,
        10,
        '01/01/2025',
        '31/03/2025',
        1,
        1,
        2,
        '',
        0,
        false,
      ),

      // future: apiReports.getReports(request),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<ReportResponse> reports = [];
          if (snapshot.hasData) {
            reports = snapshot.data;
          }
          return _reports(reports, startYear);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _reports(List<ReportResponse> reports, startYear) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView.builder(
        itemCount: reports.length,
        itemBuilder: (BuildContext context, int index) {
          if (reports[index].YEAR < startYear) {
            startYear = reports[index].YEAR;
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  spacing: 10,
                  children: [
                    Text(
                      'Venta ${index + 1}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      spacing: 5,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text('ID Zona ${reports[index].ID_ZONA}'),
                            Text('ID Sucursal ${reports[index].ID_SUCURSAL}'),
                            Text('ID Tipo ${reports[index].ID_TIPO}'),
                          ],
                        ),
                        Column(
                          children: [
                            Text('${reports[index].YEAR}'),
                            Text('Mes ${reports[index].MES}'),
                            Text('Semana ${reports[index].SEMANA}'),
                          ],
                        ),
                        Column(
                          children: [
                            Text('Movimientos: ${reports[index].MOVIMIENTOS}'),
                            Text('MX \$${reports[index].VALOR}'),
                            Text('USD \$${reports[index].VALOR_USD}'),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              reports[index].FILIAL == true
                                  ? 'Filial: Sí'
                                  : 'Filial: No',
                            ),
                            Text('Cant. ${reports[index].CANTIDAD}'),
                            Text(
                              reports[index].CANCELADO
                                  ? 'Cancelado: Si'
                                  : 'Cancelado: No',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
