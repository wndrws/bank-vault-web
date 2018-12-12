class ClientInfo {
  final String serial, firstName, lastName, patronymic, birthday, phone, email;

  ClientInfo(
      this.serial,
      this.firstName,
      this.lastName,
      this.patronymic,
      this.birthday,
      this.phone,
      this.email);

  factory ClientInfo.fromJson(Map<String, dynamic> json) => ClientInfo(
      json['passportSerial'],
      json['firstName'],
      json['lastName'],
      json['patronymic'] ?? "",
      json['birthday'] ?? "",
      json['email'] ?? "",
      json['phone'] ?? "");

  String get name => lastName + " " + firstName;

  String get fullName => lastName + " " + firstName + " " + patronymic;
}