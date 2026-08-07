import '../models/server.dart';
import 'api_service.dart';


class ServerService {


  static List<Server> servers = [];


  static Future<void> loadServers() async {


    try {


      servers = await ApiService.getServers();


    } catch (e) {


      servers = [];


    }


  }


  static List<Server> getByType(String type) {


    return servers
        .where(
          (server) => server.type == type,
        )
        .toList();


  }


}
