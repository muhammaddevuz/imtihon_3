import 'package:imtihon3/models/hotel.dart';
import 'package:imtihon3/services/hotel_http_services.dart';

class HotelController {
  HotelHttpServices authHttpServices = HotelHttpServices();
  Future<List<Hotel>> getHotels() async {
    return authHttpServices.getHotels();
  }

  Future<List<String>> getAllAminities() async {
    List<String> allAminities = [];
    List<Hotel> hotels = await getHotels();
    for (Hotel hotel in hotels) {
      for (String aminity in hotel.amenities) {
        allAminities.add(aminity);
      }
    }
    allAminities = allAminities.toSet().toList();
    return allAminities;
  }

  Future<List<Hotel>> getHotelByPrice(String maxPrice, String minPrice) async {
    List<Hotel> propers = [];
    List<Hotel> hotels = await getHotels();
    for (Hotel hotel in hotels) {
      if (hotel.price >= double.parse(minPrice) &&
          hotel.price <= double.parse(maxPrice)) {
        propers.add(hotel);
      }
    }
    return propers;
  }
}
