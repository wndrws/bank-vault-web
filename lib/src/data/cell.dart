import 'package:bank_vault/src/enums/cell_application_status.dart';
import 'package:bank_vault/src/enums/cell_size.dart';

class Cell {
  final String id, precious, leaseBegin;
  final CellApplicationStatus statusId;
  final CellSize sizeId;
  final int leaseDays, applicationId;

  Cell(this.id, this.statusId, this.sizeId, this.precious, this.leaseBegin,
      this.leaseDays, this.applicationId);

  factory Cell.fromJson(Map<String, dynamic> json) => Cell(
      json['codeName'],
      parseCellApplicationStatus(json['status']),
      parseCellSize(json['size']),
      json['containedPreciousName'],
      json['leaseBegin'],
      json['leaseDays'],
      json['applicationId']);

  String get status {
    switch (statusId) {
      case CellApplicationStatus.CREATED: return "Создана";
      case CellApplicationStatus.CELL_CHOSEN: return "Ожидает одобрения";
      case CellApplicationStatus.APPROVED: return "Ождиает оплаты";
      case CellApplicationStatus.PAID: return "Оплачена";
      default: print("Incorrect status $statusId for cell $id"); return "";
    }
  }

  String get size {
    switch (sizeId) {
      case CellSize.SMALL: return "Малый (1 л)";
      case CellSize.MEDIUM: return "Средний (2 л)";
      case CellSize.BIG: return "Большой (4 л)";
      default: print("Incorrect size $sizeId for cell $id"); return "";
    }
  }
}
