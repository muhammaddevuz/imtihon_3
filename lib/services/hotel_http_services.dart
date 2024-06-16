import 'dart:convert';

import 'package:imtihon3/models/hotel.dart';
import 'package:http/http.dart' as http;

class HotelHttpServices {
  Future<List<Hotel>> getHotels() async {
    Uri url =
        Uri.parse("https://imtihon3-default-rtdb.firebaseio.com/hotels.json");

    try {
      final response = await http.get(url);
      if (response.statusCode != 200) {
        throw 'error';
      }

      final Map<String, dynamic> data = jsonDecode(response.body);
      List<Hotel> resultList = [];

      data.forEach((key, value) {
        value['hotelId'] = key;
        resultList.add(Hotel.fromJson(value));
      });

      return resultList;
    } catch (e) {
      rethrow;
    }
  }
}
