import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imtihon3/models/hotel.dart';

class AdminHttpService {

  Future<List<Hotel>> getHotels() async {
    Uri url = Uri.parse("https://imtihon3-default-rtdb.firebaseio.com/hotels.json");

    try {
      final response = await http.get(url);
      if (response.statusCode != 200) {
        throw 'Failed to load hotels';
      }

      if (response.body == 'null') {
        return [];
      }

      final Map<String, dynamic>? data = jsonDecode(response.body);
      if (data == null) {
        return [];
      }

      List<Hotel> resultList = [];
      data.forEach((key, value) {
        if (value != null && value is Map<String, dynamic>) {
          value['hotelId'] = key;
          resultList.add(Hotel.fromJson(value));
        }
      });

      return resultList;
    } catch (e) {
      rethrow;
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
    final Uri url = Uri.parse(
        'https://imtihon3-default-rtdb.firebaseio.com/hotels/$hotelId.json');
    final response = await http.delete(url);
  }

  Future<void> editHotels({
    required String hotelId,
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

    Hotel updatedHotel = Hotel(
      hotelId: hotelId,
      amenities: newAmenities,
      comment: newComment,
      hotelName: newHotelName,
      description: newDescription,
      imageUrl: newImageUrl,
      price: newPrice,
      rating: newRating,
      spaceRooms: newSpaceRooms,
      location: newLocation,
    );

    final Uri url =
    Uri.parse('https://imtihon3-default-rtdb.firebaseio.com/hotels/$hotelId.json');
    await http.patch(
    url,
    body: jsonEncode(updatedHotel),
    );
  }
}
