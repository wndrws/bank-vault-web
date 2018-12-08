enum CellApplicationStatus {
  CREATED, CELL_CHOSEN, APPROVED, PAID
}

CellApplicationStatus parseCellApplicationStatus(final String status) {
  switch (status) {
    case 'CREATED': return CellApplicationStatus.CREATED;
    case 'CELL_CHOSEN': return CellApplicationStatus.CELL_CHOSEN;
    case 'APPROVED': return CellApplicationStatus.APPROVED;
    case 'PAID': return CellApplicationStatus.PAID;
    default: throw "Unknown cell application status: $status";
  }
}

String serializeCellApplicationStatus(final CellApplicationStatus status) {
  switch (status) {
    case CellApplicationStatus.CREATED: return 'CREATED';
    case CellApplicationStatus.CELL_CHOSEN: return 'CELL_CHOSEN';
    case CellApplicationStatus.APPROVED: return 'APPROVED';
    case CellApplicationStatus.PAID: return 'PAID';
    default: throw "Unsupported cell application status: $status";
  }
}