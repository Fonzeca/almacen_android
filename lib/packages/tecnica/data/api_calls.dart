import 'package:almacen_android/packages/common/mindia_http_client.dart';
import 'package:almacen_android/packages/tecnica/model/equipo.dart';
import 'package:almacen_android/packages/tecnica/model/registro.dart';
import 'dart:convert';

import 'package:flutter/material.dart';



class ServidorTecnica {

  final String ipServer =
      "http://vps-1791261-x.dattaweb.com:4455/almacen_api-0.0.1-SNAPSHOT" ;


  /**
   * Llamadas respectivas a Equipos
   */
  Future<List<Equipo>> listarEquipos() async{
    String endpoint = "/equipo";
    String url = ipServer+endpoint;
    List<Equipo> equipos= [];
    var response= await MindiaHttpClient.instance().get(url);
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

    var response = await MindiaHttpClient.instance().get(url);
    print("/detalleEquipo Status: "+response.statusCode.toString()+" Body: "+response.body);
    equipo = Equipo.fromJson(json.decode(response.body));

    return equipo;
  }

  Future<void> eliminarEquipo(String id) async{
    String endpoint = "/equipo/eliminar";
    String params = "?id="+id;
    String url = ipServer+endpoint+params;

    var response = await MindiaHttpClient.instance().get(url);
    print("/eliminarEquipo Status: "+response.statusCode.toString()+", Body: "+response.body);

  }

  Future<void>cambiarEstadoEquipo(String id,bool enUso) async{
    String endpoint = "/equipo/status";
    int idi = id as int;
    String params = "?enUso="+enUso.toString()+"&id="+idi.toString();
    String url = ipServer+endpoint+params;

    var response = await MindiaHttpClient.instance().put(url);
    print("cambiarEstadoEquipo/ Status: "+response.statusCode.toString()+", Body: "+response.body);
  }

  /**
   * Llamadas respectivas a Registros
   */
  Future<List<Registro>> listarRegistros() async{
    String endpoint = "/registro";
    String url = ipServer+endpoint;
    List<Registro> registros=[];
    var response= await MindiaHttpClient.instance().get(url);
    print("/listarRegistros Status: "+response.statusCode.toString()+" Body: "+response.body);
    for(var n in json.decode(response.body)){
      Registro registro= Registro.fromJson(n);
      registros.add(registro);
    }
    return registros;
  }



}