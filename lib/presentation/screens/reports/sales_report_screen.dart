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
        body: Padding(padding: const EdgeInsets.all(15), child: _body()),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(15),
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Consultar'),
          ),
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
                children: [
                  Text('ID Zona ${reports[index].ID_ZONA}'),
                  Text('ID Sucursal ${reports[index].ID_SUCURSAL}'),
                  Text('ID Tipo ${reports[index].ID_TIPO}'),
                  Text('Año ${reports[index].YEAR}'),
                  Text('Mes ${reports[index].MES}'),
                  Text('Semana ${reports[index].SEMANA}'),
                  Text('Movimientos ${reports[index].MOVIMIENTOS}'),
                  Text('Valor ${reports[index].VALOR}'),
                  Text('Valor en dólares ${reports[index].VALOR_USD}'),
                  Text('Filial ${reports[index].FILIAL}'),
                  Text('Cantidad ${reports[index].CANTIDAD}'),
                  Text('Cancelado ${reports[index].CANCELADO}'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
