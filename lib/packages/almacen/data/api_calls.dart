import 'dart:convert';
import 'dart:io';

import 'package:almacen_android/packages/almacen/model/modelAlmacen.dart';
import 'package:almacen_android/packages/manager/httpClient.dart';
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
    try{
      var response = await client.get(ipServer+endpoint);
      print("ListarPedidos/ Status: "+response.statusCode.toString()+"Body: "+response.body);
      var jsonData = json.decode(response.body);
      List<Pedido> pedidos =[];
      for(var n in jsonData){
        pedidos.add(Pedido.fromJson(n));
      }
      return pedidos;
    }
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
  Future<void> crearArticulo(Articulo articulo) async{
    String endpoint = "/NuevoArticulo";
    String params = "?inputProveedor="+articulo.proveedor.provNombre+
    "&inputNombre="+articulo.nombre+
    "&inputSMinimo="+articulo.stockMinimo+
    "&inputStock="+articulo.stock+
    "&costo="+ articulo.costo+
    "&categoria="+ articulo.subcategoria;

    var response = await client.post(ipServer+endpoint+params);
    print("crearArticulo /Status: "+response.statusCode.toString()+" Body: "+response.body);
    EasyLoading.show();
    if(response.statusCode==200){
      EasyLoading.dismiss();
      EasyLoading.showSuccess("Artículo creado con éxito!");

    }else {
      EasyLoading.dismiss();
      EasyLoading.showError("Ocurrió un error al cargar el artículo.");
    }


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