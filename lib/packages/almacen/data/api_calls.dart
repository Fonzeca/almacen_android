import 'dart:convert';

import 'package:almacen_android/packages/almacen/model/modelAlmacen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

class Servidor {

  final String ipServer = "http://almacen.eldoce.com.ar/";
  var client = http.Client();


  /**
   * Api calls Pedidos.
   */
  Future<List<Pedido>> listarPedidos() async{
    String endpoint = "/ListaPedidos";
    var response = await client.get(ipServer+endpoint);
    print("ListarPedidos/ Status: "+response.statusCode.toString()+"Body: "+response.body);
    var jsonData = json.decode(response.body);
    List<Pedido> pedidos =[];
    for(var n in jsonData){
      pedidos.add(Pedido.fromJson(n));
    }
    return pedidos;
  }
  //TODO: _
  Future<void> crearPedido(Pedido pedido) async{
    String endpoint = "/";
  }

  /**
   * Api calls Articulos.
   */

  Future<List<Articulo>> listarArticulos() async{
    String endpoint = "/ListaArticulos";
    try{

      var response = await client.post(ipServer+endpoint);
      print("listarArticulos/ Status: " +response.statusCode.toString()+ "Body: " + response.body);
      var jsonData = json.decode(response.body);
      List<Articulo> articulos= [];
      for(var n in jsonData){
        articulos.add( Articulo.fromJson(n));
      }
      return articulos;
    }
    //TODO: Verificar si esto es necesario, lo agregué para que opere con el 'cliente' que estoy utilizando pero de igual manera no funciona por el xmlhttp error.
    finally {
      client.close();
    }
  }
  Future<Articulo> getArticuloByNombre(String nombreArticulo) async{
    String endpoint = '/Articulo';
    String params = '?nombreArticulo='+nombreArticulo;

    var response = await client.post(ipServer+endpoint+params);
    print("getArticuloByNombre/ Status: "+response.statusCode.toString()+" Body: "+response.body);
    var n = json.decode(response.body);
    Articulo articulo = new Articulo.fromJson(n);
    return articulo;
  }




















  //TODO: sacarlo para mantener la modularidad, no debería estar dentro de almacen.
  void login(String emailText, String passwordText) async{
    String endpoint = "/IniciarSesion";
    String params = "?username="+emailText+"&pass="+passwordText;


    var url = ipServer+endpoint+params;
    EasyLoading.showToast(url);
    //TODO: que mierda es hmlhttprequest error?

    var response = await http.post(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');


    print ('Iniciar Sesión/ Status:' +response.statusCode.toString()+ "Body: " + response.body);

  }


}