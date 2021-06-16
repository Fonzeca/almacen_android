import 'package:almacen_android/packages/common/mindia_http_client.dart';
import 'package:almacen_android/packages/tecnica/model/equipo.dart';
import 'package:almacen_android/packages/tecnica/model/grupoEquipo.dart';
import 'package:almacen_android/packages/tecnica/model/registro.dart';
import 'dart:convert';

import 'package:flutter/material.dart';



class ServidorTecnica {

  final String ipServer =
      "http://vps-1791261-x.dattaweb.com:4455/almacenapi" ;


  /**
   * Llamadas respectivas a Equipos
   */
  Future<List<Equipo>> listarEquipos() async{
    String endpoint = "/equipo";
    String url = ipServer+endpoint;
    List<Equipo> equipos= [];
    var response= await MindiaHttpClient.instance().get(Uri.parse(url));
    print("/listarEquipos Status: "+response.statusCode.toString()+" Body: "+response.body);
    var jsonData = json.decode(response.body);
    for(var n in jsonData){
      Equipo equipo= Equipo.fromJson(n);
      equipos.add(equipo);
    }
    return equipos;
  }

  Future<Equipo> getDetalleEquipo(String id) async{
    String endpoint = "/equipo/detalle";
    String params = "?id="+id;
    String url = ipServer+endpoint+params;
    Equipo equipo;

    var response = await MindiaHttpClient.instance().get(Uri.parse(url));
    print("/detalleEquipo Status: "+response.statusCode.toString()+" Body: "+response.body);
    equipo = Equipo.fromJson(json.decode(response.body));

    return equipo;
  }

  Future<void> eliminarEquipo(String id) async{
    String endpoint = "/equipo/eliminar";
    String params = "?id="+id;
    String url = ipServer+endpoint+params;

    var response = await MindiaHttpClient.instance().get(Uri.parse(url));
    print("/eliminarEquipo Status: "+response.statusCode.toString()+", Body: "+response.body);

  }

  Future<void>cambiarEstadoEquipo(int id) async{
    String endpoint = "/equipo/status";
    String params = "?id="+id.toString();
    String url = ipServer+endpoint+params;

    var response = await MindiaHttpClient.instance().put(Uri.parse(url));
    print("cambiarEstadoEquipo/ Status: "+response.statusCode.toString()+", Body: "+response.body);

  }

  /**
   * Llamas respectivas a Grupos de Equipos.
   */

  Future<GrupoEquipo>getGrupoEquipoByQr(String identificacion) async{
    String endpoint = "/grupoEquipo";
    String params = "?identificacion="+identificacion;
    var url = Uri.parse(ipServer+endpoint+params);

    var response = await MindiaHttpClient.instance().get(url);
    print("getGrupoEquipoByIdentificacion/ "+identificacion+" Status: "+response.statusCode.toString()+", body: "+response.body);
    if(response.statusCode == 200){
      var n = json.decode(response.body);
      return GrupoEquipo.fromJson(n);
    }
  }

  Future<void> cambiarEstadoGrupoEquipo(String id, String entrada) async{
      String endpoint = "/grupoLlave/status";
      String params ="?id="+id+"&entrada="+entrada;
      var url = Uri.parse(ipServer + endpoint + params);
      var response = await MindiaHttpClient.instance().get(url);
      print("changeGrupoEquiposStatus/ Status: "+response.statusCode.toString()+", body: "+response.body);
  }

  /**
   * Llamadas respectivas a Registros
   */
  Future<List<Registro>> listarRegistros() async{
    String endpoint = "/registro";
    String url = ipServer+endpoint;
    List<Registro> registros=[];
    var response= await MindiaHttpClient.instance().get(Uri.parse(url));
    print("/listarRegistros Status: "+response.statusCode.toString()+" Body: "+response.body);
    for(var n in json.decode(response.body)){
      Registro registro= Registro.fromJson(n);
      registros.add(registro);
    }
    return registros;
  }




}