import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:imtihon3/models/hotel.dart';

class AdminHttpService {
  Future<List<Hotel>> getHotels() async {
    final Uri url =
        Uri.parse('https://imtihon3-default-rtdb.firebaseio.com/hotels.json');
    final http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data == null) {
        return [];
      }
      List<Hotel> loadedHotels = [];

      data.forEach((key, value) {
        value['hotelId'] = key;
        loadedHotels.add(Hotel.fromJson(value));
      });

      return loadedHotels;
    } else {
      throw Exception('error: HotelHttpService().getHotels');
    }
  }

  Future<void> addHotel({
    required List<String> amenities,
    required List<String> comment,
    required String hotelName,
    required String description,
    required List<String> imageUrl,
    required double price,
    required List<int> rating,
    required List<int> rooms,
    required String location,
  }) async {
    Map<String, dynamic> hotelData = {
      'amenities': amenities,
      'comment': comment,
      'hotelName': hotelName,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'rating': rating,
      'spaceRooms': rooms,
      'location' : location,
    };

    final Uri url =
        Uri.parse('https://imtihon3-default-rtdb.firebaseio.com/hotels.json');
    final response = await http.post(
      url,
      body: jsonEncode(hotelData),
    );
  }

  Future<void> deleteHotel({required String hotelId}) async {
    print(hotelId);
    final Uri url = Uri.parse(
        'https://imtihon3-default-rtdb.firebaseio.com/hotels/$hotelId.json');
    final response = await http.delete(url);
  }

  Future<void> editHotels({
    required hotelId,
    required List<String> newAmenities,
    required List<String> newComment,
    required String newHotelName,
    required String newDescription,
    required List<String> newImageUrl,
    required double newPrice,
    required List<int> newRating,
    required List<int> newSpaceRooms,
    required String newLocation,
  }) async {
    final Uri url = Uri.parse(
        'https://imtihon3-default-rtdb.firebaseio.com/hotels/$hotelId.json');
    Map<String, dynamic> hotelData = {
      'new_amenities': newAmenities,
      'new_comment': newComment,
      'new_hotelName': newHotelName,
      'new_description': newDescription,
      'new_image_url': newImageUrl,
      'new_price': newPrice,
      'new_rating': newRating,
      'new_spaceRooms': newSpaceRooms,
      'new_location':newLocation
    };

    await http.patch(
      url,
      body: jsonEncode(hotelData),
    );
  }
}
