class Precious {
  final int volume;
  final String name;

  Precious(this.volume, this.name);

  factory Precious.fromJson(Map<String, dynamic> json) => Precious(
      json['volume'],
      json['name']);

  Map<String, dynamic> toJson() => { 'volume': volume, 'name': name };
}