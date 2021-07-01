import 'dart:convert';
import 'dart:io';
import 'package:almacen_android/packages/almacen/model/pojo/loggedUser.dart';
import 'package:almacen_android/packages/almacen/model/token.dart';
import 'package:almacen_android/packages/common/mindia_http_client.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CommonApiCalls {

  final String ipServer = GlobalConfiguration().get("url_api");

  Future<LoggedUser> getLoggedUser() async {
    String endpoint = "/loggedUser";

    var url = ipServer + endpoint;

    http.Response response = await MindiaHttpClient.instance().get(Uri.parse(url));
    var n = json.decode(response.body);
    print("/getLoggedUser Status:" +response.statusCode.toString()+", body: "+response.body);

    LoggedUser loggedUser = new LoggedUser.fromJson(n);

    return loggedUser;
  }

  Future<bool> validate() async {
    String endpoint = "/validate";

    var url = ipServer + endpoint;

    http.Response response = await MindiaHttpClient.instance().get(Uri.parse(url));
    print("/validate Status: "+response.statusCode.toString()+", body: "+response.body);
    if (response.statusCode == 403){
      return false;
    }
    return true;
  }

  Future<bool> login(String emailText, String passwordText) async {
    String endpoint = "/login";
    String params = "?username=" + emailText + "&password=" + passwordText;

    var url = ipServer + endpoint + params;

    http.Response response = await http.post(Uri.parse(url));
    var n = json.decode(response.body);
    Token token = new Token.fromJson(n);
    MindiaHttpClient.TOKEN = token.token;

    if(response.statusCode == 200){
      return true;
    }else return false;

  }
  Future<void> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('token');
    MindiaHttpClient.TOKEN = "";
  }

  Future <List<String>> getUserLikeNombre (String nombre) async{
    String endpoint;
    List<String> users = [];

    endpoint = "/users/like/" + nombre;
    String url = ipServer + endpoint;

    var response = await MindiaHttpClient.instance().get(Uri.parse(url));
    print("getUserLikeNombre/ Status: "+response.statusCode.toString()+" Body: "+response.body);


    if(response.statusCode == 200){
      for(var n in json.decode(response.body)){
        users.add(n);
      }
    }
    return users;
  }
}