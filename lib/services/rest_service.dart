import 'dart:convert';
import 'package:http/http.dart' as http;

class RestService {
  static final RestService _instance = RestService._constructor();
  factory RestService() {
    return _instance;
  }
 
  RestService._constructor();

  //! Change the baseUrl based on your laptop's IP address.
  //! Make sure you use IP address, not 'localhost'
  //! Don't use https for local JSON-Server
  //! Make sure you specify the port number 3000

  static const String baseUrl =
      'https://us-central1-dulang-backend-rest.cloudfunctions.net/api';

  Future get(String endpoint) async {
    final response = await http.get('$baseUrl/$endpoint');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  Future post(String endpoint, {dynamic data}) async {
    final response = await http.post('$baseUrl/$endpoint',
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  Future patch(String endpoint, {dynamic data}) async {
    final response = await http.patch('$baseUrl/$endpoint',
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  Future delete(String endpoint) async {
    // ignore: unused_local_variable
    final response = await http.delete('$baseUrl/$endpoint',
        headers: {'Content-Type': 'application/json'});

    // if (response.statusCode == 200) {
    //   return jsonDecode(response.body);
    // } else {
    //   print(response.statusCode);
    // }
    // throw response;
  }
}
