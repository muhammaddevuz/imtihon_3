import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:imtihon3/controllers/user_controller.dart';
import 'package:imtihon3/models/hotel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHttpServices {
  final String _apiKey = "AIzaSyACUcRCGNgaGIZ9jZaoUa19DHG9VVGqVFg";

  Future<void> register(String email, String password) async {
    UserController userController = UserController();
    Uri url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_apiKey");

    try {
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            "email": email,
            "password": password,
            "returnSecureToken": true,
          },
        ),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw (data['error']['message']);
      }
      userController.addUser(email, data['localId']);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString("userId", data['localId']);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    Uri url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_apiKey");

    try {
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            "email": email,
            "password": password,
            "returnSecureToken": true,
          },
        ),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw (data['error']['message']);
      }

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString("userId", data['localId']);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkAuth() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");

    if (token == null) {
      return false;
    }

    DateTime expiryDate =
        DateTime.parse(sharedPreferences.getString("expiryDate")!);

    return expiryDate.isAfter(DateTime.now());
  }

  Future<void> sendPasswordEmail(String email) async {
    Uri url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=$_apiKey");

    try {
      final response = await http.post(url,
          body: jsonEncode({'email': email, 'requestType': 'PASSWORD_RESET'}));
      final data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw data['error']['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getHotels() async {
    Uri url =
        Uri.parse("https://imtihon3-default-rtdb.firebaseio.com/hotels.json");

    try {
      final response = await http.get(url);
      if (response.statusCode != 200) {
        throw 'error';
      }

      final Map<String, dynamic> data = jsonDecode(response.body);

      data.forEach((key, value) {
        value['hotelId'] = key;

        Hotel json = Hotel(
            hotelId: value['hotelId'],
            amenities: value['amenities'],
            comment: value['comment'],
            description: value['description'],
            hotelName: value['hotelName'],
            imageUrl: value['imageUrl'],
            price: double.parse(value['price'].toString()),
            rating: value['rating'],
            spaceRooms: value['spaceRooms']);
        print(json);
      });

      return data;
    } catch (e) {
      rethrow;
    }
  }
}
