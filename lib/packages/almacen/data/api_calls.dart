import 'dart:convert';
import 'dart:io';
import 'package:almacen_android/packages/almacen/model/modelAlmacen.dart';
import 'package:almacen_android/packages/almacen/model/pojo/articulo_nvopedido.dart';
import 'package:almacen_android/packages/almacen/model/pojo/nuevo_pedido.dart';
import 'package:almacen_android/packages/almacen/model/token.dart';
import 'package:almacen_android/packages/almacen/model/user.dart';
import 'package:almacen_android/packages/common/mindia_http_client.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

class Servidor {

  final String ipServer =
      "http://vps-1791261-x.dattaweb.com:4455/almacen_api-0.0.1-SNAPSHOT" ;
      // "http://almacen.eldoce.com.ar";


  /// Api calls Pedidos.
  Future<List<Pedido>> listarPedidos() async{
    String endpoint = "/pedido";

    var response = await MindiaHttpClient.instance().get(ipServer+endpoint);

    var jsonData = json.decode(response.body);

    List<Pedido> pedidos =[];
    for(var n in jsonData){
      print(n);
      pedidos.add(Pedido.fromJson(n));
    }
    return pedidos;
  }
  //TODO: _
  Future<void> crearPedido(String observaciones, String user, List<Artxcant> articulos) async{
    String endpoint = "/pedido";
    String cant="", arts="";

    for(Artxcant a in articulos){
      cant += a.cantidad.toString()+" - ";
      arts += a.nombreArt.toString()+" - ";
    }
    NuevoPedido createPedidoRequest= new NuevoPedido(observaciones,user,arts,cant);
    String params = "?User="+user+"&textAreaObservaciones="+observaciones+"&inputArt="+arts+"&inputCantidad"+cant;
    var response = await MindiaHttpClient.instance().post(ipServer+endpoint,body: jsonEncode(createPedidoRequest));
    print("crearPedido/ Status: "+response.statusCode.toString()+" Body: "+response.body);

    if(response.statusCode==200){
      EasyLoading.showSuccess("Pedido creado con éxito!");

    }else EasyLoading.showError("Algo salió mal :(\n Por favor vuelva a intentarlo.");
  }

  /// Api calls Articulos.

  Future<List<Articulo>> listarArticulos() async{
    String endpoint = "/articulo";

    var response = await MindiaHttpClient.instance().get(ipServer+endpoint);
    var jsonData = json.decode(response.body);
    List<Articulo> articulos= [];
    for(var n in jsonData){
      articulos.add(Articulo.fromJson(n));
    }
    return articulos;
  }
  Future<Articulo> getArticuloByNombre(String nombreArticulo) async{
    String endpoint = '/articulo/' + nombreArticulo;

    var response = await MindiaHttpClient.instance().get(ipServer+endpoint);
    var n = json.decode(response.body);
    Articulo articulo = new Articulo.fromJson(n);
    return articulo;
  }

  /// Api calls Categorías y Subcategorías

  Future<List<Categoria>> listarCategorias() async{
    String endpoint = '/categorias';
    List<Categoria> categorias;

    var response = await MindiaHttpClient.instance().get(ipServer+endpoint);
    for(var c in json.decode(response.body)){
      categorias.add(Categoria.fromJson(c));
    }
    return categorias;
  }

  ///Api calls Usuarios TODO: extraer fuera del modulo almacen?

  Future<List<String>> listarUsuarios() async{
    String endpoint = "/users";
    var url = ipServer + endpoint;

    List<String> usuarios=[];
    http.Response response = await MindiaHttpClient.instance().get(url);

    for(var c in json.decode(response.body)){
      usuarios.add(User.fromJson(c).username);
    }
    return usuarios;
  }


}