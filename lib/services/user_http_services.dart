import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imtihon3/models/hotel.dart';
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
  Future<List<User>> getUsers() async {
    Uri url =
        Uri.parse("https://imtihon3-default-rtdb.firebaseio.com/users.json");
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    List<User> loadedUsers = [];
    if (data != null) {
      data.forEach((key, value) {
          value['id'] = key;
          loadedUsers.add(User.fromJson(value));
      });
    }
    return loadedUsers;
  }

  Future<List<Hotel>> fetchUser(String userId) async {
    final urlUsers =
        Uri.parse('https://imtihon3-default-rtdb.firebaseio.com/users.json');
    Uri urlHotels =
        Uri.parse("https://imtihon3-default-rtdb.firebaseio.com/hotels.json");
    final response = await http.get(urlUsers);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      User? box;
      data.forEach((key, value) {
        if (value["userId"] == userId) {
          value['id'] = key;
          box = User.fromJson(value);
        }
      });
      List<Hotel> orderedHotels = [];
      if (box != null) {
        final responseHotels = await http.get(urlHotels);
        final Map<String, dynamic> dataHotels =
            json.decode(responseHotels.body);
        for (var element in box!.orderedHotels) {
          dataHotels.forEach((key, value) {
            if (element == key) {
              value['hotelId'] = key;
              orderedHotels.add(Hotel.fromJson(value));
            }
          });
        }
      }
      return orderedHotels;
    }
    return [];
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

  Future<void> editUser(String id, String newnNme, String newBirthday) async {
    Uri url = Uri.parse(
        "https://imtihon3-default-rtdb.firebaseio.com/users/$id.json");

    Map<String, dynamic> todoData = {
      "name": newnNme,
      "birthday": newBirthday,
    };
    await http.patch(
      url,
      body: jsonEncode(todoData),
    );
  }
}
