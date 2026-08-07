import 'dart:convert';

import 'package:crypto/crypto.dart';



class EncryptionService {


  static String encrypt(String data){


    final bytes =
        utf8.encode(data);



    final digest =
        sha256.convert(bytes);



    return base64.encode(
      digest.bytes,
    );


  }





  static String hash(String data){


    final bytes =
        utf8.encode(data);



    final digest =
        sha256.convert(bytes);



    return digest.toString();


  }



}
