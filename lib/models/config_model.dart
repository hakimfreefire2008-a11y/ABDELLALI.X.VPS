class ConfigModel {
  final String name;
  final String type;
  final String server;
  final String country;
  final String status;

  ConfigModel({
    required this.name,
    required this.type,
    required this.server,
    required this.country,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "type": type,
      "server": server,
      "country": country,
      "status": status,
    };
  }

  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    return ConfigModel(
      name: json["name"],
      type: json["type"],
      server: json["server"],
      country: json["country"],
      status: json["status"],
    );
  }
}
