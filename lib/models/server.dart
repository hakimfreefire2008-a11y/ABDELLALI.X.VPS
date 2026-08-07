class Server {

  final String name;
  final String country;
  final String type;
  final String host;
  final int ping;
  final bool online;


  Server({

    required this.name,
    required this.country,
    required this.type,
    required this.host,
    required this.ping,
    required this.online,

  });



  factory Server.fromJson(Map<String, dynamic> json) {


    return Server(

      name: json["name"] ?? "",

      country: json["country"] ?? "",

      type: json["type"] ?? "",

      host: json["host"] ?? "",

      ping: json["ping"] ?? 0,

      online: json["online"] ?? false,

    );


  }


}
