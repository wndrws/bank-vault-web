class Invoice {
  final int id, sum;
  bool isPaid;

  Invoice(this.id, this.sum, this.isPaid);

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
      json['id'],
      json['sum'],
      json['paid']);

  Map<String, dynamic> toJson() => { 'id': id, 'sum': sum, 'paid': isPaid };
}