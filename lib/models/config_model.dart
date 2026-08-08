// lib/models/config_model.dart

enum ConfigType {
  ssh, http, sslTls, v2ray, slowDns, udp,
}

enum V2RayProtocol {
  vless, vmess, trojan,
}

enum ConfigStatus {
  ready, pending, error, expired,
}

class ConfigModel {
  final String id;
  final ConfigType type;
  final String name;
  final String? note;
  final DateTime createdAt;
  final DateTime? updatedAt;
  ConfigStatus status;
  
  String? fileName;
  String? filePath;
  int? fileSize;
  
  String? host;
  int? port;
  String? username;
  String? password;
  
  bool enablePayload;
  bool enableProxy;
  bool enableSni;
  bool enableAdvanced;
  
  String? payloadRaw;
  String? proxyHost;
  int? proxyPort;
  String? proxyUsername;
  String? proxyPassword;
  String? sniDomain;
  bool? enableSsl;
  bool? enableTls;
  String? sslCertificate;
  
  V2RayProtocol? v2rayProtocol;
  String? v2rayServerAddress;
  int? v2rayPort;
  String? v2rayUuid;
  String? v2raySecurity;
  String? v2rayNetwork;
  String? v2rayHost;
  String? v2rayPath;
  String? v2rayAlpn;
  String? v2rayFingerprint;
  String? v2rayFlow;
  String? v2rayEncryption;
  String? v2rayType;
  
  String? slowDnsNsDomain;
  String? slowDnsPublicKey;
  String? slowDnsIp;
  String? slowDnsPort;
  
  String? udpServer;
  int? udpPort;
  int? udpBuffer;
  String? udpMode;
  int? udpTimeout;
  
  Map<String, dynamic>? extra;
  List<String>? tags;
  int usageCount;
  DateTime? lastUsed;
  bool isFavorite;

  ConfigModel({
    String? id,
    required this.type,
    required this.name,
    this.note,
    DateTime? createdAt,
    this.updatedAt,
    this.status = ConfigStatus.ready,
    this.fileName,
    this.filePath,
    this.fileSize,
    this.host,
    this.port,
    this.username,
    this.password,
    this.enablePayload = false,
    this.enableProxy = false,
    this.enableSni = false,
    this.enableAdvanced = false,
    this.payloadRaw,
    this.proxyHost,
    this.proxyPort,
    this.proxyUsername,
    this.proxyPassword,
    this.sniDomain,
    this.enableSsl,
    this.enableTls,
    this.sslCertificate,
    this.v2rayProtocol,
    this.v2rayServerAddress,
    this.v2rayPort,
    this.v2rayUuid,
    this.v2raySecurity,
    this.v2rayNetwork,
    this.v2rayHost,
    this.v2rayPath,
    this.v2rayAlpn,
    this.v2rayFingerprint,
    this.v2rayFlow,
    this.v2rayEncryption,
    this.v2rayType,
    this.slowDnsNsDomain,
    this.slowDnsPublicKey,
    this.slowDnsIp,
    this.slowDnsPort,
    this.udpServer,
    this.udpPort,
    this.udpBuffer,
    this.udpMode,
    this.udpTimeout,
    this.extra,
    this.tags,
    this.usageCount = 0,
    this.lastUsed,
    this.isFavorite = false,
  })  : id = id ?? 'cfg_${DateTime.now().millisecondsSinceEpoch}',
        createdAt = createdAt ?? DateTime.now();

  String getTypeName() {
    switch (type) {
      case ConfigType.ssh: return 'SSH';
      case ConfigType.http: return 'HTTP';
      case ConfigType.sslTls: return 'SSL/TLS';
      case ConfigType.v2ray: return 'V2Ray';
      case ConfigType.slowDns: return 'Slow DNS';
      case ConfigType.udp: return 'UDP Custom';
    }
  }

  String getStatusText() {
    switch (status) {
      case ConfigStatus.ready: return 'جاهز';
      case ConfigStatus.pending: return 'قيد الانتظار';
      case ConfigStatus.error: return 'خطأ';
      case ConfigStatus.expired: return 'منتهي الصلاحية';
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toString().split('.').last,
      'name': name,
      'note': note,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'status': status.toString().split('.').last,
      'fileName': fileName,
      'filePath': filePath,
      'fileSize': fileSize,
      'host': host,
      'port': port,
      'username': username,
      'password': password,
      'enablePayload': enablePayload,
      'enableProxy': enableProxy,
      'enableSni': enableSni,
      'enableAdvanced': enableAdvanced,
      'payloadRaw': payloadRaw,
      'proxyHost': proxyHost,
      'proxyPort': proxyPort,
      'proxyUsername': proxyUsername,
      'proxyPassword': proxyPassword,
      'sniDomain': sniDomain,
      'enableSsl': enableSsl,
      'enableTls': enableTls,
      'sslCertificate': sslCertificate,
      'v2rayProtocol': v2rayProtocol?.toString().split('.').last,
      'v2rayServerAddress': v2rayServerAddress,
      'v2rayPort': v2rayPort,
      'v2rayUuid': v2rayUuid,
      'v2raySecurity': v2raySecurity,
      'v2rayNetwork': v2rayNetwork,
      'v2rayHost': v2rayHost,
      'v2rayPath': v2rayPath,
      'v2rayAlpn': v2rayAlpn,
      'v2rayFingerprint': v2rayFingerprint,
      'v2rayFlow': v2rayFlow,
      'v2rayEncryption': v2rayEncryption,
      'v2rayType': v2rayType,
      'slowDnsNsDomain': slowDnsNsDomain,
      'slowDnsPublicKey': slowDnsPublicKey,
      'slowDnsIp': slowDnsIp,
      'slowDnsPort': slowDnsPort,
      'udpServer': udpServer,
      'udpPort': udpPort,
      'udpBuffer': udpBuffer,
      'udpMode': udpMode,
      'udpTimeout': udpTimeout,
      'extra': extra,
      'tags': tags,
      'usageCount': usageCount,
      'lastUsed': lastUsed?.toIso8601String(),
      'isFavorite': isFavorite,
    };
  }

  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    return ConfigModel(
      id: json['id'] as String?,
      type: ConfigType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
        orElse: () => ConfigType.ssh,
      ),
      name: json['name'] as String? ?? 'غير مسماة',
      note: json['note'] as String?,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      status: ConfigStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => ConfigStatus.ready,
      ),
      fileName: json['fileName'] as String?,
      filePath: json['filePath'] as String?,
      fileSize: json['fileSize'] as int?,
      host: json['host'] as String?,
      port: json['port'] as int?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      enablePayload: json['enablePayload'] as bool? ?? false,
      enableProxy: json['enableProxy'] as bool? ?? false,
      enableSni: json['enableSni'] as bool? ?? false,
      enableAdvanced: json['enableAdvanced'] as bool? ?? false,
      payloadRaw: json['payloadRaw'] as String?,
      proxyHost: json['proxyHost'] as String?,
      proxyPort: json['proxyPort'] as int?,
      proxyUsername: json['proxyUsername'] as String?,
      proxyPassword: json['proxyPassword'] as String?,
      sniDomain: json['sniDomain'] as String?,
      enableSsl: json['enableSsl'] as bool?,
      enableTls: json['enableTls'] as bool?,
      sslCertificate: json['sslCertificate'] as String?,
      v2rayProtocol: json['v2rayProtocol'] != null
          ? V2RayProtocol.values.firstWhere(
              (e) => e.toString().split('.').last == json['v2rayProtocol'],
              orElse: () => V2RayProtocol.vless,
            )
          : null,
      v2rayServerAddress: json['v2rayServerAddress'] as String?,
      v2rayPort: json['v2rayPort'] as int?,
      v2rayUuid: json['v2rayUuid'] as String?,
      v2raySecurity: json['v2raySecurity'] as String?,
      v2rayNetwork: json['v2rayNetwork'] as String?,
      v2rayHost: json['v2rayHost'] as String?,
      v2rayPath: json['v2rayPath'] as String?,
      v2rayAlpn: json['v2rayAlpn'] as String?,
      v2rayFingerprint: json['v2rayFingerprint'] as String?,
      v2rayFlow: json['v2rayFlow'] as String?,
      v2rayEncryption: json['v2rayEncryption'] as String?,
      v2rayType: json['v2rayType'] as String?,
      slowDnsNsDomain: json['slowDnsNsDomain'] as String?,
      slowDnsPublicKey: json['slowDnsPublicKey'] as String?,
      slowDnsIp: json['slowDnsIp'] as String?,
      slowDnsPort: json['slowDnsPort'] as String?,
      udpServer: json['udpServer'] as String?,
      udpPort: json['udpPort'] as int?,
      udpBuffer: json['udpBuffer'] as int?,
      udpMode: json['udpMode'] as String?,
      udpTimeout: json['udpTimeout'] as int?,
      extra: json['extra'] as Map<String, dynamic>?,
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      usageCount: json['usageCount'] as int? ?? 0,
      lastUsed: json['lastUsed'] != null ? DateTime.parse(json['lastUsed']) : null,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  ConfigModel copyWith({
    String? id,
    ConfigType? type,
    String? name,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
    ConfigStatus? status,
    String? fileName,
    String? filePath,
    int? fileSize,
    String? host,
    int? port,
    String? username,
    String? password,
    bool? enablePayload,
    bool? enableProxy,
    bool? enableSni,
    bool? enableAdvanced,
    String? payloadRaw,
    String? proxyHost,
    int? proxyPort,
    String? proxyUsername,
    String? proxyPassword,
    String? sniDomain,
    bool? enableSsl,
    bool? enableTls,
    String? sslCertificate,
    V2RayProtocol? v2rayProtocol,
    String? v2rayServerAddress,
    int? v2rayPort,
    String? v2rayUuid,
    String? v2raySecurity,
    String? v2rayNetwork,
    String? v2rayHost,
    String? v2rayPath,
    String? v2rayAlpn,
    String? v2rayFingerprint,
    String? v2rayFlow,
    String? v2rayEncryption,
    String? v2rayType,
    String? slowDnsNsDomain,
    String? slowDnsPublicKey,
    String? slowDnsIp,
    String? slowDnsPort,
    String? udpServer,
    int? udpPort,
    int? udpBuffer,
    String? udpMode,
    int? udpTimeout,
    Map<String, dynamic>? extra,
    List<String>? tags,
    int? usageCount,
    DateTime? lastUsed,
    bool? isFavorite,
  }) {
    return ConfigModel(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
      status: status ?? this.status,
      fileName: fileName ?? this.fileName,
      filePath: filePath ?? this.filePath,
      fileSize: fileSize ?? this.fileSize,
      host: host ?? this.host,
      port: port ?? this.port,
      username: username ?? this.username,
      password: password ?? this.password,
      enablePayload: enablePayload ?? this.enablePayload,
      enableProxy: enableProxy ?? this.enableProxy,
      enableSni: enableSni ?? this.enableSni,
      enableAdvanced: enableAdvanced ?? this.enableAdvanced,
      payloadRaw: payloadRaw ?? this.payloadRaw,
      proxyHost: proxyHost ?? this.proxyHost,
      proxyPort: proxyPort ?? this.proxyPort,
      proxyUsername: proxyUsername ?? this.proxyUsername,
      proxyPassword: proxyPassword ?? this.proxyPassword,
      sniDomain: sniDomain ?? this.sniDomain,
      enableSsl: enableSsl ?? this.enableSsl,
      enableTls: enableTls ?? this.enableTls,
      sslCertificate: sslCertificate ?? this.sslCertificate,
      v2rayProtocol: v2rayProtocol ?? this.v2rayProtocol,
      v2rayServerAddress: v2rayServerAddress ?? this.v2rayServerAddress,
      v2rayPort: v2rayPort ?? this.v2rayPort,
      v2rayUuid: v2rayUuid ?? this.v2rayUuid,
      v2raySecurity: v2raySecurity ?? this.v2raySecurity,
      v2rayNetwork: v2rayNetwork ?? this.v2rayNetwork,
      v2rayHost: v2rayHost ?? this.v2rayHost,
      v2rayPath: v2rayPath ?? this.v2rayPath,
      v2rayAlpn: v2rayAlpn ?? this.v2rayAlpn,
      v2rayFingerprint: v2rayFingerprint ?? this.v2rayFingerprint,
      v2rayFlow: v2rayFlow ?? this.v2rayFlow,
      v2rayEncryption: v2rayEncryption ?? this.v2rayEncryption,
      v2rayType: v2rayType ?? this.v2rayType,
      slowDnsNsDomain: slowDnsNsDomain ?? this.slowDnsNsDomain,
      slowDnsPublicKey: slowDnsPublicKey ?? this.slowDnsPublicKey,
      slowDnsIp: slowDnsIp ?? this.slowDnsIp,
      slowDnsPort: slowDnsPort ?? this.slowDnsPort,
      udpServer: udpServer ?? this.udpServer,
      udpPort: udpPort ?? this.udpPort,
      udpBuffer: udpBuffer ?? this.udpBuffer,
      udpMode: udpMode ?? this.udpMode,
      udpTimeout: udpTimeout ?? this.udpTimeout,
      extra: extra ?? this.extra,
      tags: tags ?? this.tags,
      usageCount: usageCount ?? this.usageCount,
      lastUsed: lastUsed ?? this.lastUsed,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  String toString() {
    return 'ConfigModel(id: $id, name: $name, type: ${getTypeName()})';
  }
}
