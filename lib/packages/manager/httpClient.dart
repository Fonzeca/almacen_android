import 'package:http/http.dart' as http;

class httpClient extends http.BaseClient{
  final http.Client _inner;

  httpClient(this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async{
    request.headers['Content-Type'] = "application/json; charset=utf-8";
    return _inner.send(request);
  }


}