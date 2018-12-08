enum CellSize {
  SMALL, MEDIUM, BIG
}

CellSize parseCellSize(final String size) {
  switch (size) {
    case 'SMALL': return CellSize.SMALL;
    case 'MEDIUM': return CellSize.MEDIUM;
    case 'BIG': return CellSize.BIG;
    default: throw "Unknown cell size: $size";
  }
}

String serializeCellSize(final CellSize size) {
  switch (size) {
    case CellSize.SMALL: return 'SMALL';
    case CellSize.MEDIUM: return 'MEDIUM';
    case CellSize.BIG: return 'BIG';
    default: throw "Unsupported cell size: $size";
  }
}