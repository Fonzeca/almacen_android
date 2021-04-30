import 'dart:convert';
import 'dart:io';
import 'package:almacen_android/packages/almacen/model/modelAlmacen.dart';
import 'package:almacen_android/packages/almacen/model/pojo/articulo_nvopedido.dart';
import 'package:almacen_android/packages/almacen/model/token.dart';
import 'package:almacen_android/packages/almacen/model/user.dart';
import 'package:almacen_android/packages/common/mindia_http_client.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;

class Servidor {

  final String ipServer =
      "http://vps-1791261-x.dattaweb.com:4455/almacen_api-0.0.1-SNAPSHOT" ;
      // "http://almacen.eldoce.com.ar";


  /// Api calls Pedidos.
  Future<List<Pedido>> listarPedidos() async{
    String endpoint = "/ListaPedidos";
    String params = "?and=yes";

    // var response = await MindiaHttpClient.instance().get(ipServer+endpoint+params);

    var jsonData = json.decode("[{\"estadopedido\": {\"nombreEstado\": \"test\"},\"usuario\": \"user\",\"fecha\": \"24/04\",\"observaciones\": \"observaciones24\"},{\"estadopedido\": {\"nombreEstado\": \"test\"},\"usuario\": \"user\",\"fecha\": \"24/04\",\"observaciones\": \"observaciones25\"}]");
    List<Pedido> pedidos =[];
    for(var n in jsonData){
      pedidos.add(Pedido.fromJson(n));
    }
    return pedidos;
  }
  //TODO: _
  Future<void> crearPedido(String observaciones, String user, List<Artxcant> articulos) async{
    String endpoint = "/AgregarPedido";
    String cantidad,articulos;
    // for(ArticulosPedido a in pedido.articulosPedidos){
    //   cantidad += a.cantidad.toString()+" - ";
    //   articulos += a.articulo.nombre+" - ";
    // }
    String params = "?User="+user+"&textAreaObservaciones="+observaciones+"&inputArtxCant="+articulos;
    var response = await MindiaHttpClient.instance().get(ipServer+endpoint+params);
    if(response.statusCode==200){
      EasyLoading.showSuccess("Pedido creado con éxito!");

    }else EasyLoading.showError("Algo salió mal :(\n Por favor vuelva a intentarlo.");
  }

  /**
   * Api calls Articulos.
   */

  Future<List<Articulo>> listarArticulos() async{
    String endpoint = "/articulos";

    var response = await MindiaHttpClient.instance().get(ipServer+endpoint);
    var jsonData = json.decode(response.body);
    List<Articulo> articulos= [];
    for(var n in jsonData){
      articulos.add( Articulo.fromJson(n));
    }
    return articulos;
  }
  Future<Articulo> getArticuloByNombre(String nombreArticulo) async{
    String endpoint = '/Articulo';
    String params = '?nombreArticulo='+nombreArticulo;

    var response = await MindiaHttpClient.instance().post(ipServer+endpoint+params);
    var n = json.decode(response.body);
    Articulo articulo = new Articulo.fromJson(n);
    return articulo;
  }

  /**
   * Api calls Categorías y Subcategorías
   */

  Future<List<Categoria>> listarCategorias() async{
    String endpoint = '/ListaCategorias';
    List<Categoria> categorias;

    var response = await MindiaHttpClient.instance().get(ipServer+endpoint);
    for(var c in json.decode(response.body)){
      categorias.add(Categoria.fromJson(c));
    }
    return categorias;
  }
  Future<List<Subcategoria>> listarSubcategorias() async{
    String endpoint = '/ListaSubcategoriasCompleta';
    List<Subcategoria> subcategorias;

    var response = await MindiaHttpClient.instance().get(ipServer+endpoint);
    for(var c in json.decode(response.body)){
      subcategorias.add(Subcategoria.fromJson(c));
    }
    return subcategorias;
  }
  Future<List<Subcategoria>> listarSubcategoriasByCategoria(String categoria) async{
    String endpoint = '/ListaSubcategorias',params="?inputCat="+categoria;
    List<Subcategoria> categorias;

    var response = await MindiaHttpClient.instance().get(ipServer+endpoint+params);
    for(var c in json.decode(response.body)){
      categorias.add(Subcategoria.fromJson(c));
    }
    return categorias;
  }

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