import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/data/models/report_response.dart';
import 'package:pos2/domain/repositories/sales_report_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sales_report_provider.g.dart';

@riverpod
class IsFiltering extends _$IsFiltering {
  @override
  bool build() => false;
  void toggleFiltering() => state = !state;
}

final startDateProvider = StateProvider<DateTime?>((ref) => null);
final endDateProvider = StateProvider<DateTime?>((ref) => null);

class SalesReportNotifier extends StateNotifier<List<ReportResponse>> {
  SalesReportNotifier() : super([]);

  final ReportRepository _repository = ReportRepository();

  Future<void> fetchReports(
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
    try {
      final List<ReportResponse> reports = await _repository.reports(
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
      state = reports;
    } catch (e) {
      state = [];
      debugPrint("Error: $e");
    }
  }
}

final salesReportProvider =
    StateNotifierProvider<SalesReportNotifier, List<ReportResponse>>((ref) {
      return SalesReportNotifier();
    });
