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

  @override
  void initState() {
    super.initState();
    _getStartYear();
    _loadLastMonthReports();
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
  }

  _filterReports() {
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
            isFiltering
                ? Filters(startYear: startYear)
                : reports.isEmpty
                ? const Center(child: CircularProgressIndicator())
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
                    content: Text('Selecciona un rango de fechas'),
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
