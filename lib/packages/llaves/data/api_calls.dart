import 'dart:convert';

import 'package:almacen_android/packages/common/mindia_http_client.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:almacen_android/packages/llaves/model/modelLlaves.dart';


class ServidorLlaves {

  final String ipServer =
  "http://vps-1791261-x.dattaweb.com:4455/almacenapi" ;
      // "http://almacen.eldoce.com.ar";
  var client = http.Client();

  /**
   * Llamadas referentes a llaves
   */
  Future <Llave> getLlaveEspecifica (String id) async{

    String endpoint, params;
    endpoint="/llave";
    params="?id="+id;
    String url = ipServer + endpoint + params;
    print(Uri.parse(url));
    var response=await MindiaHttpClient.instance().get(Uri.parse(url));
    print("getLlaveEspecifica/ Status: "+response.statusCode.toString()+" Body: "+response.body);
    if(response.statusCode==200){

      var n = json.decode(response.body);
      Llave llave = Llave.fromJson(n);
      return llave;
    }
  }

  Future <List<Llave>> getLlaveLikeNombre (String nombre) async{
    String endpoint;
    List<Llave> llaves = [];

    endpoint="/llave/like/" + nombre;
    String url = ipServer + endpoint;

    var response = await MindiaHttpClient.instance().get(Uri.parse(url));
    print("getLlaveLikeNombre/ Status: "+response.statusCode.toString()+" Body: "+response.body);


    if(response.statusCode == 200){
      for(var n in json.decode(response.body)){
        Llave llave = Llave.fromJson(n);
        llaves.add(llave);
      }
    }
    return llaves;
  }

  Future <void> changeLlaveEstado(String id, String entrada, String username) async{
    String endpoint, params;
    endpoint = "/llave/status";
    if(username != null){
      params="?id="+id+"&entrada="+entrada+"&username="+username;
    }else{
      params="?id="+id+"&entrada="+entrada+"&username=";
    }
    var response = await MindiaHttpClient.instance().put(Uri.parse(ipServer+endpoint+params));
    print("changeLlaveEstado/ Status: "+response.statusCode.toString()+", Body: "+response.body);

  }


  Future <List<Llave>> getLlavesEnPosesion() async{
    String endpoint;
    endpoint = "/llave/getPosesion";
    List<Llave> llaves = [];
    var response = await MindiaHttpClient.instance().get(Uri.parse(ipServer+endpoint));
    print("getLlavesPosesion/ Status: "+response.statusCode.toString()+", Body: "+response.body);

    if(response.statusCode == 200){
      var jsonData = json.decode(response.body);
      for(var n in jsonData){
        Llave llave = Llave.fromJson(n);
        llaves.add(llave);
      }
      return llaves;
    }
  }
  Future <List<Llave>> getLlavesEnPosesionDe(String idUser) async {
    String endpoint, params;
    endpoint = "/llave/getPosesionDe";
    params = "?idUser=" + idUser;
    List<Llave> llaves = [];
    var response = await MindiaHttpClient.instance().get(
        Uri.parse(ipServer + endpoint + params));
    print("getLlavesPosesionDe/ Status: " + response.statusCode.toString() +
        ", Body: " + response.body);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var n in jsonData) {
        Llave llave = Llave.fromJson(n);
        llaves.add(llave);
      }
      return llaves;
    }
  }

  /**
   * Llamadas referentes a Grupos de llaves.
   */

  Future <GrupoLlave> getGrupoLlave(String identificacionGrupoLlaves) async{
    String endpoint, params;
    endpoint = "/grupoLlave";
    params = "?identificacion="+identificacionGrupoLlaves;
    var url = Uri.parse(ipServer + endpoint + params);
    var response = await MindiaHttpClient.instance().get(url);
    print("getGrupoLlaveByIdentificacion/"+identificacionGrupoLlaves+"/ Status: "+response.statusCode.toString()+", body: "+response.body);
    if(response.statusCode == 200){
      var n = json.decode(response.body);
      GrupoLlave grupoLlave = GrupoLlave.fromJson(n);
      return grupoLlave;
    }
  }

  Future <void> changeGrupoLlavesStatus(String id, String entrada, String username) async{
    String endpoint = "/grupoLlave/status";
    String params;
    if(username!=null){
      params ="?id="+id+"&entrada="+entrada+"&username="+username;
    }else{
      params ="?id="+id+"&entrada="+entrada;
    }
    var url = Uri.parse(ipServer + endpoint + params);
    var response = await MindiaHttpClient.instance().get(url);
    print("changeGrupoStatus/ Status: "+response.statusCode.toString()+", body: "+response.body);
  }

}