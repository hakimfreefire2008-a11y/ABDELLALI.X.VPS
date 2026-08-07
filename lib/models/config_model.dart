// lib/models/config_model.dart

class ConfigModel {
  final String id;
  final String name;
  final String note;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isFavorite;
  final bool isActive;
  final String? sshHost;
  final int? sshPort;
  final String? sshUsername;
  final String? sshPassword;
  final String? httpPayload;
  final String? httpProxy;
  final bool enableSni;
  final String? sniDomain;
  final String? v2rayAddress;
  final int? v2rayPort;
  final String? v2rayUuid;
  final String? v2rayHost;
  final String? v2rayPath;
  final String? v2raySni;
  final String? v2rayNetwork;
  final String? v2raySecurity;
  final String? v2rayType;
  final String? slowDnsNsDomain;
  final String? slowDnsPublicKey;
  final String? slowDnsDnsIp;
  final String? udpServer;
  final int? udpPort;
  final String? filePath;

  ConfigModel({
    required this.id,
    required this.name,
    this.note = '',
    required this.type,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.isFavorite = false,
    this.isActive = true,
    this.sshHost,
    this.sshPort,
    this.sshUsername,
    this.sshPassword,
    this.httpPayload,
    this.httpProxy,
    this.enableSni = false,
    this.sniDomain,
    this.v2rayAddress,
    this.v2rayPort,
    this.v2rayUuid,
    this.v2rayHost,
    this.v2rayPath,
    this.v2raySni,
    this.v2rayNetwork,
    this.v2raySecurity,
    this.v2rayType,
    this.slowDnsNsDomain,
    this.slowDnsPublicKey,
    this.slowDnsDnsIp,
    this.udpServer,
    this.udpPort,
    this.filePath,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'note': note,
        'type': type,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'isFavorite': isFavorite,
        'isActive': isActive,
        'sshHost': sshHost,
        'sshPort': sshPort,
        'sshUsername': sshUsername,
        'sshPassword': sshPassword,
        'httpPayload': httpPayload,
        'httpProxy': httpProxy,
        'enableSni': enableSni,
        'sniDomain': sniDomain,
        'v2rayAddress': v2rayAddress,
        'v2rayPort': v2rayPort,
        'v2rayUuid': v2rayUuid,
        'v2rayHost': v2rayHost,
        'v2rayPath': v2rayPath,
        'v2raySni': v2raySni,
        'v2rayNetwork': v2rayNetwork,
        'v2raySecurity': v2raySecurity,
        'v2rayType': v2rayType,
        'slowDnsNsDomain': slowDnsNsDomain,
        'slowDnsPublicKey': slowDnsPublicKey,
        'slowDnsDnsIp': slowDnsDnsIp,
        'udpServer': udpServer,
        'udpPort': udpPort,
        'filePath': filePath,
      };

  factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
        id: json['id'],
        name: json['name'],
        note: json['note'] ?? '',
        type: json['type'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        isFavorite: json['isFavorite'] ?? false,
        isActive: json['isActive'] ?? true,
        sshHost: json['sshHost'],
        sshPort: json['sshPort'],
        sshUsername: json['sshUsername'],
        sshPassword: json['sshPassword'],
        httpPayload: json['httpPayload'],
        httpProxy: json['httpProxy'],
        enableSni: json['enableSni'] ?? false,
        sniDomain: json['sniDomain'],
        v2rayAddress: json['v2rayAddress'],
        v2rayPort: json['v2rayPort'],
        v2rayUuid: json['v2rayUuid'],
        v2rayHost: json['v2rayHost'],
        v2rayPath: json['v2rayPath'],
        v2raySni: json['v2raySni'],
        v2rayNetwork: json['v2rayNetwork'],
        v2raySecurity: json['v2raySecurity'],
        v2rayType: json['v2rayType'],
        slowDnsNsDomain: json['slowDnsNsDomain'],
        slowDnsPublicKey: json['slowDnsPublicKey'],
        slowDnsDnsIp: json['slowDnsDnsIp'],
        udpServer: json['udpServer'],
        udpPort: json['udpPort'],
        filePath: json['filePath'],
      );

  ConfigModel copyWith({
    String? id,
    String? name,
    String? note,
    String? type,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isFavorite,
    bool? isActive,
    String? sshHost,
    int? sshPort,
    String? sshUsername,
    String? sshPassword,
    String? httpPayload,
    String? httpProxy,
    bool? enableSni,
    String? sniDomain,
    String? v2rayAddress,
    int? v2rayPort,
    String? v2rayUuid,
    String? v2rayHost,
    String? v2rayPath,
    String? v2raySni,
    String? v2rayNetwork,
    String? v2raySecurity,
    String? v2rayType,
    String? slowDnsNsDomain,
    String? slowDnsPublicKey,
    String? slowDnsDnsIp,
    String? udpServer,
    int? udpPort,
    String? filePath,
  }) {
    return ConfigModel(
      id: id ?? this.id,
      name: name ?? this.name,
      note: note ?? this.note,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isFavorite: isFavorite ?? this.isFavorite,
      isActive: isActive ?? this.isActive,
      sshHost: sshHost ?? this.sshHost,
      sshPort: sshPort ?? this.sshPort,
      sshUsername: sshUsername ?? this.sshUsername,
      sshPassword: sshPassword ?? this.sshPassword,
      httpPayload: httpPayload ?? this.httpPayload,
      httpProxy: httpProxy ?? this.httpProxy,
      enableSni: enableSni ?? this.enableSni,
      sniDomain: sniDomain ?? this.sniDomain,
      v2rayAddress: v2rayAddress ?? this.v2rayAddress,
      v2rayPort: v2rayPort ?? this.v2rayPort,
      v2rayUuid: v2rayUuid ?? this.v2rayUuid,
      v2rayHost: v2rayHost ?? this.v2rayHost,
      v2rayPath: v2rayPath ?? this.v2rayPath,
      v2raySni: v2raySni ?? this.v2raySni,
      v2rayNetwork: v2rayNetwork ?? this.v2rayNetwork,
      v2raySecurity: v2raySecurity ?? this.v2raySecurity,
      v2rayType: v2rayType ?? this.v2rayType,
      slowDnsNsDomain: slowDnsNsDomain ?? this.slowDnsNsDomain,
      slowDnsPublicKey: slowDnsPublicKey ?? this.slowDnsPublicKey,
      slowDnsDnsIp: slowDnsDnsIp ?? this.slowDnsDnsIp,
      udpServer: udpServer ?? this.udpServer,
      udpPort: udpPort ?? this.udpPort,
      filePath: filePath ?? this.filePath,
    );
  }
}
