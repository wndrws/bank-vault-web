class Cell {
  final String id, _status, _size, precious, leaseBegin;
  final int leaseDays, applicationId;

  Cell(this.id, this._status, this._size, this.precious, this.leaseBegin,
      this.leaseDays, this.applicationId);

  factory Cell.fromJson(Map<String, dynamic> json) => Cell(
      json['codeName'],
      json['status'],
      json['size'],
      json['containedPreciousName'],
      json['leaseBegin'],
      json['leaseDays'],
      json['applicationId']);

  String get status {
    switch (_status) {
      case "CREATED": return "Создана";
      case "CELL_CHOSEN": return "Ожидает одобрения";
      case "APPROVED": return "Ождиает оплаты";
      case "PAID": return "Оплачена";
      default: print("Incorrect status $_status for cell $id"); return "";
    }
  }

  String get size {
    switch (_size) {
      case "SMALL": return "Малый (1 л)";
      case "MEDIUM": return "Средний (2 л)";
      case "BIG": return "Большой (4 л)";
      default: print("Incorrect size $_size for cell $id"); return "";
    }
  }
}
