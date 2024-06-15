import '../../models/hotel.dart';
import 'admin_repository.dart';

class AdminController {
  final AdminRepository _adminRepository = AdminRepository();

  List<Hotel> _hotelsList = [];

  Future<List<Hotel>> get hotelsList async {
    _hotelsList = await _adminRepository.getHotelsRepo();
    return [..._hotelsList];
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
    print('kirdi---------------');
    await _adminRepository.addHotel(
        amenities: amenities,
        comment: comment,
        hotelName: hotelName,
        description: description,
        imageUrl: imageUrl,
        price: price,
        rating: rating,
        rooms: rooms,
        location: location);
  }

  Future<void> deleteHotel({required String hotelId}) async {
    await _adminRepository.deleteHotels(hotelId: hotelId);
    _hotelsList.removeWhere((Hotel hotel) => hotelId == hotelId);
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
    await _adminRepository.editHotels(
      hotelId: hotelId,
      newAmenities: newAmenities,
      newComment: newComment,
      newHotelName: newHotelName,
      newDescription: newDescription,
      newImageUrl: newImageUrl,
      newPrice: newPrice,
      newRating: newRating,
      newSpaceRooms: newSpaceRooms,
      newLocation: newLocation,
    );
    final int index =
        _hotelsList.indexWhere((Hotel hotel) => hotel.hotelId == hotelId);
    _hotelsList[index].amenities = newAmenities;
    _hotelsList[index].comment = newAmenities;
    _hotelsList[index].hotelName = newHotelName;
    _hotelsList[index].description = newDescription;
    _hotelsList[index].imageUrl = newImageUrl;
    _hotelsList[index].price = newPrice;
    _hotelsList[index].rating = newRating;
    _hotelsList[index].spaceRooms = newSpaceRooms;
    _hotelsList[index].location = newLocation;
  }
}
