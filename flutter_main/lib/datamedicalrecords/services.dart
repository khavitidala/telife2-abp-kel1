import 'package:http/http.dart' as http;
import 'user.dart';

class Services {
  static const String url = 'https://jsonplaceholder.typicode.com/todos';

  static Future<List<User>> getUsers() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<User> listUsers = usersFromJson(response.body);
        return listUsers;
      } else {
        return List<User>.empty();
      }
    } catch (e){
      return List<User>.empty();
    }
  }
}