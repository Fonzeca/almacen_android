import 'dart:convert';

import 'package:almacen_android/packages/common/mindia_http_client.dart';
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
  Future <Llave> getLlaveEspecifica (String identificacion) async{

    //El String identificación es el que se obtiene del Qr y está formado por el nombre, guión e id de la llave. 'Llave de prueba-2'.

    String endpoint, params;
    endpoint="/llave";
    params="?identificacion="+identificacion;
    var response=await MindiaHttpClient.instance().get(Uri.parse(ipServer+endpoint+params));
    print("getLlaveEspecifica/ Status: "+response.statusCode.toString()+" Body: "+response.body);

    var n = json.decode(response.body);
    Llave llave = Llave.fromJson(n);
    return llave;
  }

  Future <void> changeLlaveEstado(String identificacion, String entrada) async{
    String endpoint, params;
    endpoint = "/llave/change";
    params="?identificacion="+identificacion+"&entrada="+entrada;
    var response = await MindiaHttpClient.instance().get(Uri.parse(ipServer+endpoint+params));
    print("changeLlaveEstado/ Status: "+response.statusCode.toString()+", Body: "+response.body);

  }
}