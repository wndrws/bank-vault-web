import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/material_spinner/material_spinner.dart';

import 'package:bank_vault/src/data/cell.dart';
import 'package:bank_vault/src/services/cell_table_service.dart';

@Component(
  selector: 'cell-table-component',
  styleUrls: ['cell_table_component.css'],
  templateUrl: 'cell_table_component.html',
  directives: [coreDirectives, MaterialSpinnerComponent]
)
class CellTableComponent implements OnInit {
  static const Duration _POLLING_INTERVAL = Duration(seconds: 3);

  Cell selectedCell;
  List<Cell> allCells;

  final CellTableService _cellTableService;

  CellTableComponent(this._cellTableService);

  @override
  void ngOnInit() {
    _schedulePeriodicTableUpdate();
  }

  void _schedulePeriodicTableUpdate() {
    Timer.periodic(_POLLING_INTERVAL, (_) async {
      try {
        allCells = await _cellTableService.getCells();
        selectedCell = allCells.firstWhere(
                (cell) => cell.id == selectedCell?.id ?? "", orElse: () => null);
      } on Exception catch (e) {
        print("Failed to fetch cells! Reason: ${e}");
      }
    });
  }

  void onSelect(final Cell cell) => selectedCell = cell;
}