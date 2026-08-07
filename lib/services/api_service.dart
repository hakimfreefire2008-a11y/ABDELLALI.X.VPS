import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/server.dart';


class ApiService {


  static const String url =
      "https://raw.githubusercontent.com/hakimfreefire2008-a11y/ABDELLALI.X.VPS/main/servers.json";


  static Future<List<Server>> getServers() async {


    final response =
        await http.get(Uri.parse(url));


    if(response.statusCode == 200){


      final data =
          json.decode(response.body);


      final List servers =
          data["servers"];


      return servers
          .map(
            (item)=> Server.fromJson(item),
          )
          .toList();


    } else {


      throw Exception(
        "Failed loading servers",
      );


    }


  }


}
