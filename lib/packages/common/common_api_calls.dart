import 'dart:convert';
import 'dart:io';
import 'package:almacen_android/packages/almacen/model/pojo/loggedUser.dart';
import 'package:almacen_android/packages/almacen/model/token.dart';
import 'package:almacen_android/packages/common/mindia_http_client.dart';
import 'package:http/http.dart' as http;

class CommonApiCalls {

  final String ipServer =
      "http://vps-1791261-x.dattaweb.com:4455/almacen_api-0.0.1-SNAPSHOT" ;
  // "http://almacen.eldoce.com.ar";

  Future<LoggedUser> getLoggedUser() async {
    String endpoint = "/loggedUser";

    var url = ipServer + endpoint;

    http.Response response = await MindiaHttpClient.instance().get(url);
    var n = json.decode(response.body);

    LoggedUser loggedUser = new LoggedUser.fromJson(n);

    return loggedUser;
  }

  Future<bool> login(String emailText, String passwordText) async {
    String endpoint = "/login";
    String params = "?username=" + emailText + "&password=" + passwordText;

    var url = ipServer + endpoint + params;

    http.Response response = await http.post(url);
    var n = json.decode(response.body);
    Token token = new Token.fromJson(n);
    MindiaHttpClient.TOKEN = token.token;

    if(response.statusCode == 200){
      return true;
    }else return false;

  }


}