import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:assignement_1/model_class.dart';

class RequestClass{
  Future<Address> fetchData() async {

    String username = 'am9uZUAyOTc4';
    String password = 'RklUTkVTU0AjMTIz';
    String basicAuth = 'Basic ' + base64.encode(utf8.encode('$username:$password'));

    var bodyData =  <String, dynamic>{};
      bodyData['pandit_id'] = '7';
      bodyData['booking_id'] = '843';

    final response = await http.post(Uri.parse('https://dev-env.vaikunth.co/api/viewdetail'),
        headers: <String, String>{'authorization': basicAuth}, body: bodyData);

    if (response.statusCode == 200) {
      return Address.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}