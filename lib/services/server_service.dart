import '../models/server.dart';


class ServerService {


static List<Server> servers = [


Server(

name: "Morocco SSH 1",
country: "🇲🇦 Morocco",
type: "SSH",
host: "ssh.example.com",
ping: 45,
online: true,

),


Server(

name: "Germany VLESS",
country: "🇩🇪 Germany",
type: "VLESS",
host: "de.example.com",
ping: 80,
online: true,

),


Server(

name: "UDP Fast",
country: "🇺🇸 USA",
type: "UDP",
host: "udp.example.com",
ping: 60,
online: false,

),


];


}
