import 'package:imtihon3/models/hotel.dart';
import 'package:imtihon3/services/auth_http_services.dart';
import 'package:imtihon3/services/hotel_http_services.dart';

class HotelController {
  HotelHttpServices authHttpServices = HotelHttpServices();
  Future<List<Hotel>> getHotels() async {
    return authHttpServices.getHotels();
  }
}