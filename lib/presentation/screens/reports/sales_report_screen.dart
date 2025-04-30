import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/data/models/report_response.dart';
import 'package:pos2/presentation/providers/sales_report_provider.dart';
import 'package:pos2/presentation/screens/reports/widgets/sales_report/sales_report.dart';

class SalesReport extends ConsumerStatefulWidget {
  const SalesReport({super.key});

  @override
  ConsumerState<SalesReport> createState() => _SalesReportState();
}

class _SalesReportState extends ConsumerState<SalesReport> {
  late int startYear;

  late bool hasFiltered;

  late bool isLoading;

  @override
  void initState() {
    isLoading = true;
    _getStartYear();
    _loadLastMonthReports();
    hasFiltered = false;
    super.initState();
  }

  _isLoading() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  _hasFiltered() {
    setState(() {
      hasFiltered = true;
    });
  }

  _getStartYear() {
    final reports = ref.read(salesReportProvider);
    if (reports.isNotEmpty) {
      startYear = reports[0].YEAR;
    } else {
      startYear = DateTime.now().year;
    }
  }

  _loadLastMonthReports() {
    final now = DateTime.now();
    final lastMonth = DateTime(now.year, now.month - 1, now.day);

    final String start =
        '${lastMonth.day}/${lastMonth.month}/${lastMonth.year}';
    final String end = '${now.day}/${now.month}/${now.year}';

    ref
        .read(salesReportProvider.notifier)
        .fetchReports(
          '19cf4bcd-c52c-41bf-9fc8-b1f3d91af2df',
          2,
          10,
          start,
          end,
          1,
          1,
          2,
          '',
          0,
          false,
        );

    _isLoading();
  }

  _filterReports() {
    setState(() {
      isLoading = true;
    });

    final start = ref.read(startDateProvider);
    final end = ref.read(endDateProvider);

    if (start != null && end != null) {
      String fIni = '${start.day}/${start.month}/${start.year}';
      String fFin = '${end.day}/${end.month}/${end.year}';

      ref
          .read(salesReportProvider.notifier)
          .fetchReports(
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

      _isLoading();
      _hasFiltered();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<ReportResponse> reports = ref.watch(salesReportProvider);
    final bool isFiltering = ref.watch(isFilteringProvider);

    return SafeArea(
      child: Scaffold(
        appBar: SalesReportAppBar(),
        body:
            isLoading
                ? Center(child: CircularProgressIndicator())
                : isFiltering
                ? Filters(startYear: startYear)
                : reports.isEmpty
                ? hasFiltered == true
                    ? Center(
                      child: Text(
                        'No hay resultados para la periodo seleccionado',
                      ),
                    )
                    : Center(child: Text('No hay reportes el último mes'))
                : ReportList(reports: reports),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (isFiltering) {
              final start = ref.read(startDateProvider);
              final end = ref.read(endDateProvider);

              if (start != null && end != null) {
                _filterReports();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Seleccione un rango de fechas'),
                  ),
                );
                return;
              }
              ref.read(isFilteringProvider.notifier).toggleFiltering();
            }
          },
          tooltip: 'Buscar',
          elevation: 5,
          child: const Icon(Icons.search),
        ),
      ),
    );
  }
}
