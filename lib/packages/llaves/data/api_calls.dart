import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:almacen_android/packages/llaves/model/modelLlaves.dart';


class ServidorLlaves {

  final String ipServer =
  "http://vps-1791261-x.dattaweb.com:4455/Almacen-0.0.1-SNAPSHOT" ;
      // "http://almacen.eldoce.com.ar";
  var client = http.Client();

  /**
   * Llamadas referentes a llaves
   */
  Future <Llave> getLlaveEspecifica (String id) async{
    //TODO: Vamos a utilizar el id numerico de la base de datos o el id, identificacion que generamos con nombre+id ?
    String endpoint, params;
    endpoint="/getLlave";
    params="?and=yes&id="+id;
    var response=await client.get(Uri.parse(ipServer+endpoint+params));
    print("getLlaveEspecifica/ Status: "+response.statusCode.toString()+" Body: "+response.body);
    var n = json.decode(response.body);
    Llave llave = Llave.fromJson(n);
    return llave;
  }
}