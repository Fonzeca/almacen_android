import 'package:http/http.dart' as http;

class MindiaHttpClient extends http.BaseClient {
  final http.Client _inner;
  static String JSESSIONID = "";

  MindiaHttpClient(this._inner);

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    if(JSESSIONID.isNotEmpty){
      request.headers['cookie'] = "JSESSIONID=" + JSESSIONID;
    }
    print(request.headers);
    return _inner.send(request);
  }
}