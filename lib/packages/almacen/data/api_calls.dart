import 'dart:convert';
import 'dart:io';
import 'package:almacen_android/packages/almacen/model/modelAlmacen.dart';
import 'package:almacen_android/packages/almacen/model/user.dart';
import 'package:almacen_android/packages/common/MindiaHttpClient.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;

class Servidor {

  final String ipServer =
      "http://vps-1791261-x.dattaweb.com:4455/Almacen-0.0.1-SNAPSHOT" ;
      // "http://almacen.eldoce.com.ar";
  var client = MindiaHttpClient(BrowserClient()..withCredentials=false);


  /// Api calls Pedidos.
  Future<List<Pedido>> listarPedidos() async{
    String endpoint = "/ListaPedidos";
    String params = "?and=yes";

    // var response = await client.get(ipServer+endpoint+params);

    // print("ListarPedidos/ Status: "+response.statusCode.toString()+"Body: "+response.body);

    var jsonData = json.decode("[{\"estadopedido\": {\"nombreEstado\": \"test\"},\"usuario\": \"user\",\"fecha\": \"24/04\",\"observaciones\": \"observaciones24\"},{\"estadopedido\": {\"nombreEstado\": \"test\"},\"usuario\": \"user\",\"fecha\": \"24/04\",\"observaciones\": \"observaciones25\"}]");
    List<Pedido> pedidos =[];
    for(var n in jsonData){
      pedidos.add(Pedido.fromJson(n));
    }
    return pedidos;
  }
  //TODO: _
  Future<void> crearPedido(Pedido pedido) async{
    String endpoint = "/AgregarPedido";
    String cantidad,articulos;
    // for(ArticulosPedido a in pedido.articulosPedidos){
    //   cantidad += a.cantidad.toString()+" - ";
    //   articulos += a.articulo.nombre+" - ";
    // }
    String params = "?UserId="+pedido.usuario+"&textAreaObservaciones="+pedido.observaciones+"&inputArt="+articulos+"&inputCantidad"+cantidad;
    var response = await client.get(ipServer+endpoint+params);
    print("crearPedido/ Status: "+response.statusCode.toString()+" Body: "+response.body);
    if(response.statusCode==200){
      EasyLoading.showSuccess("Pedido creado con éxito!");

    }else EasyLoading.showError("Algo salió mal :(\n Por favor vuelva a intentarlo.");
  }

  /**
   * Api calls Articulos.
   */

  Future<List<Articulo>> listarArticulos() async{
    String endpoint = "/ListaArticulosAndroid";
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

  /**
   * Api calls Categorías y Subcategorías
   */

  Future<List<Categoria>> listarCategorias() async{
    String endpoint = '/ListaCategorias';
    List<Categoria> categorias;

    var response = await client.get(ipServer+endpoint);
    print("listarCategorias/ Status: "+response.statusCode.toString()+" Body: "+response.body);
    for(var c in json.decode(response.body)){
      categorias.add(Categoria.fromJson(c));
    }
    return categorias;
  }
  Future<List<Subcategoria>> listarSubcategorias() async{
    String endpoint = '/ListaSubcategoriasCompleta';
    List<Subcategoria> subcategorias;

    var response = await client.get(ipServer+endpoint);
    print("listarSubcategorias/ Status: "+response.statusCode.toString()+" Body: "+response.body);
    for(var c in json.decode(response.body)){
      subcategorias.add(Subcategoria.fromJson(c));
    }
    return subcategorias;
  }
  Future<List<Subcategoria>> listarSubcategoriasByCategoria(String categoria) async{
    String endpoint = '/ListaSubcategorias',params="?inputCat="+categoria;
    List<Subcategoria> categorias;

    var response = await client.get(ipServer+endpoint+params);
    print("listarSubcategoriasByCategoria/ Status: "+response.statusCode.toString()+" Body: "+response.body);
    for(var c in json.decode(response.body)){
      categorias.add(Subcategoria.fromJson(c));
    }
    return categorias;
  }

  /**
   * Api calls Equipos
   */








  /**
   * Api calls Registros
   */

  //TODO: sacarlo para mantener la modularidad, no debería estar dentro de almacen.
  Future<bool> login(String emailText, String passwordText) async {
    String endpoint = "/IniciarSesion";
    String params = "?username=" + emailText + "&pass=" + passwordText +
        "&and=yes";


    var url = ipServer + endpoint + params;
    EasyLoading.showToast(url);

    http.Response response = await http.post(url);

    var n = json.decode(response.body);
    User user = new User.fromJson(n);

    MindiaHttpClient.JSESSIONID = user.jsessionid;

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    print ('Iniciar Sesión/ Status:' +response.statusCode.toString()+ "Body: " + response.body);
    if(response.statusCode==200){
      return true;
    }else return false;

  }
  Future<List<String>> listarUsuarios() async{
    String endpoint = "/ListarUsuarios";
    String params = "?and=yes";
    var url = ipServer + endpoint + params;

    List<String> usuarios;
    http.Response response = await http.get(url);
    print('Listar Usuarios/ Status: '+response.statusCode.toString()+ 'Body: '+ response.body);

    for(var c in json.decode(response.body)){
      usuarios.add(c);
    }
    return usuarios;
  }


}