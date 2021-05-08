import 'package:http/http.dart' as http;


class MindiaHttpClient extends http.BaseClient {
  static MindiaHttpClient _mindiaHttpClient;

  final http.Client _inner;
  static String TOKEN = "";

  MindiaHttpClient(this._inner);

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    if(TOKEN.isNotEmpty){
      request.headers['Content-Type'] = "application/json; charset=utf-8";
      request.headers['Authorization'] = "Bearer " + TOKEN;
    }
    print(request.headers);
    return _inner.send(request);
  }

  static MindiaHttpClient instance(){
    if(_mindiaHttpClient == null){
      _mindiaHttpClient = MindiaHttpClient(http.Client());
    }
    return _mindiaHttpClient;
  }


}