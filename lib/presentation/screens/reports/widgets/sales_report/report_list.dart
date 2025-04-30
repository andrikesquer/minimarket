import 'package:flutter/material.dart';
import 'package:pos2/data/models/report_response.dart';

class ReportList extends StatelessWidget {

  final List<ReportResponse> reports;

  const ReportList({super.key, required this.reports});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView.builder(
        itemCount: reports.length,
        itemBuilder: (BuildContext context, int index) {
          final report = reports[index];

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
                            Text('ID Zona ${report.ID_ZONA}'),
                            Text('ID Sucursal ${report.ID_SUCURSAL}'),
                            Text('ID Tipo ${report.ID_TIPO}'),
                          ],
                        ),
                        Column(
                          children: [
                            Text('${report.YEAR}'),
                            Text('Mes ${report.MES}'),
                            Text('Semana ${report.SEMANA}'),
                          ],
                        ),
                        Column(
                          children: [
                            Text('Movimientos: ${report.MOVIMIENTOS}'),
                            Text('MX \$${report.VALOR}'),
                            Text('USD \$${report.VALOR_USD}'),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              report.FILIAL == true
                                  ? 'Filial: Sí'
                                  : 'Filial: No',
                            ),
                            Text('Cant. ${report.CANTIDAD}'),
                            Text(
                              report.CANCELADO
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
