import 'package:imtihon3/models/hotel.dart';
import 'package:imtihon3/services/admin_panel_http_service.dart';

class AdminRepository {
  final AdminHttpService _hotelHttpService = AdminHttpService();

  Future<List<Hotel>> getHotelsRepo() async {
    return _hotelHttpService.getHotels();
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
    await _hotelHttpService.addHotel(
      amenities: amenities,
      comment: comment,
      hotelName: hotelName,
      description: description,
      imageUrl: imageUrl,
      price: price,
      rating: rating,
      rooms: rooms,
      location: location,
    );
  }

  Future<void> deleteHotels({required String hotelId}) async {
    await _hotelHttpService.deleteHotel(hotelId: hotelId);
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
    await _hotelHttpService.editHotels(
      hotelId: hotelId,
      newAmenities: newAmenities,
      newComment: newComment,
      newHotelName: newHotelName,
      newDescription: newDescription,
      newImageUrl: newImageUrl,
      newPrice: newPrice,
      newRating: newRating,
      newSpaceRooms: newSpaceRooms,
      newLocation: newLocation
    );
  }
}
