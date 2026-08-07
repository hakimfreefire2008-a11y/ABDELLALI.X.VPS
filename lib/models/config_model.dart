class ConfigModel {

  String id;

  String name;

  String type;


  String host;

  String port;


  String username;

  String password;


  String sni;


  String payload;

  bool payloadEnabled;


  String proxy;

  bool proxyEnabled;


  String v2ray;


  String slowDns;


  String udp;


  String note;


  DateTime createdAt;



  ConfigModel({

    required this.id,

    required this.name,

    required this.type,


    this.host = "",

    this.port = "",


    this.username = "",

    this.password = "",


    this.sni = "",


    this.payload = "",

    this.payloadEnabled = false,


    this.proxy = "",

    this.proxyEnabled = false,


    this.v2ray = "",


    this.slowDns = "",


    this.udp = "",


    this.note = "",


    required this.createdAt,

  });



  Map<String,dynamic> toJson(){

    return {


      "id": id,

      "name": name,

      "type": type,


      "host": host,

      "port": port,


      "username": username,

      "password": password,


      "sni": sni,


      "payload": payload,

      "payloadEnabled": payloadEnabled,


      "proxy": proxy,

      "proxyEnabled": proxyEnabled,


      "v2ray": v2ray,


      "slowDns": slowDns,


      "udp": udp,


      "note": note,


      "createdAt":
      createdAt.toIso8601String(),


    };

  }



  factory ConfigModel.fromJson(
      Map<String,dynamic> json
      ){

    return ConfigModel(

      id: json["id"],

      name: json["name"],

      type: json["type"],


      host: json["host"] ?? "",

      port: json["port"] ?? "",


      username: json["username"] ?? "",

      password: json["password"] ?? "",


      sni: json["sni"] ?? "",


      payload:
      json["payload"] ?? "",


      payloadEnabled:
      json["payloadEnabled"] ?? false,


      proxy:
      json["proxy"] ?? "",


      proxyEnabled:
      json["proxyEnabled"] ?? false,


      v2ray:
      json["v2ray"] ?? "",


      slowDns:
      json["slowDns"] ?? "",


      udp:
      json["udp"] ?? "",


      note:
      json["note"] ?? "",


      createdAt:
      DateTime.parse(
        json["createdAt"],
      ),

    );

  }

}
