import 'package:http/http.dart';


class NetworkHelper{
  final String url;
  NetworkHelper(this.url);
  Future<Response> getData() async{
    Response response = await get(url);
    return response;
  }


}