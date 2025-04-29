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

// @riverpod
// class Search extends _$Search {
//   @override
//   FutureOr<ReportModel> build() async {
//     return null;
//   }
// }

// class ReportListNotifier extends StateNotifier<List<ReportResponse>> {
//   final ReportRepository _reportRepository;
//
//   ReportListNotifier(this._reportRepository) : super([]) {
//    refresh();
//   }
//
//   // void refresh() async {
//   //   state = await _reportRepository.report(idSa, idCom, idSub, fIni, fFin, idSuc, tRep, tA, idArts, isClPr, cCont);
//   // }
// }