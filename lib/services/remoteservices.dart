import '../models/todomodel.dart';
import 'package:http/http.dart' as http;

class Dataservices {
  static var client = http.Client();

  static Future<List<Todo>> getTodo() async {
    var response = await client
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

    if (response.statusCode == 200) {
      var data = response.body;
      return todoFromJson(data);
    } else {
      return null;
    }
  }
}
