import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pos2/core/services/api_reports.dart';
import 'package:pos2/data/models/report_model.dart';

class SalesReportScreen extends StatelessWidget {
  const SalesReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              context.go('/reports');
            },
          ),
          title: Text('Reporte de ventas'),
          actions: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                context.go('/:email');
              },
            ),
          ],
        ),
        body: _body(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'Buscar',
          elevation: 5,
          child: const Icon(Icons.search),
        ),
      ),
    );
  }

  FutureBuilder _body() {
    final apiReports = ApiReports(
      Dio(BaseOptions(contentType: "application/json")),
    );

    return FutureBuilder(
      future: apiReports.getReports(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<ReportModel> reports = [];
          if (snapshot.data != null) {
            reports = snapshot.data;
          }
          return _reports(reports);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _reports(List<ReportModel> reports) {
    return ListView.builder(
      itemCount: reports.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Card.outlined(
            // padding: EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                spacing: 10,
                children: [
                  Text(
                    'Venta $index',
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
                          Text('Movimientos ${reports[index].MOVIMIENTOS}'),
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
    );
  }
}
