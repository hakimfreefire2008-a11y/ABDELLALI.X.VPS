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



  Map<String,dynamic> toJson(){

    return {

      "id":id,

      "name":name,
      "type":type,
      "note":note,

      "host":host,
      "port":port,

      "username":username,
      "password":password,

      "useSni":useSni,
      "sni":sni,

      "usePayload":usePayload,
      "payload":payload,

      "useProxy":useProxy,
      "proxyHost":proxyHost,
      "proxyPort":proxyPort,

      "v2rayType":v2rayType,
      "uuid":uuid,
      "address":address,

      "nsDomain":nsDomain,
      "publicKey":publicKey,
      "dnsIp":dnsIp,


      "isActive":isActive,

      "isFavorite":isFavorite,


      "createdAt":createdAt.toIso8601String(),

    };

  }




  factory ConfigModel.fromJson(
      Map<String,dynamic> json){

    return ConfigModel(

      id:json["id"] ?? "",

      name:json["name"] ?? "",

      type:json["type"] ?? "",

      note:json["note"] ?? "",


      host:json["host"] ?? "",

      port:json["port"] ?? "",


      username:json["username"] ?? "",

      password:json["password"] ?? "",


      useSni:json["useSni"] ?? false,

      sni:json["sni"] ?? "",


      usePayload:json["usePayload"] ?? false,

      payload:json["payload"] ?? "",


      useProxy:json["useProxy"] ?? false,

      proxyHost:json["proxyHost"] ?? "",

      proxyPort:json["proxyPort"] ?? "",


      v2rayType:json["v2rayType"] ?? "",

      uuid:json["uuid"] ?? "",

      address:json["address"] ?? "",


      nsDomain:json["nsDomain"] ?? "",

      publicKey:json["publicKey"] ?? "",

      dnsIp:json["dnsIp"] ?? "",



      isActive:json["isActive"] ?? true,

      isFavorite:json["isFavorite"] ?? false,



      createdAt:
      DateTime.tryParse(
          json["createdAt"] ?? ""
      ) ??
      DateTime.now(),

    );

  }





  ConfigModel copyWith({

    bool? isFavorite,

    bool? isActive,

  }){


    return ConfigModel(

      id:id,

      name:name,

      type:type,

      note:note,


      host:host,

      port:port,


      username:username,

      password:password,


      useSni:useSni,

      sni:sni,


      usePayload:usePayload,

      payload:payload,


      useProxy:useProxy,

      proxyHost:proxyHost,

      proxyPort:proxyPort,


      v2rayType:v2rayType,

      uuid:uuid,

      address:address,


      nsDomain:nsDomain,

      publicKey:publicKey,

      dnsIp:dnsIp,


      isActive:isActive ?? this.isActive,

      isFavorite:isFavorite ?? this.isFavorite,


      createdAt:createdAt,

    );


  }


}
