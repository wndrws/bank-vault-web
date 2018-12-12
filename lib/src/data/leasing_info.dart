import 'package:bank_vault/src/data/client_info.dart';
import 'package:bank_vault/src/enums/cell_application_status.dart';

class LeasingInfo {
  final int cellAppId;
  final ClientInfo leaseholder;
  final String cellId;
  final CellApplicationStatus status;
  final int leaseDays;
  final int leaseCost;

  LeasingInfo(
      this.cellAppId,
      this.leaseholder,
      this.cellId,
      this.status,
      this.leaseDays,
      this.leaseCost);

  factory LeasingInfo.fromJson(Map<String, dynamic> json) => LeasingInfo(
      json['id'],
      ClientInfo.fromJson(json['leaseholder']),
      json['cell']['codeName'],
      parseCellApplicationStatus(json['cell']['status']),
      json['cell']['leaseDays'],
      json['leaseCost']);
}