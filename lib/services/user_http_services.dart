import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imtihon3/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHttpServices {
  Future<User> getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Uri url =
        Uri.parse("https://imtihon3-default-rtdb.firebaseio.com/users.json");
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    List<User> loadedTodos = [];
    if (data != null) {
      data.forEach((key, value) {
        if (value["userId"] == sharedPreferences.getString("userId")) {
          value['id'] = key;
          loadedTodos.add(User.fromJson(value));
        }
      });
    }
    return loadedTodos[0];
  }

  Future<User> fetchUser(String userId) async {
    final url =
        Uri.parse('https://imtihon3-default-rtdb.firebaseio.com/users.json');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      var box;
      data.forEach((key, value) {
        if (value["userId"] == userId) {
          value['id'] = key;
          box = User.fromJson(value);
        }
      });
      return box;
      // User user = data.values.firstWhere((user) => user['userId'] == userId);
      // return user;
    }
    return User(
        id: 'id',
        userId: userId,
        name: 'name',
        email: 'email',
        birthday: DateTime.now(),
        orderedHotels: ['orderedHotels']);
  }

  Future<void> addUser(String email, String userId) async {
    Uri url =
        Uri.parse("https://imtihon3-default-rtdb.firebaseio.com/users.json");

    Map<String, dynamic> user = {
      "userId": userId,
      "name": "",
      "email": email,
      "birthday": DateTime.now().toString(),
      "orderedHotels": [
        "aa",
      ],
    };
    await http.post(
      url,
      body: jsonEncode(user),
    );
  }

  Future<void> editUser(String id, String newName, String newBirthday) async {
    Uri url = Uri.parse(
        "https://imtihon3-default-rtdb.firebaseio.com/users/$id.json");

    Map<String, dynamic> todoData = {
      "name": newName,
      "birthday": newBirthday,
    };
    await http.patch(
      url,
      body: jsonEncode(todoData),
    );
  }
}
