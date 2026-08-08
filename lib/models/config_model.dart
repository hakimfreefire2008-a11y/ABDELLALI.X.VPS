class ConfigModel {
  final String id;

  final String name;
  final String type;
  final String note;

  final String host;
  final String port;

  final String username;
  final String password;

  final bool useSni;
  final String sni;

  final bool usePayload;
  final String payload;

  final bool useProxy;
  final String proxyHost;
  final String proxyPort;

  final String v2rayType;
  final String uuid;
  final String address;

  final String nsDomain;
  final String publicKey;
  final String dnsIp;

  final bool isActive;
  final bool isFavorite;

  final DateTime createdAt;

  ConfigModel({
    required this.id,
    required this.name,
    required this.type,
    required this.note,
    required this.host,
    required this.port,
    required this.username,
    required this.password,
    required this.useSni,
    required this.sni,
    required this.usePayload,
    required this.payload,
    required this.useProxy,
    required this.proxyHost,
    required this.proxyPort,
    required this.v2rayType,
    required this.uuid,
    required this.address,
    required this.nsDomain,
    required this.publicKey,
    required this.dnsIp,
    this.isActive = true,
    this.isFavorite = false,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'note': note,
      'host': host,
      'port': port,
      'username': username,
      'password': password,
      'useSni': useSni,
      'sni': sni,
      'usePayload': usePayload,
      'payload': payload,
      'useProxy': useProxy,
      'proxyHost': proxyHost,
      'proxyPort': proxyPort,
      'v2rayType': v2rayType,
      'uuid': uuid,
      'address': address,
      'nsDomain': nsDomain,
      'publicKey': publicKey,
      'dnsIp': dnsIp,
      'isActive': isActive,
      'isFavorite': isFavorite,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    return ConfigModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      note: json['note']?.toString() ?? '',
      host: json['host']?.toString() ?? '',
      port: json['port']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      password: json['password']?.toString() ?? '',
      useSni: json['useSni'] == true,
      sni: json['sni']?.toString() ?? '',
      usePayload: json['usePayload'] == true,
      payload: json['payload']?.toString() ?? '',
      useProxy: json['useProxy'] == true,
      proxyHost: json['proxyHost']?.toString() ?? '',
      proxyPort: json['proxyPort']?.toString() ?? '',
      v2rayType: json['v2rayType']?.toString() ?? '',
      uuid: json['uuid']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      nsDomain: json['nsDomain']?.toString() ?? '',
      publicKey: json['publicKey']?.toString() ?? '',
      dnsIp: json['dnsIp']?.toString() ?? '',
      isActive: json['isActive'] == null ? true : json['isActive'] == true,
      isFavorite: json['isFavorite'] == true,
      createdAt: DateTime.tryParse(
            json['createdAt']?.toString() ?? '',
          ) ??
          DateTime.now(),
    );
  }

  ConfigModel copyWith({
    String? id,
    String? name,
    String? type,
    String? note,
    String? host,
    String? port,
    String? username,
    String? password,
    bool? useSni,
    String? sni,
    bool? usePayload,
    String? payload,
    bool? useProxy,
    String? proxyHost,
    String? proxyPort,
    String? v2rayType,
    String? uuid,
    String? address,
    String? nsDomain,
    String? publicKey,
    String? dnsIp,
    bool? isActive,
    bool? isFavorite,
    DateTime? createdAt,
  }) {
    return ConfigModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      note: note ?? this.note,
      host: host ?? this.host,
      port: port ?? this.port,
      username: username ?? this.username,
      password: password ?? this.password,
      useSni: useSni ?? this.useSni,
      sni: sni ?? this.sni,
      usePayload: usePayload ?? this.usePayload,
      payload: payload ?? this.payload,
      useProxy: useProxy ?? this.useProxy,
      proxyHost: proxyHost ?? this.proxyHost,
      proxyPort: proxyPort ?? this.proxyPort,
      v2rayType: v2rayType ?? this.v2rayType,
      uuid: uuid ?? this.uuid,
      address: address ?? this.address,
      nsDomain: nsDomain ?? this.nsDomain,
      publicKey: publicKey ?? this.publicKey,
      dnsIp: dnsIp ?? this.dnsIp,
      isActive: isActive ?? this.isActive,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
